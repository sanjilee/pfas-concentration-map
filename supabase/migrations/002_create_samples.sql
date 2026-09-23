begin;

create table public.samples (
  id uuid primary key default gen_random_uuid(),
  site_id uuid not null references public.sites(id),
  sample_code text not null unique,
  collected_on date not null,
  notes text
);

create index samples_site_date_idx
  on public.samples (site_id, collected_on desc);

alter table public.samples enable row level security;

revoke all on table public.samples from public, anon, authenticated;

grant select on table public.samples to anon, authenticated;

create policy "Public read"
  on public.samples
  for select
  to anon, authenticated
  using (true);

commit;