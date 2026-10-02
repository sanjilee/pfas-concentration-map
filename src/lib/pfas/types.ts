export type SiteCategory = "indoor" | "outdoor";
export type Site = {
  id: string;
  site_code: string;
  name: string;
  category: SiteCategory;
  water_type: string;
  address: string | null;
  latitude: number;
  longitude: number;
};
export type Analyte = {
  id: string;
  code: string;
  full_name: string;
  display_order: number;
  default_unit?: string;
};
export type Measurement = {
  id: string;
  value: number | null;
  detected: boolean;
  unit: string;
  analytes: Analyte | null;
};
export type Sample = {
  id: string;
  sample_code: string;
  collected_on: string;
  measurements: Measurement[];
};
export type SiteDetail = Site & { samples: Sample[] };
export type Summary = {
  totalSamples: number;
  firstDate: string | null;
  lastDate: string | null;
};
export type ResultStatus = "detected" | "nd" | "missing" | "incomplete" | "unselected";
export type SampleResult = {
  sampleId: string;
  sampleCode: string;
  date: string;
  status: ResultStatus;
  value: number | null;
  available: number;
  expected: number;
};
