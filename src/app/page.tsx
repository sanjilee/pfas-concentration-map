import Explorer from "../components/pfas/Explorer";

export default function Home() {
  return <main id="main-content">
    <section className="intro" aria-labelledby="page-title">
      <div><h1 id="page-title">UIUC Campus PFAS Water Monitoring Initiative</h1><p className="eyebrow">Explore the data. Understand the water around us.</p></div>
      <p className="intro-copy">Select a point to explore detected PFAS and individual compounds. Concentrations are reported in nanograms per liter (ng/L).</p>
    </section>
    <Explorer />
  </main>;
}
