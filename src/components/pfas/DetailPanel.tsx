import type { Analyte, SiteDetail } from "../../lib/pfas/types";
import { formatDate, formatValue, getSeries, resultLabel, statistics } from "../../lib/pfas/calculations";
import TrendChart from "./TrendChart";

type Props = {
  site: SiteDetail;
  analytes: Analyte[];
  compound: string;
  onCompound: (code: string) => void;
  selectedCodes: string[];
  onSelectedCodes: (codes: string[]) => void;
  onClose: () => void;
};
export default function DetailPanel({ site, analytes, compound, onCompound, selectedCodes, onSelectedCodes, onClose }: Props) {
  const overview = compound === "overview";
  const analyte = analytes.find(item => item.code === compound);
  const label = overview ? "PFAS overview" : analyte?.code ?? compound;
  const results = getSeries(site.samples, compound, selectedCodes);
  const latest = results.at(-1);
  const first = results[0];
  const stats = statistics(results);
  const change = results.length > 1 && latest?.status === "detected" && first?.status === "detected" ? latest.value! - first.value! : null;
  function toggle(code: string) {
    onSelectedCodes(selectedCodes.includes(code) ? selectedCodes.filter(c => c !== code) : [...selectedCodes, code]);
  }
  return <div className="site-detail">
    <div className="detail-heading">
      <div><p className="eyebrow">{site.category} · {site.water_type}</p><h2 id="detail-title">{site.name}</h2><p className="address">{site.address || "Address not provided"}</p><p className="site-code">{site.site_code}</p></div>
      <button className="icon-button" onClick={onClose} type="button" aria-label="Close site details">×</button>
    </div>
    <div className="analyte-control">
      <label htmlFor="analyte-select">View measurement</label>
      <select id="analyte-select" value={compound} onChange={e => onCompound(e.target.value)}>
        <option value="overview">PFAS overview</option>
        {analytes.map(item => <option key={item.id} value={item.code}>{item.code}</option>)}
      </select>
      <small>{overview ? `Sum of detected concentrations for ${selectedCodes.length} selected compounds.` : analyte?.full_name}</small>
    </div>
    {overview && <details className="overview-options">
      <summary>Compounds in overview <span>{selectedCodes.length} / {analytes.length}</span></summary>
      <div className="selection-actions"><button type="button" onClick={() => onSelectedCodes(analytes.map(a => a.code))}>Select all</button><button type="button" onClick={() => onSelectedCodes([])}>Clear selection</button></div>
      <fieldset><legend className="sr-only">Compounds included in the PFAS overview</legend><div className="compound-grid">
        {analytes.map(item => <label key={item.id}><input type="checkbox" checked={selectedCodes.includes(item.code)} onChange={() => toggle(item.code)} />{item.code}</label>)}
      </div></fieldset>
      <p className="data-note">Changes apply only to your view. Samples with missing selected results are marked incomplete.</p>
    </details>}
    {overview && !selectedCodes.length && <p className="inline-notice" role="status">Select at least one compound to calculate an overview.</p>}
    <div className="latest-card" aria-live="polite" aria-atomic="true">
      <div><small>Latest {label}</small><strong className={latest?.status !== "detected" ? "text-result" : undefined}>
        {latest ? resultLabel(latest, overview) : "No samples"}{latest?.status === "detected" && <> <em>ng/L</em></>}
      </strong><span>{latest ? `Collected ${formatDate(latest.date)}` : "No collection dates available"}</span></div>
      {change !== null && <span className="trend-badge" title="Latest minus earliest sample result; not a safety assessment">{change > 0 ? "+" : ""}{formatValue(change)} ng/L</span>}
    </div>
    {latest?.status === "incomplete" && <p className="inline-notice">{latest.available} of {latest.expected} selected compounds have results in this sample. A total is not shown.</p>}
    {latest?.status === "missing" && <p className="data-note">No result was recorded for this selection in the latest sample. Missing results are not nondetects.</p>}
    <div className="chart-card"><div className="section-label"><span>Measurement history</span><span>{results.length} samples · {stats.count} plotted</span></div><TrendChart results={results} label={label} /></div>
    <div className="summary-grid" aria-label="Detected measurement statistics">
      {[["Minimum", stats.min], ["Average", stats.average], ["Maximum", stats.max]].map(([name, value]) => <div key={String(name)}><small>{name}</small><strong>{formatValue(value as number | null)}</strong><span>ng/L</span></div>)}
    </div>
    <p className="data-note">{overview ? "Statistics use complete samples with at least one detection for the selected compounds." : "Statistics use detected measurements only; ND and missing results are excluded."}</p>
    <div className="history">
      <div className="section-label"><span>All samples</span><span>{label}</span></div>
      <div className="table-wrap"><table>
        <caption className="sr-only">Complete available {label} history for {site.name}</caption>
        <thead><tr><th scope="col">Collection date</th><th scope="col">Result</th></tr></thead>
        <tbody>{results.length ? [...results].reverse().map(result => <tr key={result.sampleId}>
          <td>{formatDate(result.date)}<small className="sample-code">{result.sampleCode}</small></td>
          <td>{resultLabel(result, overview)}{result.status === "detected" && " ng/L"}{result.status === "incomplete" && <small className="sample-code">{result.available}/{result.expected} results</small>}</td>
        </tr>) : <tr><td colSpan={2} className="empty-table">No samples have been recorded at this location.</td></tr>}</tbody>
      </table></div>
      <p className="data-note">ND means not detected. No result means a measurement is unavailable. Nondetects are not plotted as zero. Overview sums are not safety ratings.</p>
    </div>
  </div>;
}
