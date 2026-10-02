import type { Measurement, Sample, SampleResult } from "./types";

// A usable result is a finite detection or an explicit nondetect, always in ng/L.
function validResult(measurement: Measurement | undefined): measurement is Measurement {
  return !!measurement && measurement.unit === "ng/L" && (
    measurement.detected
      ? typeof measurement.value === "number" && Number.isFinite(measurement.value) && measurement.value >= 0
      : measurement.value === null
  );
}

/** Single source of truth for the visitor-selected PFAS overview.
 * Never turn missing results or nondetects into measured zeros.
 * A partial sample has no comparable total until all selected analytes have results.
 */
export function calculateOverview(sample: Sample, selectedCodes: readonly string[]): SampleResult {
  const codes = [...new Set(selectedCodes)];
  const results = codes.map(code => sample.measurements.find(m => m.analytes?.code === code));
  const available = results.filter(validResult);
  const base = { sampleId: sample.id, sampleCode: sample.sample_code, date: sample.collected_on, available: available.length, expected: codes.length };
  if (!codes.length) return { ...base, status: "unselected", value: null };
  if (!available.length) return { ...base, status: "missing", value: null };
  if (available.length < codes.length) return { ...base, status: "incomplete", value: null };
  const detections = available.filter(m => m.detected);
  if (!detections.length) return { ...base, status: "nd", value: null };
  return { ...base, status: "detected", value: detections.reduce((sum, m) => sum + m.value!, 0) };
}

export function compoundResult(sample: Sample, code: string): SampleResult {
  const m = sample.measurements.find(item => item.analytes?.code === code);
  const base = { sampleId: sample.id, sampleCode: sample.sample_code, date: sample.collected_on, expected: 1 };
  if (!validResult(m)) return { ...base, available: 0, status: "missing", value: null };
  return { ...base, available: 1, status: m.detected ? "detected" : "nd", value: m.value };
}

export function getSeries(samples: Sample[], compound: string, selectedCodes: readonly string[]): SampleResult[] {
  return [...samples].sort((a, b) => a.collected_on.localeCompare(b.collected_on) || a.sample_code.localeCompare(b.sample_code))
    .map(sample => compound === "overview" ? calculateOverview(sample, selectedCodes) : compoundResult(sample, compound));
}

export function statistics(results: SampleResult[]) {
  const values = results.filter(r => r.status === "detected" && r.value !== null).map(r => r.value!);
  return {
    count: values.length,
    min: values.length ? Math.min(...values) : null,
    average: values.length ? values.reduce((sum, value) => sum + value, 0) / values.length : null,
    max: values.length ? Math.max(...values) : null,
  };
}

// UTC at both parsing and formatting prevents date-only values shifting a day.
export function dateTimestamp(date: string) { return Date.parse(`${date}T00:00:00Z`); }
export function formatDate(date: string, compact = false) {
  return new Intl.DateTimeFormat("en-US", { timeZone: "UTC", month: "short", day: "numeric", ...(compact ? {} : { year: "numeric" }) }).format(dateTimestamp(date));
}
export function formatValue(value: number | null) {
  if (value === null || !Number.isFinite(value)) return "—";
  if (value !== 0 && Math.abs(value) < 0.001) return value.toExponential(2);
  return new Intl.NumberFormat("en-US", { maximumSignificantDigits: 6 }).format(value);
}
export function resultLabel(result: SampleResult, overview = false) {
  switch (result.status) {
    case "detected": return formatValue(result.value);
    case "nd": return overview ? "No detections" : "ND";
    case "incomplete": return "Incomplete";
    case "unselected": return "Select compounds";
    default: return "No result";
  }
}
