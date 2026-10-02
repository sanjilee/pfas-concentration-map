"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";

export default function SiteHeader() {
  const pathname = usePathname();
  return <>
    <a className="skip-link" href="#main-content">Skip to content</a>
    <header className="site-header">
      <Link className="brand" href="/" aria-label="From Tap to Tributary home">
        <span><strong>From Tap to Tributary</strong><small>University of Illinois Urbana-Champaign</small></span>
      </Link>
      <nav aria-label="Primary navigation">
        {[["/", "Explore"], ["/about", "About"], ["/team", "Team"]].map(([href, label]) =>
          <Link key={href} href={href} className={pathname === href ? "active" : ""} aria-current={pathname === href ? "page" : undefined}>{label}</Link>)}
      </nav>
    </header>
  </>;
}
