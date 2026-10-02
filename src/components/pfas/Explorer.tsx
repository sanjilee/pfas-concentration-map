"use client";

import dynamic from "next/dynamic";
import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { getJSON } from "../../lib/pfas/api";
import { formatDate } from "../../lib/pfas/calculations";
import type { Analyte, Site, SiteCategory, SiteDetail, Summary } from "../../lib/pfas/types";
import DetailPanel from "./DetailPanel";

const CampusMap = dynamic(() => import("./CampusMap"), { ssr: false, loading: () => <div className="map-loading" role="status">Loading campus map…</div> });
type Dataset = { sites: Site[]; analytes: Analyte[]; summary: Summary | null };
type LoadState = { status: "loading" } | { status: "error"; message: string } | { status: "ready"; dataset: Dataset };
type DetailState = { code: string; status: "loading" } | { code: string; status: "error"; message: string } | { code: string; status: "ready"; site: SiteDetail };
const EMPTY_SITES: Site[] = [];
function matches(site: Site, search: string, category: "all" | SiteCategory) {
  return (category === "all" || site.category === category) && `${site.name} ${site.site_code} ${site.address ?? ""} ${site.water_type}`.toLowerCase().includes(search.trim().toLowerCase());
}

export default function Explorer() {
  const [load, setLoad] = useState<LoadState>({ status: "loading" });
  const [attempt, setAttempt] = useState(0);
  const [search, setSearch] = useState("");
  const [category, setCategory] = useState<"all" | SiteCategory>("all");
  const [selectedCode, setSelectedCode] = useState<string | null>(null);
  const [compound, setCompound] = useState("overview");
  const [selectedCodes, setSelectedCodes] = useState<string[] | null>(null);
  const [detail, setDetail] = useState<DetailState | null>(null);
  const [detailAttempt, setDetailAttempt] = useState(0);
  const panel = useRef<HTMLElement>(null);

  useEffect(() => {
    const controller = new AbortController();
    async function loadDataset() {
      try {
        const [sites, analytes, summary] = await Promise.all([
          getJSON<{ sites: Site[] }>("/api/sites", controller.signal),
          getJSON<{ analytes: Analyte[] }>("/api/analytes", controller.signal),
          getJSON<{ summary: Summary }>("/api/summary", controller.signal).catch(() => null),
        ]);
        if (!Array.isArray(sites.sites) || !Array.isArray(analytes.analytes)) throw new Error("Unexpected response from the explorer API.");
        if (!controller.signal.aborted) setLoad({ status: "ready", dataset: { sites: sites.sites, analytes: [...analytes.analytes].sort((a, b) => a.display_order - b.display_order), summary: summary?.summary ?? null } });
      } catch (error) {
        if (!controller.signal.aborted) setLoad({ status: "error", message: error instanceof Error ? error.message : "Unable to load sampling data." });
      }
    }
    void loadDataset();
    return () => controller.abort();
  }, [attempt]);

  useEffect(() => {
    if (!selectedCode) return;
    const controller = new AbortController();
    const code = selectedCode;
    async function loadDetail() {
      try {
        const response = await getJSON<{ site: SiteDetail }>(`/api/sites/${encodeURIComponent(code)}`, controller.signal);
        if (!response.site || !Array.isArray(response.site.samples)) throw new Error("Unexpected site detail response.");
        if (!controller.signal.aborted) setDetail({ code, status: "ready", site: response.site });
      } catch (error) {
        if (!controller.signal.aborted) setDetail({ code, status: "error", message: error instanceof Error ? error.message : "Unable to load site details." });
      }
    }
    void loadDetail();
    return () => controller.abort();
  }, [selectedCode, detailAttempt]);

  const sites = load.status === "ready" ? load.dataset.sites : EMPTY_SITES;
  const visible = useMemo(() => sites.filter(site => matches(site, search, category)), [sites, search, category]);
  const selectSite = useCallback((code: string) => {
    setSelectedCode(code);
    // Loading is rendered from the requested code, so previous-site results cannot flash.
    if (window.matchMedia("(max-width: 960px)").matches) {
      requestAnimationFrame(() => panel.current?.scrollIntoView({ behavior: window.matchMedia("(prefers-reduced-motion: reduce)").matches ? "auto" : "smooth", block: "start" }));
    }
  }, []);
  function closeDetail() { setSelectedCode(null); setDetail(null); }
  function updateSearch(value: string) {
    setSearch(value);
    if (selectedCode && !sites.some(s => s.site_code === selectedCode && matches(s, value, category))) closeDetail();
  }
  function updateCategory(value: "all" | SiteCategory) {
    setCategory(value);
    if (selectedCode && !sites.some(s => s.site_code === selectedCode && matches(s, search, value))) closeDetail();
  }
  function retryDataset() { setLoad({ status: "loading" }); setAttempt(n => n + 1); }
  function retryDetail() { if (selectedCode) { setDetail({ code: selectedCode, status: "loading" }); setDetailAttempt(n => n + 1); } }
  const summary = load.status === "ready" ? load.dataset.summary : null;
  const analytes = load.status === "ready" ? load.dataset.analytes : [];
  const effectiveCodes = selectedCodes ?? analytes.map(a => a.code);
  const indoor = sites.filter(site => site.category === "indoor").length;
  const activeDetail = detail?.code === selectedCode ? detail : null;

  return <>
    <section className="metrics" aria-label="Dataset summary">
      <div><span>{load.status === "ready" ? sites.length : "—"}</span><small>sampling sites</small></div>
      <div><span>{summary?.totalSamples ?? "—"}</span><small>total samples</small></div>
      <div><span className="date-range">{summary?.firstDate && summary.lastDate ? summary.firstDate === summary.lastDate ? formatDate(summary.firstDate) : `${formatDate(summary.firstDate)} – ${formatDate(summary.lastDate)}` : summary ? "No samples yet" : "—"}</span><small>collection period</small></div>
      <div className="status"><span className="status-pill">{load.status === "ready" ? `${analytes.length} compounds` : "Campus monitoring"}</span><small>concentrations in ng/L</small></div>
    </section>
    {load.status === "ready" && !summary && <div className="summary-warning" role="status">Summary unavailable. The map and site records are still available. <button className="text-button" type="button" onClick={retryDataset}>Retry</button></div>}
    <section className="explorer" aria-label="PFAS sampling map and site details">
      <div className="map-pane">
        <div className="toolbar">
          <label className="search-field"><span className="sr-only">Search sampling sites</span>
            <svg aria-hidden="true" viewBox="0 0 24 24"><path d="m21 21-4.3-4.3m2.3-5.2a7.5 7.5 0 1 1-15 0 7.5 7.5 0 0 1 15 0Z" /></svg>
            <input type="search" placeholder="Search site or address" value={search} onChange={e => updateSearch(e.target.value)} onKeyDown={e => { if (e.key === "Enter" && visible[0]) selectSite(visible[0].site_code); }} />
          </label>
          <div className="filter-group" role="group" aria-label="Filter by site type">
            {(["all", "indoor", "outdoor"] as const).map(value => <button type="button" key={value} className={`filter${category === value ? " active" : ""}`} aria-pressed={category === value} onClick={() => updateCategory(value)}>
              {value !== "all" && <i className={`dot ${value}`} />}{value === "all" ? "All" : value === "indoor" ? "Indoor" : "Outdoor"}<span>{value === "all" ? sites.length : value === "indoor" ? indoor : sites.length - indoor}</span>
            </button>)}
          </div>
        </div>
        <CampusMap sites={visible} selectedCode={selectedCode} onSelect={selectSite} />
        {load.status === "loading" && <div className="map-status" role="status">Loading sampling locations…</div>}
        {load.status === "error" && <div className="map-status" role="alert"><p>{load.message}</p><button className="primary-button" onClick={retryDataset} type="button">Try again</button></div>}
        {load.status === "ready" && <div className="site-list-area">
          {!sites.length ? <p role="status">No active sampling locations have been added yet.</p> : <>
            <p className="match-count" role="status">{visible.length} of {sites.length} locations shown</p>
            {!visible.length && <p>No locations match. <button className="text-button" type="button" onClick={() => { updateSearch(""); updateCategory("all"); }}>Clear filters</button></p>}
            {!!visible.length && <details className="site-list" open={search.trim() ? true : undefined}><summary>Browse locations</summary><ul>{visible.map(site => <li key={site.id}><button type="button" aria-pressed={site.site_code === selectedCode} onClick={() => selectSite(site.site_code)}><i className={`dot ${site.category}`} /><span>{site.name}<small>{site.site_code} · {site.water_type}</small></span><span aria-hidden="true">↗</span></button></li>)}</ul></details>}
          </>}
        </div>}
      </div>
      <aside ref={panel} className="detail-panel" aria-label="Selected location details" aria-busy={!!selectedCode && (!activeDetail || activeDetail.status === "loading")}>
        {!selectedCode ? <div className="empty-state"><div className="empty-orbit" aria-hidden="true"><span /></div><p className="eyebrow">Site details</p><h2>Choose a point on the map</h2><p>You’ll see its latest result, change over time, summary statistics, and every recorded sample here.</p><div className="empty-legend"><span><i className="dot indoor" />{indoor} indoor sites</span><span><i className="dot outdoor" />{sites.length - indoor} outdoor sites</span></div></div>
        : !activeDetail || activeDetail.status === "loading" ? <div className="panel-message"><button className="icon-button" type="button" onClick={closeDetail} aria-label="Close site details">×</button><p role="status">Loading location details…</p></div>
        : activeDetail.status === "error" ? <div className="panel-message"><button className="icon-button" type="button" onClick={closeDetail} aria-label="Close site details">×</button><p role="alert">{activeDetail.message}</p><button className="primary-button" type="button" onClick={retryDetail}>Try again</button></div>
        : <DetailPanel site={activeDetail.site} analytes={analytes} compound={compound} onCompound={setCompound} selectedCodes={effectiveCodes} onSelectedCodes={setSelectedCodes} onClose={closeDetail} />}
      </aside>
    </section>
  </>;
}
