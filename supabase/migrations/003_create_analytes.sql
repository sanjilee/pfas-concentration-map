begin;

create table public.analytes (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  full_name text not null,
  default_unit text not null default 'ng/L'
    check (default_unit = 'ng/L'),
  display_order integer not null unique
    check (display_order > 0)
);

alter table public.analytes enable row level security;

revoke all on table public.analytes from public, anon, authenticated;

grant select on table public.analytes to anon, authenticated;

create policy "Public read"
  on public.analytes
  for select
  to anon, authenticated
  using (true);

commit;