"use client";

import { useEffect, useRef, useState } from "react";
import L from "leaflet";
import type { Site } from "../../lib/pfas/types";

type Props = { sites: Site[]; selectedCode: string | null; onSelect: (code: string) => void };
function markerIcon(site: Site, active: boolean) {
  return L.divIcon({ className: `site-marker ${site.category}${active ? " selected" : ""}`, html: '<span class="marker-center"></span>', iconSize: [28, 28], iconAnchor: [14, 14] });
}
export default function CampusMap({ sites, selectedCode, onSelect }: Props) {
  const container = useRef<HTMLDivElement>(null);
  const map = useRef<L.Map | null>(null);
  const markers = useRef(new Map<string, L.Marker>());
  const [tileError, setTileError] = useState(false);

  useEffect(() => {
    if (!container.current) return;
    const instance = L.map(container.current, { minZoom: 10, scrollWheelZoom: false }).setView([40.108, -88.227], 14);
    map.current = instance;
    const tiles = L.tileLayer(
      "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
      {
        maxZoom: 19,
        referrerPolicy: "strict-origin-when-cross-origin",
        attribution:
          '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors',
      }
    ).addTo(instance);
    tiles.on("tileerror", () => setTileError(true));
    tiles.on("tileload", () => setTileError(false));
    const resize = new ResizeObserver(() => instance.invalidateSize());
    resize.observe(container.current);
    return () => { resize.disconnect(); instance.remove(); map.current = null; };
  }, []);

  useEffect(() => {
    const instance = map.current;
    if (!instance) return;
    const currentMarkers = markers.current;
    currentMarkers.forEach(marker => marker.remove());
    currentMarkers.clear();
    const bounds: L.LatLngTuple[] = [];
    sites.forEach(site => {
      if (!Number.isFinite(site.latitude) || !Number.isFinite(site.longitude)) return;
      const position: L.LatLngTuple = [site.latitude, site.longitude];
      const marker = L.marker(position, { icon: markerIcon(site, false), title: site.name, alt: `Select ${site.name}`, keyboard: true }).addTo(instance);
      const tooltip = document.createElement("span");
      tooltip.textContent = site.name; // Database strings are never interpreted as HTML.
      marker.bindTooltip(tooltip, { direction: "top", offset: [0, -12] });
      marker.on("click", () => onSelect(site.site_code));
      currentMarkers.set(site.site_code, marker);
      bounds.push(position);
    });
    if (bounds.length) instance.fitBounds(bounds, { padding: [38, 38], maxZoom: 15, animate: false });
    return () => { currentMarkers.forEach(marker => marker.remove()); currentMarkers.clear(); };
  }, [sites, onSelect]);

  useEffect(() => {
    sites.forEach(site => markers.current.get(site.site_code)?.setIcon(markerIcon(site, site.site_code === selectedCode)));
    const selected = selectedCode ? markers.current.get(selectedCode) : null;
    if (selected) map.current?.panTo(selected.getLatLng(), { animate: !window.matchMedia("(prefers-reduced-motion: reduce)").matches });
  }, [selectedCode, sites]);

  return <div className="map-frame">
    <div ref={container} id="map" aria-label="Interactive campus sampling map" />
    <div className="map-key"><span><i className="dot indoor" />Indoor</span><span><i className="dot outdoor" />Outdoor</span></div>
    {tileError && <p role="status" className="tile-warning">The background map couldn’t load. You can still select a location below.</p>}
  </div>;
}
