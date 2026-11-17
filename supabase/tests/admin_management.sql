-- Run after all migrations, only in the isolated CI database.
begin;
insert into auth.users values ('00000000-0000-4000-8000-000000000001'), ('00000000-0000-4000-8000-000000000002');
insert into public.pfas_editors values ('00000000-0000-4000-8000-000000000001');
insert into public.sites(id,site_code,name,category,water_type,latitude,longitude)
values ('10000000-0000-4000-8000-000000000001','test-site','Test site','indoor','Tap',40,-88);
insert into public.analytes(id,code,full_name,display_order)
values ('20000000-0000-4000-8000-000000000001','PFBA','PFBA',1), ('20000000-0000-4000-8000-000000000002','PFOS','PFOS',2);

set local role anon;
do $$ begin
  perform * from public.sites;
  begin
    perform public.admin_delete_sample('30000000-0000-4000-8000-000000000001',0);
    raise exception 'Anonymous RPC was allowed';
  exception when insufficient_privilege then null; end;
  begin
    delete from public.samples;
    raise exception 'Anonymous direct delete was allowed';
  exception when insufficient_privilege then null; end;
end $$;
reset role;

set local role authenticated;
select set_config('request.jwt.claim.sub','00000000-0000-4000-8000-000000000002',true);
do $$ begin
  if public.is_pfas_editor() then raise exception 'Noneditor was recognized as editor'; end if;
  begin
    perform public.admin_save_sample(null,null,'10000000-0000-4000-8000-000000000001','blocked','2026-01-01',null,'[]');
    raise exception 'Noneditor RPC was allowed';
  exception when insufficient_privilege then null; end;
  begin
    perform public.admin_save_site(null,null,'blocked','Blocked','indoor','Tap',null,40,-88,true);
    raise exception 'Noneditor site RPC was allowed';
  exception when insufficient_privilege then null; end;
  begin
    insert into public.pfas_editors values (auth.uid());
    raise exception 'Self-promotion was allowed';
  exception when insufficient_privilege then null; end;
end $$;

select set_config('request.jwt.claim.sub','00000000-0000-4000-8000-000000000001',true);
do $$
declare v_sample_id uuid; site_id uuid; count_rows integer;
begin
  if not public.is_pfas_editor() then raise exception 'Editor was denied'; end if;
  site_id := public.admin_save_site(null,null,'new-site','New site','outdoor','Stream',null,40,-88,true);
  perform public.admin_save_site(site_id,0,'new-site','Updated site','outdoor','Stream',null,40,-88,false);
  if (select active from public.sites where id=site_id) then raise exception 'Site not archived'; end if;
  begin
    perform public.admin_save_site(site_id,0,'new-site','Stale edit','outdoor','Stream',null,40,-88,true);
    raise exception 'Stale site edit was allowed';
  exception when serialization_failure then null; end;
  v_sample_id := public.admin_save_sample(null,null,site_id,'sample-1','2026-01-01',null,
    '[{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":true,"value":0}, {"analyte_id":"20000000-0000-4000-8000-000000000002","detected":false,"value":null}]');
  if (select count(*) from public.measurements where public.measurements.sample_id=v_sample_id) <> 2 then
    raise exception 'Sample did not save its measurements';
  end if;
  begin
    perform public.admin_save_sample(v_sample_id,0,site_id,'bad-update','2026-01-02',null,
      '[{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":false,"value":4}]');
    raise exception 'Invalid ND accepted';
  exception when check_violation then null; end;
  if (select sample_code from public.samples where id=v_sample_id) <> 'sample-1' then raise exception 'Failed save changed sample'; end if;
  if (select count(*) from public.measurements m where m.sample_id=v_sample_id) <> 2 then raise exception 'Failed save lost measurements'; end if;
  begin
    perform public.admin_save_sample(null,null,site_id,'bad-insert','2026-01-01',null,
      '[{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":true,"value":-1}]');
    raise exception 'Negative value accepted';
  exception when check_violation then null; end;
  if exists(select 1 from public.samples where sample_code='bad-insert') then raise exception 'Failed insert left sample'; end if;
  begin
    perform public.admin_save_sample(v_sample_id,0,site_id,'sample-1','2026-01-01',null,
      '[{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":true,"value":"NaN"}]');
    raise exception 'Nonfinite value accepted';
  exception when check_violation then null; end;
  begin
    perform public.admin_save_sample(v_sample_id,0,site_id,'sample-1','2026-01-01',null,
      '[{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":false,"value":null},{"analyte_id":"20000000-0000-4000-8000-000000000001","detected":false,"value":null}]');
    raise exception 'Duplicate analyte accepted';
  exception when unique_violation then null; end;
  -- Removing a compound represents missing, not ND. Empty arrays are allowed.
  perform public.admin_save_sample(v_sample_id,0,site_id,'sample-1','2026-01-01',null,'[]');
  if exists(select 1 from public.measurements m where m.sample_id=v_sample_id) then raise exception 'Missing results retained'; end if;
  begin
    perform public.admin_save_sample(v_sample_id,0,site_id,'stale','2026-01-01',null,'[]');
    raise exception 'Stale sample edit accepted';
  exception when serialization_failure then null; end;
  begin
    perform public.admin_delete_sample(v_sample_id,0);
    raise exception 'Stale sample delete accepted';
  exception when serialization_failure then null; end;
  begin
    delete from public.samples where id=v_sample_id;
    raise exception 'Direct editor write bypassed RPC';
  exception when insufficient_privilege then null; end;
  perform public.admin_delete_sample(v_sample_id,1);
  if exists(select 1 from public.samples where id=v_sample_id) then raise exception 'Delete failed'; end if;
end $$;
reset role;
delete from public.pfas_editors;
set local role authenticated;
do $$ begin
  begin
    perform public.admin_delete_sample('30000000-0000-4000-8000-000000000001',0);
    raise exception 'Revoked editor retained access';
  exception when insufficient_privilege then null; end;
end $$;
rollback;
