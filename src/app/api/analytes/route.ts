import { createSupabaseClient } from "../../../lib/supabase";

export async function GET() {
  try {
    const { data, error } = await createSupabaseClient().from("analytes")
      .select("id, code, full_name, default_unit, display_order").order("display_order");
    if (error) throw error;
    return Response.json({ analytes: data });
  } catch (error) {
    console.error("Failed to load analytes:", error);
    return Response.json({ error: "Unable to load compounds." }, { status: 500 });
  }
}
