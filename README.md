# From Tap to Tributary

A public, read-only explorer for PFAS measurements at water-sampling locations around the University of Illinois Urbana-Champaign campus.

**Website:** https://from-tap-to-tributary.vercel.app/

The MVP focuses on one journey: open the map, choose a location, review its PFAS overview, select a compound, and inspect its measurement history.

## Features

- Interactive campus map with indoor and outdoor sampling locations.
- Search by location name, site code, address, or water type.
- Indoor/outdoor filters and a browsable location list.
- Site details beside the map.
- PFAS overview with a visitor-selectable set of compounds.
- Latest result, detected-value statistics, time-series chart, and measurement history.
- Concentrations in ng/L, with nondetects displayed as `ND`.
- About and Team pages, including profile photos and initials where no photo is configured.
- Responsive layouts for desktop and mobile.

## Technology

| Area | Technology |
| --- | --- |
| Application and API routes | Next.js App Router, React, TypeScript |
| Styling | Tailwind CSS and project CSS |
| Database | Hosted Supabase PostgreSQL |
| Database client | Supabase JavaScript client |
| Map | Leaflet with OpenStreetMap tiles |
| Chart | Project SVG chart component |
| Hosting | Vercel |
| Development | GitHub Codespaces |

The browser requests monitoring data through Next.js API routes. Those routes query Supabase. There is no separate backend server, visitor login, or administration dashboard.

## Repository layout

The application root is **`src/`**, which contains `package.json`. Run npm commands there. Paths below are relative to the repository root.

| Path | Purpose |
| --- | --- |
| `src/app/page.tsx` | Explorer entry page |
| `src/app/layout.tsx` | Shared layout and metadata |
| `src/app/globals.css` | Global styles |
| `src/app/about/page.tsx` | Project information |
| `src/app/team/page.tsx` | Team roster and photo paths |
| `src/app/api/` | Read-only data endpoints |
| `src/components/pfas/` | Map, explorer, detail panel, chart, and header |
| `src/lib/supabase.ts` | Server-side Supabase client |
| `src/lib/pfas/` | Data types, API helpers, and measurement calculations |
| `src/public/team/` | Team photos |
| `src/tests/` | Calculation tests |
| `supabase/` | Database SQL scripts |
| `supabase/seed_presentation.sql` | Optional presentation dataset |

## Run in Codespaces

Open the existing repository in GitHub Codespaces. In the terminal:

```bash
cd /workspaces/pfas-concentration-map/src
npm ci
```

Create `src/.env.local` (relative to the repository root) with these variables:

```dotenv
SUPABASE_URL=https://YOUR_PROJECT_REF.supabase.co
SUPABASE_PUBLISHABLE_KEY=YOUR_PUBLISHABLE_KEY
```

Use your project's publishable key. Do not substitute a secret key, service-role key, or database password. The variable names must match exactly; the existing server client does not use a `NEXT_PUBLIC_` prefix.

Verify that the environment file is ignored:

```bash
git check-ignore -v .env.local
```

Start the application:

```bash
npm run dev
```

Open the forwarded development port shown by Codespaces. Restart the development server after changing environment variables.

This setup assumes the Supabase database already contains the project tables. The presentation seed adds data; it is not a substitute for creating the schema and access policies.

## Database and measurement rules

| Table | Stores |
| --- | --- |
| `sites` | Location code, name, category, water type, address, coordinates, and active status |
| `samples` | Sample code, site reference, collection date, and optional notes |
| `analytes` | Compound code, full name, default unit, and display order |
| `measurements` | Sample/analyte references, nullable numeric value, detected flag, and unit |

One site has many samples. Each sample can have one measurement per analyte.

The 13 compounds are PFBA, PFPeA, PFHxA, PFHpA, PFOA, PFNA, PFBS, PFPeS, PFHxS, PFHpS, PFOS, PFNS, and 6:2 FTS.

- **Detected:** `detected = true` with a nonnegative numeric value.
- **Not detected:** `detected = false` with `value = null`; displayed as `ND`.
- **Missing measurement:** displayed as `No result`, not `ND`.
- **Units:** ng/L throughout the MVP.
- **Statistics:** minimum, average, and maximum use detected measurements only.
- **Chart:** nondetects and missing measurements are not plotted as zero.

The PFAS overview sums detected concentrations for the selected compounds within a single sample. All compounds are selected initially. Visitor selections change the current view, not the database.

A complete sample containing only nondetects displays `No detections`. A sample missing some selected measurements displays `Incomplete`; one with no selected measurements available displays `No result`. Incomplete samples do not contribute numeric overview totals. Calculation logic lives in `src/lib/pfas/calculations.ts`.

An overview sum is not a drinking-water safety rating.

## Presentation seed

`supabase/seed_presentation.sql` contains synthetic data for demonstrating the interface. It must not be interpreted as verified environmental monitoring evidence.

Keep this script in version control if it contains only intended demonstration data and no credentials or private information. It makes the demo reproducible, but the running website reads Supabase, not this SQL file.

- Run it manually only when intentionally populating a demonstration database after creating its schema.
- Do not run it automatically during builds or deployments.
- Do not rerun it to solve a Table Editor display or filtering issue.
- Review its effects before rerunning: it can restore demonstration records you previously removed.
- Removing the file from Git does not remove data already inserted into Supabase.

Preserve schema changes and access policies as SQL in `supabase/` as well. SQL run only in the dashboard is not automatically saved to this repository.

## Data endpoints

| Endpoint | Purpose |
| --- | --- |
| `GET /api/sites` | Active sampling locations |
| `GET /api/sites/[siteCode]` | Site details, samples, and compound measurements |
| `GET /api/analytes` | Ordered compound list |
| `GET /api/summary` | Dataset counts and collection period |

Treat data exposed through public policies and endpoints as public, including any returned notes or addresses. Hiding a field in the interface is not an access restriction.

## Validation

From `src/`:

```bash
npm run lint
npm run build
```

Before sharing a deployment, check:

- The production URL opens without a hosting-account login.
- Map tiles load with visible attribution.
- Search and filters return the expected locations.
- Selecting a site loads the correct detail panel.
- Compound selection updates results, statistics, chart, and history.
- Nondetects, missing data, and incomplete overviews display correctly.
- Team photos load and the main journey works on a phone.
- Database grants and row-level-security policies enforce public read-only access.

Passing a build or a browser check does not constitute a security audit.

## Deployment

The app is hosted on Vercel with the existing Supabase database.

| Vercel setting | Value |
| --- | --- |
| Framework | Next.js |
| Root directory | `src` |
| Build and output settings | Next.js defaults |
| Environment variables | `SUPABASE_URL`, `SUPABASE_PUBLISHABLE_KEY` |

Configure environment variables in Vercel for each deployment environment that needs database access. The ignored local environment file is not uploaded through Git. Preview deployments using the same variables read the same database as production.

Push application changes to the configured production branch to trigger deployment. Redeploy after changing Vercel environment variables. Do not configure a static export: this application uses server-side API routes.

The deployed site runs independently of Codespaces. SQL files in Git are not automatically applied to Supabase by a website deployment.

## Security and scope

The intended access model is public read-only access. All four tables should have row-level security enabled and appropriate SELECT policies. Public API roles should not have INSERT, UPDATE, DELETE, or TRUNCATE privileges. Verify the deployed configuration rather than relying on the absence of editing controls.

Never commit environment files containing credentials, database passwords, privileged API keys, or private database exports. Keep `node_modules/` and `.next/` out of Git. If a privileged credential was committed, rotate it; deleting the current file does not erase Git history.

The MVP intentionally excludes authentication, roles, uploads, admin tools, approval workflows, notifications, live sensors, and predictive analytics.
