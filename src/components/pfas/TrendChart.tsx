import { useId } from "react";
import type { SampleResult } from "../../lib/pfas/types";
import { dateTimestamp, formatDate, formatValue } from "../../lib/pfas/calculations";

export default function TrendChart({ results, label }: { results: SampleResult[]; label: string }) {
  const titleId = useId();
  const available = results.filter(r => r.status === "detected" && r.value !== null);
  if (!available.length) return <div className="chart-empty">No detected values to plot for this selection.</div>;
  const left = 48, right = 408, top = 18, bottom = 142;
  const start = dateTimestamp(results[0].date), end = dateTimestamp(results[results.length - 1].date);
  const max = Math.max(...available.map(r => r.value!));
  const high = max === 0 ? 1 : max * 1.2;
  const x = (date: string) => start === end ? (left + right) / 2 : left + (dateTimestamp(date) - start) / (end - start) * (right - left);
  const y = (value: number) => bottom - value / high * (bottom - top);
  // Start a new segment after every ND, missing result, or incomplete overview.
  const segments: string[][] = [];
  let segment: string[] = [];
  for (const result of results) {
    if (result.status !== "detected" || result.value === null) {
      if (segment.length) segments.push(segment);
      segment = [];
    } else segment.push(`${x(result.date)},${y(result.value)}`);
  }
  if (segment.length) segments.push(segment);
  return <svg className="trend-chart" viewBox="0 0 420 180" role="img" aria-labelledby={titleId}>
    <title id={titleId}>{label} in ng/L over time. Only detections are plotted; gaps indicate unavailable values or nondetects. Exact results are in the history table.</title>
    {[0, 0.5, 1].map(fraction => <g key={fraction}>
      <line className="chart-grid" x1={left} x2={right} y1={y(high * fraction)} y2={y(high * fraction)} />
      <text className="chart-label" textAnchor="end" x={left - 8} y={y(high * fraction) + 3}>{formatValue(Number((high * fraction).toPrecision(2)))}</text>
    </g>)}
    <text className="chart-label" x={left} y="10">ng/L</text>
    {segments.filter(points => points.length > 1).map((points, i) => <polyline key={i} className="chart-line" points={points.join(" ")} />)}
    {available.map(result => <circle key={result.sampleId} className="chart-dot" cx={x(result.date)} cy={y(result.value!)} r="4">
      <title>{formatDate(result.date)} · {result.sampleCode}: {formatValue(result.value)} ng/L</title>
    </circle>)}
    <text className="chart-label" x={left} y="168">{formatDate(results[0].date, true)}</text>
    {start !== end && <text className="chart-label" textAnchor="end" x={right} y="168">{formatDate(results[results.length - 1].date, true)}</text>}
  </svg>;
}
