import Explorer from "../components/pfas/Explorer";

export default function Home() {
  return <main id="main-content">
    <section className="intro" aria-labelledby="page-title">
      <div><p className="eyebrow">UIUC CAMPUS PFAS WATER MONITORING INITIATIVE</p><h1 id="page-title">Explore the data. Understand the water around us.</h1></div>
      <p className="intro-copy">Select a point to explore detected PFAS and individual compounds. Concentrations are reported in nanograms per liter (ng/L).</p>
    </section>
    <Explorer />
  </main>;
}
