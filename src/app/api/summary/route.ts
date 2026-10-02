import { createSupabaseClient } from "../../../lib/supabase";

export async function GET() {
  try {
    const supabase = createSupabaseClient();
    // Count and date bounds cover all active-site samples, not only returned API rows.
    const [count, first, last] = await Promise.all([
      supabase.from("samples").select("id, sites!inner(active)", { count: "exact", head: true }).eq("sites.active", true),
      supabase.from("samples").select("collected_on, sites!inner(active)").eq("sites.active", true).order("collected_on", { ascending: true }).limit(1),
      supabase.from("samples").select("collected_on, sites!inner(active)").eq("sites.active", true).order("collected_on", { ascending: false }).limit(1),
    ]);
    if (count.error) throw count.error;
    if (first.error) throw first.error;
    if (last.error) throw last.error;
    return Response.json({ summary: {
      totalSamples: count.count ?? 0,
      firstDate: first.data?.[0]?.collected_on ?? null,
      lastDate: last.data?.[0]?.collected_on ?? null,
    } });
  } catch (error) {
    console.error("Failed to load summary:", error);
    return Response.json({ error: "Unable to load dataset summary." }, { status: 500 });
  }
}
