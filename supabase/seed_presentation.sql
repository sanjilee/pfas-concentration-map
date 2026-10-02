-- Optional presentation data from the supplied prototype.
-- Run in Supabase SQL Editor AFTER your existing four tables are in place.
-- Matches the FINAL schema: boolean detected, plain numeric, no detection_limit.
-- Existing matching sites, samples, and measurements are left unchanged.
begin;
insert into public.analytes (code, full_name, display_order) values ('PFBA', 'Perfluorobutanoic acid', 1) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFPeA', 'Perfluoropentanoic acid', 2) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFHxA', 'Perfluorohexanoic acid', 3) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFHpA', 'Perfluoroheptanoic acid', 4) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFOA', 'Perfluorooctanoic acid', 5) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFNA', 'Perfluorononanoic acid', 6) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFBS', 'Perfluorobutanesulfonic acid', 7) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFPeS', 'Perfluoropentanesulfonic acid', 8) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFHxS', 'Perfluorohexanesulfonic acid', 9) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFHpS', 'Perfluoroheptanesulfonic acid', 10) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFOS', 'Perfluorooctanesulfonic acid', 11) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('PFNS', 'Perfluorononanesulfonic acid', 12) on conflict (code) do nothing;
insert into public.analytes (code, full_name, display_order) values ('6:2 FTS', '6:2 fluorotelomer sulfonate', 13) on conflict (code) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-istc', 'Illinois Sustainable Technology center', 'indoor', 'drinking water', '1 Hazelwood Dr, Champaign, IL 61820', 40.090211, -88.242473) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-04-10', '2026-04-10'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.3, true),
('PFPeA', 1.02, true),
('PFHxA', NULL, false),
('PFHpA', 0.88, true),
('PFOA', 1.09, true),
('PFNA', 1.02, true),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-04-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-05-11', '2026-05-11'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.3, true),
('PFPeA', 1.01, true),
('PFHxA', NULL, false),
('PFHpA', 0.88, true),
('PFOA', 1.09, true),
('PFNA', 1.02, true),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-05-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-06-15', '2026-06-15'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.3, true),
('PFPeA', 1.02, true),
('PFHxA', NULL, false),
('PFHpA', 0.88, true),
('PFOA', 1.09, true),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-06-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-07-15', '2026-07-15'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.3, true),
('PFPeA', 1.02, true),
('PFHxA', NULL, false),
('PFHpA', 0.88, true),
('PFOA', 1.09, true),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-07-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-08-10', '2026-08-10'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.3, true),
('PFPeA', 1.01, true),
('PFHxA', NULL, false),
('PFHpA', 0.89, true),
('PFOA', 1.1, true),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.78, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-08-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-09-10', '2026-09-10'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.31, true),
('PFPeA', 1.01, true),
('PFHxA', NULL, false),
('PFHpA', 0.89, true),
('PFOA', 1.1, true),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.78, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-09-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-istc-2026-10-11', '2026-10-11'::date from public.sites where site_code = 'in-istc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.31, true),
('PFPeA', 1.01, true),
('PFHxA', NULL, false),
('PFHpA', 0.89, true),
('PFOA', 1.09, true),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-istc-2026-10-11' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-turner', 'Turner Hall', 'indoor', 'drinking water', '1102 S Goodwin Ave, Urbana, IL 61801', 40.102932, -88.224315) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-04-14', '2026-04-14'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', 0.27, true),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-04-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-05-15', '2026-05-15'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', 0.27, true),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-05-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-06-13', '2026-06-13'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.7, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', 0.27, true),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-06-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-07-14', '2026-07-14'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', 0.27, true),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-07-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-08-10', '2026-08-10'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', NULL, false),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-08-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-09-11', '2026-09-11'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.48, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', NULL, false),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-09-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-turner-2026-10-12', '2026-10-12'::date from public.sites where site_code = 'in-turner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', 0.71, true),
('PFHxA', 0.69, true),
('PFHpA', 0.49, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', NULL, false),
('PFHxS', 0.31, true),
('PFHpS', NULL, false),
('PFOS', 0.27, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-turner-2026-10-12' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-cee', 'Civil and Environmental Engineering (CEE) Building', 'indoor', 'drinking water', '205 N Mathews Ave, Urbana, IL 61801', 40.11424, -88.226514) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-04-12', '2026-04-12'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.27, true),
('PFPeA', 0.93, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.64, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.43, true),
('PFNS', 0.44, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-04-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-05-13', '2026-05-13'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.28, true),
('PFPeA', 0.92, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.55, true),
('PFHpS', NULL, false),
('PFOS', 0.43, true),
('PFNS', 0.44, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-05-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-06-12', '2026-06-12'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.27, true),
('PFPeA', 0.92, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.43, true),
('PFNS', 0.44, true),
('6:2 FTS', 0.33, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-06-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-07-10', '2026-07-10'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.27, true),
('PFPeA', 0.92, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.42, true),
('PFNS', 0.44, true),
('6:2 FTS', 0.33, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-07-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-08-14', '2026-08-14'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.27, true),
('PFPeA', 0.93, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.42, true),
('PFNS', 0.44, true),
('6:2 FTS', 0.33, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-08-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.27, true),
('PFPeA', 0.93, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.42, true),
('PFNS', 0.44, true),
('6:2 FTS', 0.33, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cee-2026-10-12', '2026-10-12'::date from public.sites where site_code = 'in-cee' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.26, true),
('PFPeA', 0.93, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.42, true),
('PFNS', 0.44, true),
('6:2 FTS', 0.32, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cee-2026-10-12' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-ece', 'Electrical and Computer Engineering Building', 'indoor', 'drinking water', '306 N Wright St MC 702, Urbana, IL 61801', 40.115211, -88.228193) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-04-12', '2026-04-12'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.93, true),
('PFHxA', 1.73, true),
('PFHpA', NULL, false),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 1.18, true),
('PFPeS', NULL, false),
('PFHxS', 0.82, true),
('PFHpS', NULL, false),
('PFOS', 0.75, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-04-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-05-15', '2026-05-15'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.93, true),
('PFHxA', 1.73, true),
('PFHpA', NULL, false),
('PFOA', 1.1, true),
('PFNA', NULL, false),
('PFBS', 1.18, true),
('PFPeS', NULL, false),
('PFHxS', 0.82, true),
('PFHpS', NULL, false),
('PFOS', 0.75, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-05-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-06-15', '2026-06-15'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.92, true),
('PFHxA', 1.73, true),
('PFHpA', NULL, false),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 1.19, true),
('PFPeS', NULL, false),
('PFHxS', 0.82, true),
('PFHpS', NULL, false),
('PFOS', 0.74, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-06-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-07-12', '2026-07-12'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.92, true),
('PFHxA', 1.73, true),
('PFHpA', NULL, false),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 1.19, true),
('PFPeS', NULL, false),
('PFHxS', 0.82, true),
('PFHpS', NULL, false),
('PFOS', 0.74, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-07-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-08-11', '2026-08-11'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.94, true),
('PFHxA', 1.74, true),
('PFHpA', NULL, false),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 1.19, true),
('PFPeS', NULL, false),
('PFHxS', 0.81, true),
('PFHpS', NULL, false),
('PFOS', 0.74, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-08-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.94, true),
('PFHxA', 1.74, true),
('PFHpA', NULL, false),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 1.19, true),
('PFPeS', NULL, false),
('PFHxS', 0.82, true),
('PFHpS', NULL, false),
('PFOS', 0.74, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-ece-2026-10-15', '2026-10-15'::date from public.sites where site_code = 'in-ece' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 1.93, true),
('PFHxA', 1.74, true),
('PFHpA', NULL, false),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 1.19, true),
('PFPeS', NULL, false),
('PFHxS', 0.81, true),
('PFHpS', NULL, false),
('PFOS', 0.74, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-ece-2026-10-15' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-grainger', 'Grainger Engineering Library', 'indoor', 'drinking water', '1301 W Springfield Ave, Urbana, IL 61801', 40.112658, -88.22692) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-04-12', '2026-04-12'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.47, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-04-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-05-12', '2026-05-12'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.47, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-05-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-06-15', '2026-06-15'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.69, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.48, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-06-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-07-14', '2026-07-14'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.48, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-07-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-08-14', '2026-08-14'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.47, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-08-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-09-11', '2026-09-11'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.54, true),
('PFNA', NULL, false),
('PFBS', 0.47, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-09-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-grainger-2026-10-12', '2026-10-12'::date from public.sites where site_code = 'in-grainger' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.7, true),
('PFPeA', NULL, false),
('PFHxA', 0.62, true),
('PFHpA', NULL, false),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 0.47, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-grainger-2026-10-12' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-union', 'Illini Union', 'indoor', 'drinking water', '1401 W Green St, Urbana, IL 61801', 40.109391, -88.227201) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-04-14', '2026-04-14'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.52, true),
('PFHxA', 0.43, true),
('PFHpA', 0.62, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', 0.27, true),
('PFOS', 0.29, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-04-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-05-12', '2026-05-12'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.52, true),
('PFHxA', 0.43, true),
('PFHpA', 0.62, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', 0.27, true),
('PFOS', 0.28, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-05-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-06-10', '2026-06-10'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.52, true),
('PFHxA', 0.43, true),
('PFHpA', 0.62, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.32, true),
('PFHpS', 0.27, true),
('PFOS', 0.28, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-06-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-07-10', '2026-07-10'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.52, true),
('PFHxA', 0.43, true),
('PFHpA', 0.62, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', 0.27, true),
('PFOS', 0.28, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-07-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-08-13', '2026-08-13'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.52, true),
('PFHxA', 0.66, true),
('PFHpA', 0.61, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', NULL, false),
('PFOS', 0.29, true),
('PFNS', NULL, false),
('6:2 FTS', 0.21, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-08-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-09-11', '2026-09-11'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.51, true),
('PFHxA', 0.42, true),
('PFHpA', 0.61, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', 0.28, true),
('PFOS', 0.29, true),
('PFNS', NULL, false),
('6:2 FTS', 0.21, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-09-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-union-2026-10-14', '2026-10-14'::date from public.sites where site_code = 'in-union' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.52, true),
('PFPeA', 0.51, true),
('PFHxA', 0.42, true),
('PFHpA', 0.61, true),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', 0.33, true),
('PFHpS', NULL, false),
('PFOS', 0.29, true),
('PFNS', NULL, false),
('6:2 FTS', 0.21, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-union-2026-10-14' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-arc', 'Activities & Recreation Center', 'indoor', 'drinking water', '201 E Peabody Dr, Champaign, IL 61820', 40.101491, -88.235984) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-04-15', '2026-04-15'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.63, true),
('PFPeA', 0.77, true),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.5, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-04-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-05-15', '2026-05-15'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.63, true),
('PFPeA', 0.77, true),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.5, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-05-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-06-12', '2026-06-12'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.63, true),
('PFPeA', 0.77, true),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.5, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-06-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-07-15', '2026-07-15'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.63, true),
('PFPeA', 0.77, true),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.5, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-07-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-08-12', '2026-08-12'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', NULL, false),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.49, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-08-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', NULL, false),
('PFHxA', 0.66, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.49, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-arc-2026-10-13', '2026-10-13'::date from public.sites where site_code = 'in-arc' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.64, true),
('PFPeA', NULL, false),
('PFHxA', 0.67, true),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', 0.48, true),
('PFHxS', 0.49, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-arc-2026-10-13' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('in-cif', 'Campus Instructional facility', 'indoor', 'drinking water', '1405 W Springfield Ave, Urbana, IL 61801', 40.112628, -88.228342) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-04-11', '2026-04-11'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.46, true),
('PFPeA', NULL, false),
('PFHxA', 1.09, true),
('PFHpA', 1.18, true),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 0.64, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.47, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-04-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-05-10', '2026-05-10'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.46, true),
('PFPeA', NULL, false),
('PFHxA', 1.09, true),
('PFHpA', 1.18, true),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.47, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-05-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-06-10', '2026-06-10'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.46, true),
('PFPeA', NULL, false),
('PFHxA', 1.09, true),
('PFHpA', 1.17, true),
('PFOA', 1.11, true),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.71, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.48, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-06-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-07-11', '2026-07-11'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.45, true),
('PFPeA', NULL, false),
('PFHxA', 1.09, true),
('PFHpA', 1.17, true),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 0.71, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.47, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-07-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-08-13', '2026-08-13'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.47, true),
('PFPeA', NULL, false),
('PFHxA', 1.1, true),
('PFHpA', 1.19, true),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.48, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-08-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.47, true),
('PFPeA', NULL, false),
('PFHxA', 1.1, true),
('PFHpA', 1.18, true),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.48, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'in-cif-2026-10-13', '2026-10-13'::date from public.sites where site_code = 'in-cif' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.46, true),
('PFPeA', NULL, false),
('PFHxA', 1.1, true),
('PFHpA', 1.18, true),
('PFOA', 1.12, true),
('PFNA', NULL, false),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', 0.48, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'in-cif-2026-10-13' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-up', 'Boneyard Creek (up stream) - 2nd Street Basin', 'outdoor', 'surface water', '200 E Stoughton St, Champaign, IL 61820', 40.113651, -88.23682) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-04-10', '2026-04-10'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1, true),
('PFPeA', 0.77, true),
('PFHxA', 0.6, true),
('PFHpA', 0.31, true),
('PFOA', 0.61, true),
('PFNA', NULL, false),
('PFBS', 1.9, true),
('PFPeS', NULL, false),
('PFHxS', 0.54, true),
('PFHpS', NULL, false),
('PFOS', 0.7, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-04-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-05-10', '2026-05-10'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.16, true),
('PFPeA', 0.75, true),
('PFHxA', 0.68, true),
('PFHpA', 0.38, true),
('PFOA', 0.67, true),
('PFNA', NULL, false),
('PFBS', 2.15, true),
('PFPeS', NULL, false),
('PFHxS', 0.55, true),
('PFHpS', NULL, false),
('PFOS', 0.63, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-05-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-06-14', '2026-06-14'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.01, true),
('PFPeA', 0.66, true),
('PFHxA', 0.59, true),
('PFHpA', 0.33, true),
('PFOA', 0.58, true),
('PFNA', NULL, false),
('PFBS', 1.87, true),
('PFPeS', NULL, false),
('PFHxS', 0.48, true),
('PFHpS', NULL, false),
('PFOS', 0.55, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-06-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-07-15', '2026-07-15'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.24, true),
('PFPeA', 0.81, true),
('PFHxA', 0.73, true),
('PFHpA', 0.41, true),
('PFOA', 0.72, true),
('PFNA', NULL, false),
('PFBS', 2.3, true),
('PFPeS', NULL, false),
('PFHxS', 0.59, true),
('PFHpS', NULL, false),
('PFOS', 0.68, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-07-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-08-12', '2026-08-12'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.95, true),
('PFPeA', 0.61, true),
('PFHxA', 0.56, true),
('PFHpA', 0.31, true),
('PFOA', 0.55, true),
('PFNA', NULL, false),
('PFBS', 1.74, true),
('PFPeS', NULL, false),
('PFHxS', 0.44, true),
('PFHpS', NULL, false),
('PFOS', 0.51, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-08-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.11, true),
('PFPeA', 0.71, true),
('PFHxA', 0.66, true),
('PFHpA', 0.37, true),
('PFOA', 0.64, true),
('PFNA', NULL, false),
('PFBS', 2.04, true),
('PFPeS', NULL, false),
('PFHxS', 0.52, true),
('PFHpS', NULL, false),
('PFOS', 0.6, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-up-2026-10-15', '2026-10-15'::date from public.sites where site_code = 'out-up' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.98, true),
('PFPeA', 0.63, true),
('PFHxA', 0.58, true),
('PFHpA', 0.32, true),
('PFOA', 0.57, true),
('PFNA', NULL, false),
('PFBS', 1.8, true),
('PFPeS', NULL, false),
('PFHxS', 0.46, true),
('PFHpS', NULL, false),
('PFOS', 0.53, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-up-2026-10-15' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-mid', 'Boneyard Creek (middle stream) - Engineering quad', 'outdoor', 'surface water', '1301 W Springfield Ave, Urbana, IL 61801', 40.11265, -88.226792) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-04-14', '2026-04-14'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.94, true),
('PFPeA', 0.9, true),
('PFHxA', 0.72, true),
('PFHpA', 0.34, true),
('PFOA', 0.85, true),
('PFNA', NULL, false),
('PFBS', 1.6, true),
('PFPeS', NULL, false),
('PFHxS', 0.91, true),
('PFHpS', NULL, false),
('PFOS', 0.95, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-04-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-05-14', '2026-05-14'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.02, true),
('PFPeA', 0.87, true),
('PFHxA', 0.91, true),
('PFHpA', 0.34, true),
('PFOA', 0.91, true),
('PFNA', NULL, false),
('PFBS', 1.8, true),
('PFPeS', NULL, false),
('PFHxS', 0.83, true),
('PFHpS', 0.32, true),
('PFOS', 0.85, true),
('PFNS', 0.6, true),
('6:2 FTS', 0.37, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-05-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-06-15', '2026-06-15'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.88, true),
('PFPeA', 0.76, true),
('PFHxA', 0.79, true),
('PFHpA', 0.3, true),
('PFOA', 0.79, true),
('PFNA', NULL, false),
('PFBS', 1.58, true),
('PFPeS', NULL, false),
('PFHxS', 0.73, true),
('PFHpS', 0.33, true),
('PFOS', 0.74, true),
('PFNS', 0.61, true),
('6:2 FTS', 0.37, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-06-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-07-15', '2026-07-15'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.09, true),
('PFPeA', 0.94, true),
('PFHxA', 0.97, true),
('PFHpA', 0.37, true),
('PFOA', 0.98, true),
('PFNA', NULL, false),
('PFBS', 1.94, true),
('PFPeS', NULL, false),
('PFHxS', 0.9, true),
('PFHpS', 0.33, true),
('PFOS', 0.91, true),
('PFNS', 0.61, true),
('6:2 FTS', 0.37, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-07-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-08-11', '2026-08-11'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.83, true),
('PFPeA', 0.71, true),
('PFHxA', 0.74, true),
('PFHpA', 0.28, true),
('PFOA', 0.74, true),
('PFNA', NULL, false),
('PFBS', 1.46, true),
('PFPeS', NULL, false),
('PFHxS', 0.67, true),
('PFHpS', 0.33, true),
('PFOS', 0.69, true),
('PFNS', 0.59, true),
('6:2 FTS', 0.36, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-08-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-09-11', '2026-09-11'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.97, true),
('PFPeA', 0.84, true),
('PFHxA', 0.87, true),
('PFHpA', 0.33, true),
('PFOA', 0.87, true),
('PFNA', NULL, false),
('PFBS', 1.71, true),
('PFPeS', NULL, false),
('PFHxS', 0.79, true),
('PFHpS', 0.33, true),
('PFOS', 0.81, true),
('PFNS', 0.59, true),
('6:2 FTS', 0.36, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-09-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-mid-2026-10-14', '2026-10-14'::date from public.sites where site_code = 'out-mid' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 0.86, true),
('PFPeA', 0.74, true),
('PFHxA', 0.77, true),
('PFHpA', 0.29, true),
('PFOA', 0.77, true),
('PFNA', NULL, false),
('PFBS', 1.52, true),
('PFPeS', NULL, false),
('PFHxS', 0.7, true),
('PFHpS', 0.34, true),
('PFOS', 0.71, true),
('PFNS', NULL, false),
('6:2 FTS', 0.37, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-mid-2026-10-14' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-dwn', 'Boneyard Creek (down stream) - Busey Woods', 'outdoor', 'surface water', '1505 N Broadway Ave, Urbana, IL 61801', 40.127325, -88.209562) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-04-13', '2026-04-13'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.47, true),
('PFHxA', 0.43, true),
('PFHpA', NULL, false),
('PFOA', 0.47, true),
('PFNA', 0.83, true),
('PFBS', 0.54, true),
('PFPeS', NULL, false),
('PFHxS', 0.93, true),
('PFHpS', NULL, false),
('PFOS', 1.1, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-04-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-05-12', '2026-05-12'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.44, true),
('PFHxA', 0.55, true),
('PFHpA', NULL, false),
('PFOA', 0.5, true),
('PFNA', 0.97, true),
('PFBS', 0.65, true),
('PFPeS', NULL, false),
('PFHxS', 1.02, true),
('PFHpS', NULL, false),
('PFOS', 1.38, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-05-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-06-12', '2026-06-12'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.38, true),
('PFHxA', 0.47, true),
('PFHpA', NULL, false),
('PFOA', 0.43, true),
('PFNA', 0.85, true),
('PFBS', 0.56, true),
('PFPeS', NULL, false),
('PFHxS', 0.89, true),
('PFHpS', NULL, false),
('PFOS', 1.2, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-06-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-07-11', '2026-07-11'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.47, true),
('PFHxA', 0.59, true),
('PFHpA', NULL, false),
('PFOA', 0.53, true),
('PFNA', 1.05, true),
('PFBS', 0.69, true),
('PFPeS', NULL, false),
('PFHxS', 1.1, true),
('PFHpS', NULL, false),
('PFOS', 1.48, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-07-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-08-10', '2026-08-10'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.36, true),
('PFHxA', 0.44, true),
('PFHpA', NULL, false),
('PFOA', 0.4, true),
('PFNA', 0.8, true),
('PFBS', 0.53, true),
('PFPeS', NULL, false),
('PFHxS', 0.84, true),
('PFHpS', NULL, false),
('PFOS', 1.13, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-08-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-09-13', '2026-09-13'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.42, true),
('PFHxA', 0.52, true),
('PFHpA', NULL, false),
('PFOA', 0.47, true),
('PFNA', 0.93, true),
('PFBS', 0.62, true),
('PFPeS', NULL, false),
('PFHxS', 0.98, true),
('PFHpS', NULL, false),
('PFOS', 1.32, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-09-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dwn-2026-10-14', '2026-10-14'::date from public.sites where site_code = 'out-dwn' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', NULL, false),
('PFPeA', 0.37, true),
('PFHxA', 0.46, true),
('PFHpA', NULL, false),
('PFOA', 0.42, true),
('PFNA', 0.83, true),
('PFBS', 0.55, true),
('PFPeS', NULL, false),
('PFHxS', 0.87, true),
('PFHpS', NULL, false),
('PFOS', 1.17, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dwn-2026-10-14' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-dorner', 'Dorner Drive playing fields', 'outdoor', 'surface water', 'near Urbana fire station 4 – campus & Allen Hall', 40.103286, -88.221549) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-04-13', '2026-04-13'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.2, true),
('PFPeA', 0.76, true),
('PFHxA', 0.76, true),
('PFHpA', 0.42, true),
('PFOA', 1.4, true),
('PFNA', 11, true),
('PFBS', 0.56, true),
('PFPeS', 0.73, true),
('PFHxS', 0.83, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-04-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-05-11', '2026-05-11'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.33, true),
('PFPeA', 0.76, true),
('PFHxA', 0.81, true),
('PFHpA', 0.5, true),
('PFOA', 1.54, true),
('PFNA', 12.91, true),
('PFBS', 0.65, true),
('PFPeS', 0.89, true),
('PFHxS', 0.92, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-05-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-06-14', '2026-06-14'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.16, true),
('PFPeA', 0.66, true),
('PFHxA', 0.71, true),
('PFHpA', 0.44, true),
('PFOA', 1.34, true),
('PFNA', 11.22, true),
('PFBS', 0.57, true),
('PFPeS', 0.77, true),
('PFHxS', 0.81, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-06-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-07-11', '2026-07-11'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.43, true),
('PFPeA', 0.82, true),
('PFHxA', 0.87, true),
('PFHpA', 0.54, true),
('PFOA', 1.65, true),
('PFNA', 13.83, true),
('PFBS', 0.7, true),
('PFPeS', 0.95, true),
('PFHxS', 0.99, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-07-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-08-15', '2026-08-15'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.09, true),
('PFPeA', 0.62, true),
('PFHxA', 0.67, true),
('PFHpA', 0.41, true),
('PFOA', 1.26, true),
('PFNA', 10.48, true),
('PFBS', 0.53, true),
('PFPeS', 0.72, true),
('PFHxS', 0.75, true),
('PFHpS', NULL, false),
('PFOS', 0.49, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-08-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-09-15', '2026-09-15'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.28, true),
('PFPeA', 0.73, true),
('PFHxA', 0.78, true),
('PFHpA', 0.48, true),
('PFOA', 1.47, true),
('PFNA', 12.25, true),
('PFBS', 0.61, true),
('PFPeS', 0.84, true),
('PFHxS', 0.87, true),
('PFHpS', NULL, false),
('PFOS', 0.5, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-09-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-dorner-2026-10-15', '2026-10-15'::date from public.sites where site_code = 'out-dorner' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.13, true),
('PFPeA', 0.64, true),
('PFHxA', 0.69, true),
('PFHpA', 0.43, true),
('PFOA', 1.3, true),
('PFNA', 10.81, true),
('PFBS', 0.55, true),
('PFPeS', 0.74, true),
('PFHxS', 0.78, true),
('PFHpS', NULL, false),
('PFOS', 0.49, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-dorner-2026-10-15' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-ifsi', 'Illinois Fire Service Institute creek', 'outdoor', 'surface water', '11 Gerty Dr, Champaign, IL 61820', 40.086491, -88.244701) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-04-14', '2026-04-14'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.2, true),
('PFPeA', 0.68, true),
('PFHxA', 0.62, true),
('PFHpA', 0.31, true),
('PFOA', 0.58, true),
('PFNA', NULL, false),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.37, true),
('PFHpS', NULL, false),
('PFOS', 0.55, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-04-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-05-11', '2026-05-11'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.47, true),
('PFPeA', 0.64, true),
('PFHxA', 0.68, true),
('PFHpA', 0.31, true),
('PFOA', 0.63, true),
('PFNA', 0.25, true),
('PFBS', 1.05, true),
('PFPeS', NULL, false),
('PFHxS', 0.47, true),
('PFHpS', NULL, false),
('PFOS', 0.57, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-05-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-06-12', '2026-06-12'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.28, true),
('PFPeA', 0.55, true),
('PFHxA', 0.59, true),
('PFHpA', 0.27, true),
('PFOA', 0.55, true),
('PFNA', 0.25, true),
('PFBS', 0.92, true),
('PFPeS', NULL, false),
('PFHxS', 0.41, true),
('PFHpS', NULL, false),
('PFOS', 0.49, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-06-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-07-14', '2026-07-14'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.58, true),
('PFPeA', 0.68, true),
('PFHxA', 0.73, true),
('PFHpA', 0.33, true),
('PFOA', 0.67, true),
('PFNA', 0.25, true),
('PFBS', 1.14, true),
('PFPeS', NULL, false),
('PFHxS', 0.5, true),
('PFHpS', NULL, false),
('PFOS', 0.61, true),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-07-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-08-11', '2026-08-11'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.2, true),
('PFPeA', 0.52, true),
('PFHxA', 0.55, true),
('PFHpA', 0.25, true),
('PFOA', 0.51, true),
('PFNA', 0.26, true),
('PFBS', 0.85, true),
('PFPeS', NULL, false),
('PFHxS', 0.38, true),
('PFHpS', NULL, false),
('PFOS', 0.46, true),
('PFNS', 0.55, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-08-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-09-15', '2026-09-15'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.41, true),
('PFPeA', 0.6, true),
('PFHxA', 0.64, true),
('PFHpA', 0.29, true),
('PFOA', 0.59, true),
('PFNA', 0.26, true),
('PFBS', 1, true),
('PFPeS', NULL, false),
('PFHxS', 0.45, true),
('PFHpS', NULL, false),
('PFOS', 0.54, true),
('PFNS', 0.55, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-09-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-ifsi-2026-10-11', '2026-10-11'::date from public.sites where site_code = 'out-ifsi' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.24, true),
('PFPeA', 0.53, true),
('PFHxA', 0.57, true),
('PFHpA', 0.26, true),
('PFOA', 0.53, true),
('PFNA', 0.26, true),
('PFBS', 0.88, true),
('PFPeS', NULL, false),
('PFHxS', 0.4, true),
('PFHpS', NULL, false),
('PFOS', 0.48, true),
('PFNS', 0.56, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-ifsi-2026-10-11' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-swine', 'Swine Research Laboratory', 'outdoor', 'surface water', '301 Hazelwood Dr, Champaign, IL 61820', 40.089951, -88.237167) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-04-12', '2026-04-12'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 3.8, true),
('PFPeA', NULL, false),
('PFHxA', 1, true),
('PFHpA', 0.61, true),
('PFOA', 1.1, true),
('PFNA', 0.72, true),
('PFBS', 0.67, true),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', 4.8, true),
('PFNS', 0.49, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-04-12' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-05-11', '2026-05-11'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 4.16, true),
('PFPeA', 0.7, true),
('PFHxA', 1.17, true),
('PFHpA', 0.58, true),
('PFOA', 1.15, true),
('PFNA', 0.78, true),
('PFBS', 0.7, true),
('PFPeS', 0.45, true),
('PFHxS', NULL, false),
('PFHpS', 0.59, true),
('PFOS', 6.08, true),
('PFNS', 0.62, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-05-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-06-13', '2026-06-13'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 3.64, true),
('PFPeA', 0.69, true),
('PFHxA', 1.02, true),
('PFHpA', 0.51, true),
('PFOA', 1, true),
('PFNA', 0.68, true),
('PFBS', 0.61, true),
('PFPeS', 0.45, true),
('PFHxS', NULL, false),
('PFHpS', 0.59, true),
('PFOS', 5.3, true),
('PFNS', 0.54, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-06-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-07-11', '2026-07-11'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 4.48, true),
('PFPeA', 0.69, true),
('PFHxA', 1.26, true),
('PFHpA', 0.62, true),
('PFOA', 1.24, true),
('PFNA', 0.84, true),
('PFBS', 0.75, true),
('PFPeS', 0.45, true),
('PFHxS', NULL, false),
('PFHpS', 0.59, true),
('PFOS', 6.55, true),
('PFNS', 0.67, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-07-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-08-14', '2026-08-14'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 3.38, true),
('PFPeA', 0.69, true),
('PFHxA', 0.95, true),
('PFHpA', 0.47, true),
('PFOA', 0.94, true),
('PFNA', 0.64, true),
('PFBS', 0.58, true),
('PFPeS', 0.45, true),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', 4.93, true),
('PFNS', 0.51, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-08-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-09-11', '2026-09-11'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 3.95, true),
('PFPeA', 0.69, true),
('PFHxA', 1.11, true),
('PFHpA', 0.55, true),
('PFOA', 1.11, true),
('PFNA', 0.74, true),
('PFBS', 0.67, true),
('PFPeS', 0.46, true),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', 5.77, true),
('PFNS', 0.59, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-09-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-swine-2026-10-13', '2026-10-13'::date from public.sites where site_code = 'out-swine' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 3.5, true),
('PFPeA', 0.68, true),
('PFHxA', 0.98, true),
('PFHpA', 0.49, true),
('PFOA', 0.97, true),
('PFNA', 0.66, true),
('PFBS', 0.59, true),
('PFPeS', 0.46, true),
('PFHxS', NULL, false),
('PFHpS', 0.58, true),
('PFOS', 5.11, true),
('PFNS', 0.52, true),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-swine-2026-10-13' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-solarf', 'UIUC Solar Farm area', 'outdoor', 'surface water', 'Champaign Township, IL 61822', 40.089348, -88.329801) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-04-13', '2026-04-13'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 2, true),
('PFPeA', 2.4, true),
('PFHxA', 2.1, true),
('PFHpA', 1.5, true),
('PFOA', 2.3, true),
('PFNA', 7.8, true),
('PFBS', 16, true),
('PFPeS', 0.44, true),
('PFHxS', 7.6, true),
('PFHpS', NULL, false),
('PFOS', 12, true),
('PFNS', 0.42, true),
('6:2 FTS', 1.8, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-04-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-05-13', '2026-05-13'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 2.03, true),
('PFPeA', 2.86, true),
('PFHxA', 2.38, true),
('PFHpA', 1.39, true),
('PFOA', 2.16, true),
('PFNA', 7.1, true),
('PFBS', 19.03, true),
('PFPeS', 0.4, true),
('PFHxS', 9.11, true),
('PFHpS', 0.39, true),
('PFOS', 14.69, true),
('PFNS', 0.44, true),
('6:2 FTS', 1.78, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-05-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-06-15', '2026-06-15'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.77, true),
('PFPeA', 2.5, true),
('PFHxA', 2.06, true),
('PFHpA', 1.2, true),
('PFOA', 1.88, true),
('PFNA', 6.19, true),
('PFBS', 16.5, true),
('PFPeS', 0.35, true),
('PFHxS', 7.94, true),
('PFHpS', 0.39, true),
('PFOS', 12.83, true),
('PFNS', 0.38, true),
('6:2 FTS', 1.55, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-06-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-07-15', '2026-07-15'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 2.18, true),
('PFPeA', 3.08, true),
('PFHxA', 2.55, true),
('PFHpA', 1.49, true),
('PFOA', 2.31, true),
('PFNA', 7.65, true),
('PFBS', 20.39, true),
('PFPeS', 0.43, true),
('PFHxS', 9.81, true),
('PFHpS', 0.39, true),
('PFOS', 15.81, true),
('PFNS', 0.47, true),
('6:2 FTS', 1.92, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-07-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-08-10', '2026-08-10'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.66, true),
('PFPeA', 2.32, true),
('PFHxA', 1.95, true),
('PFHpA', 1.14, true),
('PFOA', 1.77, true),
('PFNA', 5.74, true),
('PFBS', 15.41, true),
('PFPeS', 0.33, true),
('PFHxS', 7.38, true),
('PFHpS', 0.4, true),
('PFOS', 11.92, true),
('PFNS', 0.36, true),
('6:2 FTS', 1.44, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-08-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-09-15', '2026-09-15'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.94, true),
('PFPeA', 2.72, true),
('PFHxA', 2.28, true),
('PFHpA', 1.33, true),
('PFOA', 2.07, true),
('PFNA', 6.73, true),
('PFBS', 18.06, true),
('PFPeS', 0.38, true),
('PFHxS', 8.65, true),
('PFHpS', 0.4, true),
('PFOS', 13.94, true),
('PFNS', 0.42, true),
('6:2 FTS', 1.69, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-09-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-solarf-2026-10-10', '2026-10-10'::date from public.sites where site_code = 'out-solarf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.72, true),
('PFPeA', 2.41, true),
('PFHxA', 2.01, true),
('PFHpA', 1.17, true),
('PFOA', 1.83, true),
('PFNA', 5.95, true),
('PFBS', 15.9, true),
('PFPeS', 0.34, true),
('PFHxS', 7.65, true),
('PFHpS', NULL, false),
('PFOS', 12.36, true),
('PFNS', 0.37, true),
('6:2 FTS', 1.49, true)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-solarf-2026-10-10' on conflict (sample_id, analyte_id) do nothing;

insert into public.sites (site_code, name, category, water_type, address, latitude, longitude) values ('out-southf', 'South Farm very far as background', 'outdoor', 'surface water', '1102 S Goodwin Ave, Urbana, IL 61801', 40.10364, -88.224179) on conflict (site_code) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-04-13', '2026-04-13'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.7, true),
('PFPeA', NULL, false),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', NULL, false),
('PFNA', NULL, false),
('PFBS', NULL, false),
('PFPeS', NULL, false),
('PFHxS', NULL, false),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-04-13' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-05-11', '2026-05-11'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 2.03, true),
('PFPeA', 0.61, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.34, true),
('PFNA', NULL, false),
('PFBS', 0.4, true),
('PFPeS', 0.33, true),
('PFHxS', 0.66, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-05-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-06-11', '2026-06-11'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.77, true),
('PFPeA', 0.61, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.34, true),
('PFNA', NULL, false),
('PFBS', 0.39, true),
('PFPeS', 0.33, true),
('PFHxS', 0.67, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-06-11' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-07-10', '2026-07-10'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 2.18, true),
('PFPeA', 0.61, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.34, true),
('PFNA', NULL, false),
('PFBS', 0.39, true),
('PFPeS', 0.33, true),
('PFHxS', 0.67, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-07-10' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-08-14', '2026-08-14'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.64, true),
('PFPeA', 0.6, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.35, true),
('PFNA', NULL, false),
('PFBS', 0.39, true),
('PFPeS', 0.34, true),
('PFHxS', 0.65, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-08-14' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-09-15', '2026-09-15'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.92, true),
('PFPeA', 0.6, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.35, true),
('PFNA', NULL, false),
('PFBS', 0.39, true),
('PFPeS', 0.34, true),
('PFHxS', 0.66, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-09-15' on conflict (sample_id, analyte_id) do nothing;
insert into public.samples (site_id, sample_code, collected_on) select id, 'out-southf-2026-10-10', '2026-10-10'::date from public.sites where site_code = 'out-southf' on conflict (sample_code) do nothing;
insert into public.measurements (sample_id, analyte_id, value, detected)
select s.id, a.id, v.value::numeric, v.detected from (values
('PFBA', 1.7, true),
('PFPeA', 0.61, true),
('PFHxA', NULL, false),
('PFHpA', NULL, false),
('PFOA', 0.35, true),
('PFNA', NULL, false),
('PFBS', 0.38, true),
('PFPeS', 0.34, true),
('PFHxS', 0.66, true),
('PFHpS', NULL, false),
('PFOS', NULL, false),
('PFNS', NULL, false),
('6:2 FTS', NULL, false)
) as v(code, value, detected) join public.analytes a on a.code = v.code join public.samples s on s.sample_code = 'out-southf-2026-10-10' on conflict (sample_id, analyte_id) do nothing;

commit;

-- Starting from the walkthrough dataset, expect 16 / 112 / 13 / 1456.
select
  (select count(*) from public.sites) as sites,
  (select count(*) from public.samples) as samples,
  (select count(*) from public.analytes) as analytes,
  (select count(*) from public.measurements) as measurements;
