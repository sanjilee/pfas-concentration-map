import { createSupabaseClient } from "../../../lib/supabase";

export async function GET() {
  try {
    const supabase = createSupabaseClient();

    const { data, error } = await supabase
      .from("sites")
      .select(
        "id, site_code, name, category, water_type, address, latitude, longitude"
      )
      .eq("active", true)
      .order("name");

    if (error) {
      throw error;
    }

    return Response.json({ sites: data });
  } catch (error) {
    console.error("Failed to load sites:", error);

    return Response.json(
      { error: "Unable to load sampling sites." },
      { status: 500 }
    );
  }
}