import { createSupabaseClient } from "../../../../lib/supabase";

export async function GET(
  _request: Request,
  context: { params: Promise<{ siteCode: string }> }
) {
  try {
    const { siteCode } = await context.params;
    const supabase = createSupabaseClient();

    const { data, error } = await supabase
      .from("sites")
      .select(`
        id,
        site_code,
        name,
        category,
        water_type,
        address,
        latitude,
        longitude,
        samples (
          id,
          sample_code,
          collected_on,
          measurements (
            id,
            value,
            detected,
            unit,
            analytes (
              id,
              code,
              full_name,
              display_order
            )
          )
        )
      `)
      .eq("site_code", siteCode)
      .eq("active", true)
      .maybeSingle();

    if (error) {
      throw error;
    }

    if (!data) {
      return Response.json(
        { error: "Sampling site not found." },
        { status: 404 }
      );
    }

    data.samples.sort((a, b) =>
      b.collected_on.localeCompare(a.collected_on)
    );

    return Response.json({ site: data });
  } catch (error) {
    console.error("Failed to load site details:", error);

    return Response.json(
      { error: "Unable to load site details." },
      { status: 500 }
    );
  }
}