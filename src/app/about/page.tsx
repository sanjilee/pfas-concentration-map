import type { Metadata } from "next";
export const metadata: Metadata = { title: "About" };
export default function AboutPage() {
  return <main id="main-content" className="editorial-page">
    <p className="eyebrow">About the project</p><h1>Making campus water data easier to explore.</h1>
    <div className="editorial-grid">
      <p className="lede">From Tap to Tributary maps PFAS measurements across indoor drinking-water fixtures and outdoor water-sampling locations at the University of Illinois Urbana-Champaign.</p>
      <div className="prose">
        <h2>What we monitor</h2><p>Explore campus buildings, streams, and other outdoor sampling locations. Each location has a record of collection dates and individual compound results, so measurements can be reviewed across place and time.</p>
        <h2>How to use the explorer</h2><p>Choose a map point or use the location list. Search by name, site code, address, or water type. Filter indoor and outdoor locations, then use the measurement dropdown to inspect a compound or the PFAS overview.</p>
        <h2>Choose your overview</h2><p>All available compounds are selected initially. Open “Compounds in overview” to choose a subset. Your selection changes only your current view and resets when the page reloads.</p>
        <div className="notice"><strong>Reading the results</strong><p>The overview sums detected concentrations for the selected compounds within each sample. ND means not detected, not a measured zero. “No result” means no measurement is available. “Incomplete” means only some selected compounds have results; no total is shown for that sample.</p></div>
        <h2 className="about-spacing">Statistics and history</h2><p>Minimum, average, and maximum use detected results only. Overview statistics use complete samples with at least one detection. Chart lines stop at nondetects and unavailable results. Concentrations are displayed in ng/L; an overview sum is not a safety rating.</p>
      </div>
    </div>
  </main>;
}
