import AdminDashboard from "../../components/pfas/AdminDashboard";
import "./admin.css";

export const dynamic = "force-dynamic";
export const metadata = { title: "Manage data | From Tap to Tributary", robots: { index: false, follow: false } };

export default function AdminPage() {
  const url = process.env.SUPABASE_URL;
  const key = process.env.SUPABASE_PUBLISHABLE_KEY;
  // Only expose an actual public key. Never serialize a secret/service-role key.
  let publicKey = key?.startsWith("sb_publishable_") ?? false;
  if (key?.startsWith("eyJ")) {
    try { publicKey = JSON.parse(Buffer.from(key.split(".")[1], "base64url").toString()).role === "anon"; }
    catch { publicKey = false; }
  }
  if (!url || !key || !publicKey) return <main id="main-content" className="admin-page"><h1>Data management unavailable</h1><p>The administrator needs to configure the Supabase URL and publishable key.</p></main>;
  return <main id="main-content" className="admin-page"><AdminDashboard url={url} publicKey={key} /></main>;
}
