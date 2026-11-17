"use client";

import { createClient } from "@supabase/supabase-js";
import { useEffect, useRef, useState } from "react";
import type { FormEvent } from "react";
import { adminError, measurementPayload } from "../../lib/pfas/admin";
import type { ResultInput } from "../../lib/pfas/admin";

type Site = { id: string; site_code: string; name: string; category: string; water_type: string; address: string | null; latitude: number; longitude: number; active: boolean; revision: number };
type Analyte = { id: string; code: string };
type Sample = { id: string; site_id: string; sample_code: string; collected_on: string; notes: string | null; revision: number; measurements: { analyte_id: string; detected: boolean; value: number | null }[] };
type SampleDraft = { id: string | null; revision: number | null; site_id: string; sample_code: string; collected_on: string; notes: string; rows: ResultInput[] };
type SiteDraft = { id: string | null; revision: number | null; site_code: string; name: string; category: string; water_type: string; address: string; latitude: string; longitude: string; active: boolean };

export default function AdminDashboard({ url, publicKey }: { url: string; publicKey: string }) {
  const [supabase] = useState(() => createClient(url, publicKey, { auth: {
    storage: typeof window === "undefined" ? undefined : window.sessionStorage,
    persistSession: true, autoRefreshToken: true, detectSessionInUrl: false,
  } }));
  const [userId, setUserId] = useState<string | null>(null);
  const [checking, setChecking] = useState(true);
  const [editor, setEditor] = useState(false);
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState("");
  const [notice, setNotice] = useState("");
  const [sites, setSites] = useState<Site[]>([]);
  const [analytes, setAnalytes] = useState<Analyte[]>([]);
  const [samples, setSamples] = useState<Sample[]>([]);
  const [siteFilter, setSiteFilter] = useState("");
  const [page, setPage] = useState(0);
  const [total, setTotal] = useState(0);
  const [refresh, setRefresh] = useState(0);
  const [loadedKey, setLoadedKey] = useState("");
  const requestKey = `${userId}:${page}:${siteFilter}:${refresh}`;
  const loading = editor && loadedKey !== requestKey;
  const identity = useRef<string | null>(null);
  const [sampleDraft, setSampleDraft] = useState<SampleDraft | null>(null);
  const [siteDraft, setSiteDraft] = useState<SiteDraft | null>(null);
  const [deleting, setDeleting] = useState<Sample | null>(null);
  const [deleteCode, setDeleteCode] = useState("");

  useEffect(() => {
    let alive = true;
    const { data: { subscription } } = supabase.auth.onAuthStateChange((_event, session) => {
      if (!alive) return;
      const id = session?.user.id ?? null;
      if (id !== identity.current || _event === "INITIAL_SESSION") {
        identity.current = id;
        setEditor(false); setSampleDraft(null); setSiteDraft(null); setDeleting(null); setSamples([]);
        setPage(0); setSiteFilter(""); setUserId(id); setChecking(id !== null);
      }
    });
    return () => { alive = false; subscription.unsubscribe(); };
  }, [supabase]);

  useEffect(() => {
    let alive = true;
    if (!userId) return;
    void Promise.resolve(supabase.rpc("is_pfas_editor")).then(({ data, error: failure }) => {
      if (!alive) return;
      setEditor(data === true && !failure);
      setChecking(false);
      if (failure) setError(adminError(failure));
    }).catch(() => { if (alive) { setChecking(false); setError("Unable to check access. Sign out and try again."); } });
    return () => { alive = false; };
  }, [supabase, userId]);

  useEffect(() => {
    if (!editor) return;
    let alive = true;
    let query = supabase.from("samples").select("id,site_id,sample_code,collected_on,notes,revision,measurements(analyte_id,detected,value)", { count: "exact" }).order("collected_on", { ascending: false }).order("id").range(page * 25, page * 25 + 24);
    if (siteFilter) query = query.eq("site_id", siteFilter);
    void Promise.all([
      supabase.from("sites").select("*").order("name"),
      supabase.from("analytes").select("id,code").order("display_order"), query,
    ]).then(([siteResult, analyteResult, sampleResult]) => {
      if (!alive) return;
      setLoadedKey(requestKey);
      const failure = siteResult.error || analyteResult.error || sampleResult.error;
      if (failure) { setError(adminError(failure)); return; }
      setSites(siteResult.data ?? []); setAnalytes(analyteResult.data ?? []);
      setSamples(sampleResult.data ?? []); setTotal(sampleResult.count ?? 0);
    }).catch(() => { if (alive) { setLoadedKey(requestKey); setError("Could not load records. Check your connection and reload."); } });
    return () => { alive = false; };
  }, [editor, supabase, page, siteFilter, refresh, requestKey]);

  async function login(event: FormEvent) {
    event.preventDefault(); setBusy(true); setError(""); setNotice("");
    try {
      const { error: failure } = await supabase.auth.signInWithPassword({ email: email.trim(), password });
      if (failure) setError("Sign-in failed. Check your email and password, or contact the project administrator.");
      else setPassword("");
    } catch { setError("Unable to sign in. Check your connection."); }
    finally { setBusy(false); }
  }

  async function logout() {
    setBusy(true); setError("");
    try {
      const { error: failure } = await supabase.auth.signOut({ scope: "local" });
      if (failure) setError("Unable to sign out. Try again.");
      else { setUserId(null); setEditor(false); setNotice(""); }
    } catch { setError("Unable to sign out. Check your connection and try again."); }
    finally { setBusy(false); }
  }

  function openSample(sample?: Sample) {
    setError(""); setNotice(""); setSiteDraft(null); setDeleting(null);
    setSampleDraft({ id: sample?.id ?? null, revision: sample?.revision ?? null,
      site_id: sample?.site_id ?? siteFilter ?? "", sample_code: sample?.sample_code ?? "",
      collected_on: sample?.collected_on ?? "", notes: sample?.notes ?? "",
      rows: analytes.map(a => { const m = sample?.measurements.find(m => m.analyte_id === a.id);
        return { analyte_id: a.id, status: !m ? "missing" : m.detected ? "detected" : "nd", value: m?.value == null ? "" : String(m.value) }; }),
    });
  }

  function openSite(site?: Site) {
    setError(""); setNotice(""); setSampleDraft(null); setDeleting(null);
    setSiteDraft({ id: site?.id ?? null, revision: site?.revision ?? null, site_code: site?.site_code ?? "", name: site?.name ?? "", category: site?.category ?? "indoor", water_type: site?.water_type ?? "", address: site?.address ?? "", latitude: site ? String(site.latitude) : "", longitude: site ? String(site.longitude) : "", active: site?.active ?? true });
  }

  async function saveSample(event: FormEvent) {
    event.preventDefault(); if (!sampleDraft) return;
    let measurements;
    try { measurements = measurementPayload(sampleDraft.rows); }
    catch (failure) { setError((failure as Error).message); return; }
    setBusy(true); setError(""); setNotice("");
    try {
      const { error: failure } = await supabase.rpc("admin_save_sample", {
        p_id: sampleDraft.id, p_revision: sampleDraft.revision, p_site_id: sampleDraft.site_id,
        p_sample_code: sampleDraft.sample_code.trim(), p_collected_on: sampleDraft.collected_on,
        p_notes: sampleDraft.notes, p_measurements: measurements,
      });
      if (failure) setError(adminError(failure));
      else { setSampleDraft(null); setRefresh(n => n + 1); setNotice("Sample saved. Refresh the public explorer to see the updated results."); }
    } catch { setError("Connection interrupted. Reload the list to check whether the save completed before retrying."); }
    finally { setBusy(false); }
  }

  async function saveSite(event: FormEvent) {
    event.preventDefault(); if (!siteDraft) return;
    setBusy(true); setError(""); setNotice("");
    try {
      const { error: failure } = await supabase.rpc("admin_save_site", {
        p_id: siteDraft.id, p_revision: siteDraft.revision, p_site_code: siteDraft.site_code.trim(),
        p_name: siteDraft.name.trim(), p_category: siteDraft.category, p_water_type: siteDraft.water_type.trim(),
        p_address: siteDraft.address, p_latitude: Number(siteDraft.latitude), p_longitude: Number(siteDraft.longitude), p_active: siteDraft.active,
      });
      if (failure) setError(adminError(failure));
      else { setSiteDraft(null); setRefresh(n => n + 1); setNotice("Site saved. Refresh the public explorer to see the update."); }
    } catch { setError("Connection interrupted. Reload the list to check whether the save completed before retrying."); }
    finally { setBusy(false); }
  }

  async function deleteSample(event: FormEvent) {
    event.preventDefault(); if (!deleting || deleteCode !== deleting.sample_code) return;
    setBusy(true); setError(""); setNotice("");
    try {
      const { error: failure } = await supabase.rpc("admin_delete_sample", { p_id: deleting.id, p_revision: deleting.revision });
      if (failure) setError(adminError(failure));
      else { setDeleting(null); setPage(0); setRefresh(n => n + 1); setNotice("Sample and its measurements deleted."); }
    } catch { setError("Connection interrupted. Reload to check whether the deletion completed."); }
    finally { setBusy(false); }
  }

  return <>
    <div className="admin-heading"><div><p className="eyebrow">Research team</p><h1>Manage sampling data</h1></div>{userId && <button onClick={logout} disabled={busy}>Sign out</button>}</div>
    {error && <p className="admin-error" role="alert">{error}</p>}
    {notice && <p className="admin-notice" role="status">{notice}</p>}
    {checking ? <p role="status">Checking access…</p> : !userId ?
      <form className="admin-card admin-login" onSubmit={login}><h2>Team sign-in</h2><p>Access is limited to approved editors. Contact the project administrator for an account or password reset.</p>
        <label>Email<input type="email" autoComplete="username" required value={email} onChange={e => setEmail(e.target.value)} /></label>
        <label>Password<input type="password" autoComplete="current-password" required value={password} onChange={e => setPassword(e.target.value)} /></label>
        <button className="primary-button" disabled={busy}>{busy ? "Signing in…" : "Sign in"}</button>
      </form> : !editor ? <p>Your account does not have editor access. Ask the project administrator to approve it.</p> : <>
      <p>Changes are published immediately to the database. All concentrations are in ng/L. Notes are public data.</p>
      <fieldset disabled={busy || loading || !!sampleDraft || !!siteDraft || !!deleting} className="admin-toolbar">
        <label>Sampling site<select value={siteFilter} onChange={e => { setSiteFilter(e.target.value); setPage(0); }}><option value="">All sites</option>{sites.map(s => <option key={s.id} value={s.id}>{s.name}{s.active ? "" : " (inactive)"}</option>)}</select></label>
        <button onClick={() => openSample()} disabled={!sites.length || !analytes.length}>Add sample</button>
        <button onClick={() => openSite()}>Add site</button>
        <button onClick={() => openSite(sites.find(s => s.id === siteFilter))} disabled={!siteFilter}>Edit selected site</button>
        <button onClick={() => { setError(""); setRefresh(n => n + 1); }}>Reload list</button>
      </fieldset>

      {sampleDraft && <form className="admin-card" onSubmit={saveSample}><fieldset disabled={busy}><legend><h2>{sampleDraft.id ? "Edit sample" : "Add sample"}</h2></legend>
        <div className="admin-fields"><label>Site<select required value={sampleDraft.site_id} onChange={e => setSampleDraft({ ...sampleDraft, site_id: e.target.value })}><option value="">Choose a site</option>{sites.map(s => <option key={s.id} value={s.id}>{s.name}{s.active ? "" : " (inactive)"}</option>)}</select></label>
          <label>Unique sample code<input required maxLength={120} value={sampleDraft.sample_code} onChange={e => setSampleDraft({ ...sampleDraft, sample_code: e.target.value })} /></label>
          <label>Collection date<input required type="date" value={sampleDraft.collected_on} onChange={e => setSampleDraft({ ...sampleDraft, collected_on: e.target.value })} /></label></div>
        <label>Public notes<textarea maxLength={5000} value={sampleDraft.notes} onChange={e => setSampleDraft({ ...sampleDraft, notes: e.target.value })} /></label>
        <p>Choose ND only for an analyzed compound that was not detected. Leave unmeasured compounds as “No result”. Detected zero is a valid numeric result.</p>
        <div className="admin-results">{sampleDraft.rows.map((row, index) => <div key={row.analyte_id}>
          <label>{analytes.find(a => a.id === row.analyte_id)?.code}<select aria-label={`${analytes[index]?.code} result`} value={row.status} onChange={e => setSampleDraft({ ...sampleDraft, rows: sampleDraft.rows.map((r, i) => i === index ? { ...r, status: e.target.value as ResultInput["status"], value: "" } : r) })}><option value="missing">No result</option><option value="nd">ND</option><option value="detected">Detected</option></select></label>
          <label>Concentration (ng/L)<input aria-label={`${analytes[index]?.code} concentration (ng/L)`} type="number" min="0" step="any" required={row.status === "detected"} disabled={row.status !== "detected"} value={row.value} onChange={e => setSampleDraft({ ...sampleDraft, rows: sampleDraft.rows.map((r, i) => i === index ? { ...r, value: e.target.value } : r) })} /></label>
        </div>)}</div>
        <div className="admin-actions"><button className="primary-button">{busy ? "Saving…" : "Save sample"}</button><button type="button" onClick={() => setSampleDraft(null)}>Cancel</button></div>
      </fieldset></form>}

      {siteDraft && <form className="admin-card" onSubmit={saveSite}><fieldset disabled={busy}><legend><h2>{siteDraft.id ? "Edit site" : "Add site"}</h2></legend><div className="admin-fields">
        <label>Site code<input required maxLength={80} pattern="[a-z0-9][a-z0-9-]*" title="Lowercase letters, numbers and hyphens" value={siteDraft.site_code} onChange={e => setSiteDraft({ ...siteDraft, site_code: e.target.value })} /></label>
        <label>Name<input required maxLength={200} value={siteDraft.name} onChange={e => setSiteDraft({ ...siteDraft, name: e.target.value })} /></label>
        <label>Category<select value={siteDraft.category} onChange={e => setSiteDraft({ ...siteDraft, category: e.target.value })}><option value="indoor">Indoor</option><option value="outdoor">Outdoor</option></select></label>
        <label>Water type<input required maxLength={120} value={siteDraft.water_type} onChange={e => setSiteDraft({ ...siteDraft, water_type: e.target.value })} /></label>
        <label>Address<input maxLength={500} value={siteDraft.address} onChange={e => setSiteDraft({ ...siteDraft, address: e.target.value })} /></label>
        <label>Latitude<input required type="number" min="-90" max="90" step="any" value={siteDraft.latitude} onChange={e => setSiteDraft({ ...siteDraft, latitude: e.target.value })} /></label>
        <label>Longitude<input required type="number" min="-180" max="180" step="any" value={siteDraft.longitude} onChange={e => setSiteDraft({ ...siteDraft, longitude: e.target.value })} /></label>
      </div><label className="admin-checkbox"><input type="checkbox" checked={siteDraft.active} onChange={e => setSiteDraft({ ...siteDraft, active: e.target.checked })} />Show on the public map</label><p>Making a site inactive hides it from the explorer and preserves its samples. It does not make its data private.</p><div className="admin-actions"><button className="primary-button">{busy ? "Saving…" : "Save site"}</button><button type="button" onClick={() => setSiteDraft(null)}>Cancel</button></div></fieldset></form>}

      {deleting && <form className="admin-card" onSubmit={deleteSample}><h2>Delete {deleting.sample_code}?</h2><p>This permanently removes this sample and all its compound results. Other samples are preserved.</p><label>Type {deleting.sample_code} to confirm<input autoComplete="off" value={deleteCode} disabled={busy} onChange={e => setDeleteCode(e.target.value)} /></label><div className="admin-actions"><button disabled={busy || deleteCode !== deleting.sample_code}>Delete permanently</button><button type="button" disabled={busy} onClick={() => setDeleting(null)}>Cancel</button></div></form>}

      <section className="admin-card"><h2>Samples</h2>{loading ? <p role="status">Loading records…</p> : <><p>{total} samples · page {page + 1}</p><div className="table-wrap"><table><thead><tr><th>Sample / site</th><th>Date</th><th>Results</th><th>Actions</th></tr></thead><tbody>{samples.map(s => <tr key={s.id}><td>{s.sample_code}<small className="sample-code">{sites.find(site => site.id === s.site_id)?.name}</small></td><td>{s.collected_on}</td><td>{s.measurements.length} / {analytes.length}</td><td><button disabled={busy || !!sampleDraft || !!siteDraft || !!deleting} onClick={() => openSample(s)}>Edit</button> <button disabled={busy || !!sampleDraft || !!siteDraft || !!deleting} onClick={() => { setDeleting(s); setDeleteCode(""); setError(""); setNotice(""); }}>Delete</button></td></tr>)}</tbody></table></div>{!samples.length && <p>No samples found. Add a sample to start recording results.</p>}</>}
        <div className="admin-actions"><button disabled={page === 0 || busy || loading || !!sampleDraft || !!siteDraft || !!deleting} onClick={() => setPage(p => p - 1)}>Previous</button><button disabled={(page + 1) * 25 >= total || busy || loading || !!sampleDraft || !!siteDraft || !!deleting} onClick={() => setPage(p => p + 1)}>Next</button></div>
      </section>
    </>}
  </>;
}
