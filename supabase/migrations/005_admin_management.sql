begin;

-- Membership is managed only by the database owner, never by a signed-in user.
create table public.pfas_editors (
  user_id uuid primary key references auth.users(id) on delete cascade
);
alter table public.pfas_editors enable row level security;
revoke all on public.pfas_editors from public, anon, authenticated;

create function public.is_pfas_editor() returns boolean
language sql stable security definer set search_path = ''
as $$ select exists (select 1 from public.pfas_editors where user_id = auth.uid()) $$;
revoke all on function public.is_pfas_editor() from public, anon;
grant execute on function public.is_pfas_editor() to authenticated;

alter table public.samples add column revision integer not null default 0;
alter table public.sites add column revision integer not null default 0;

-- Retain public SELECT policies, and prohibit direct writes for API roles.
-- Only the narrowly scoped, authorization-checked functions below can write.
alter table public.sites enable row level security;
alter table public.samples enable row level security;
alter table public.measurements enable row level security;
alter table public.analytes enable row level security;
revoke insert, update, delete, truncate, references, trigger
  on public.sites, public.samples, public.measurements, public.analytes
  from public, anon, authenticated;

create function public.admin_save_sample(
  p_id uuid, p_revision integer, p_site_id uuid, p_sample_code text,
  p_collected_on date, p_notes text, p_measurements jsonb
) returns uuid
language plpgsql security definer set search_path = '' as $$
declare saved_id uuid; current_revision integer;
begin
  if not public.is_pfas_editor() then
    raise exception 'Editor access required' using errcode = '42501';
  end if;
  if p_sample_code is null or length(btrim(p_sample_code)) not between 1 and 120
    or p_collected_on is null or length(coalesce(p_notes, '')) > 5000 then
    raise exception 'Invalid sample fields' using errcode = '22023';
  end if;
  if p_measurements is null or jsonb_typeof(p_measurements) <> 'array' then
    raise exception 'Measurements must be an array' using errcode = '22023';
  end if;
  if jsonb_array_length(p_measurements) > 1000 then
    raise exception 'Too many measurements' using errcode = '22023';
  end if;
  if p_id is null then
    insert into public.samples(site_id, sample_code, collected_on, notes)
    values(p_site_id, btrim(p_sample_code), p_collected_on, nullif(btrim(p_notes), ''))
    returning id into saved_id;
  else
    select revision into current_revision from public.samples where id = p_id for update;
    if not found then raise exception 'Sample no longer exists' using errcode = 'P0002'; end if;
    if p_revision is distinct from current_revision then
      raise exception 'Sample changed; reload before saving' using errcode = '40001';
    end if;
    update public.samples set site_id = p_site_id, sample_code = btrim(p_sample_code),
      collected_on = p_collected_on, notes = nullif(btrim(p_notes), ''), revision = revision + 1
      where id = p_id;
    saved_id := p_id;
    delete from public.measurements where sample_id = saved_id;
  end if;
  -- Constraints reject duplicates, unknown analytes, negative/nonfinite values,
  -- detected nulls, and ND with a value. Any failure rolls back the entire save.
  insert into public.measurements(sample_id, analyte_id, value, detected, unit)
    select saved_id, m.analyte_id, m.value, m.detected, 'ng/L'
    from jsonb_to_recordset(p_measurements) as m(analyte_id uuid, value numeric, detected boolean);
  return saved_id;
end $$;

create function public.admin_delete_sample(p_id uuid, p_revision integer) returns void
language plpgsql security definer set search_path = '' as $$
declare current_revision integer;
begin
  if not public.is_pfas_editor() then
    raise exception 'Editor access required' using errcode = '42501';
  end if;
  select revision into current_revision from public.samples where id = p_id for update;
  if not found then raise exception 'Sample no longer exists' using errcode = 'P0002'; end if;
  if p_revision is distinct from current_revision then
    raise exception 'Sample changed; reload before deleting' using errcode = '40001';
  end if;
  delete from public.measurements where sample_id = p_id;
  delete from public.samples where id = p_id;
end $$;

create function public.admin_save_site(
  p_id uuid, p_revision integer, p_site_code text, p_name text,
  p_category text, p_water_type text, p_address text,
  p_latitude double precision, p_longitude double precision, p_active boolean
) returns uuid
language plpgsql security definer set search_path = '' as $$
declare saved_id uuid; current_revision integer;
begin
  if not public.is_pfas_editor() then
    raise exception 'Editor access required' using errcode = '42501';
  end if;
  if p_site_code is null or p_site_code !~ '^[a-z0-9][a-z0-9-]{0,79}$'
    or p_name is null or length(btrim(p_name)) not between 1 and 200
    or p_water_type is null or length(btrim(p_water_type)) not between 1 and 120
    or length(coalesce(p_address, '')) > 500 then
    raise exception 'Invalid site fields' using errcode = '22023';
  end if;
  if p_id is null then
    insert into public.sites(site_code, name, category, water_type, address, latitude, longitude, active)
    values(p_site_code, btrim(p_name), p_category, btrim(p_water_type), nullif(btrim(p_address), ''),
      p_latitude, p_longitude, p_active) returning id into saved_id;
  else
    select revision into current_revision from public.sites where id = p_id for update;
    if not found then raise exception 'Site no longer exists' using errcode = 'P0002'; end if;
    if p_revision is distinct from current_revision then
      raise exception 'Site changed; reload before saving' using errcode = '40001';
    end if;
    update public.sites set site_code = p_site_code, name = btrim(p_name), category = p_category,
      water_type = btrim(p_water_type), address = nullif(btrim(p_address), ''), latitude = p_latitude,
      longitude = p_longitude, active = p_active, revision = revision + 1 where id = p_id;
    saved_id := p_id;
  end if;
  return saved_id;
end $$;

revoke all on function public.admin_save_sample(uuid, integer, uuid, text, date, text, jsonb) from public, anon;
revoke all on function public.admin_delete_sample(uuid, integer) from public, anon;
revoke all on function public.admin_save_site(uuid, integer, text, text, text, text, text, double precision, double precision, boolean) from public, anon;
grant execute on function public.admin_save_sample(uuid, integer, uuid, text, date, text, jsonb) to authenticated;
grant execute on function public.admin_delete_sample(uuid, integer) to authenticated;
grant execute on function public.admin_save_site(uuid, integer, text, text, text, text, text, double precision, double precision, boolean) to authenticated;

commit;
