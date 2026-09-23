begin;

create table public.sites (
  id uuid primary key default gen_random_uuid(),
  site_code text not null unique,
  name text not null,
  category text not null check (category in ('indoor', 'outdoor')),
  water_type text not null,
  address text,
  latitude double precision not null check (latitude between -90 and 90),
  longitude double precision not null check (longitude between -180 and 180),
  active boolean not null default true
);

alter table public.sites enable row level security;

revoke all on table public.sites from public, anon, authenticated;

grant usage on schema public to anon, authenticated;
grant select on table public.sites to anon, authenticated;

create policy "Public read"
  on public.sites
  for select
  to anon, authenticated
  using (true);

commit;