begin;

create table public.measurements (
  id uuid primary key default gen_random_uuid(),
  sample_id uuid not null references public.samples(id),
  analyte_id uuid not null references public.analytes(id),
  value numeric,
  detected boolean not null,
  unit text not null default 'ng/L'
    check (unit = 'ng/L'),

  constraint measurements_sample_analyte_unique
    unique (sample_id, analyte_id),

  constraint measurements_result_valid
    check (
      (detected = false and value is null)
      or
      (
        detected = true
        and value is not null
        and value >= 0
        and value < 'Infinity'::numeric
      )
    )
);

create index measurements_analyte_idx
  on public.measurements (analyte_id);

alter table public.measurements enable row level security;

revoke all on table public.measurements
  from public, anon, authenticated;

grant select on table public.measurements
  to anon, authenticated;

create policy "Public read"
  on public.measurements
  for select
  to anon, authenticated
  using (true);

commit;