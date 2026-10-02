import type { Metadata } from "next";
import { DM_Sans, Newsreader } from "next/font/google";
import SiteHeader from "../components/pfas/SiteHeader";
import "leaflet/dist/leaflet.css";
import "./globals.css";

const sans = DM_Sans({ variable: "--font-dm-sans", subsets: ["latin"], display: "swap" });
const serif = Newsreader({ variable: "--font-newsreader", subsets: ["latin"], display: "swap" });

export const metadata: Metadata = {
  title: { default: "From Tap to Tributary", template: "%s · From Tap to Tributary" },
  description: "Explore PFAS measurements from indoor and outdoor water-sampling locations across the UIUC campus.",
};

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return <html lang="en" className={`${sans.variable} ${serif.variable}`}>
    <body><SiteHeader />{children}<footer><span>From Tap to Tributary</span><span>Campus water quality monitoring · UIUC</span></footer></body>
  </html>;
}
