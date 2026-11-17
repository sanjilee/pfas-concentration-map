# Enable team data management

The `/admin` page signs editors in with Supabase email/password Auth. There is no
public signup UI. The browser uses only the publishable key and the signed-in
user's JWT. Database RPCs authorize every write against `public.pfas_editors`;
API roles cannot write directly to the tables or change editor membership.
No service-role key is needed by the application.

## Before deploying

1. Back up the database. Test against a separate Supabase project first.
2. Apply `supabase/migrations/005_admin_management.sql` with the Supabase SQL
   editor or your migration runner. The existing four schema migrations must
   already be applied. Do not rerun them or the presentation seed on production.
3. In Supabase Authentication settings, disable **Allow new users to sign up**.
   Leave email/password sign-in enabled. This is an account provisioning setting;
   the editor allowlist independently denies writes even to other valid users.
4. Create the initial editor in Supabase Authentication → Users → Add user →
   Create new user, using their email and a strong password, and confirm the
   email through your administrator-managed process. Deliver credentials privately.
   Copy the new user's UUID into the SQL below:

   ```sql
   insert into public.pfas_editors(user_id)
   values ('REPLACE_WITH_AUTH_USER_UUID'::uuid)
   on conflict do nothing;
   ```

5. Configure `SUPABASE_URL` and `SUPABASE_PUBLISHABLE_KEY` in Vercel. These are
   the existing variables; no new secrets are required. The admin page exposes
   only a publishable key (or a legacy JWT with role `anon`) to its browser client.
6. Point branch previews to the test project, not production. Deploy the branch
   preview and complete the checks below before merging.

The MVP intentionally uses administrator-provisioned email/password accounts.
Email invite/reset callback pages are not implemented. Use the Supabase admin
tools to provision accounts and manage password resets; do not send invite links
that expect this app to process the callback. Sessions are kept in sessionStorage
and are not shared between browser tabs. Sign out when finished on shared devices.

## Verify in a preview

- An anonymous visitor can still explore the map and cannot call write RPCs.
- A signed-in user without an allowlist entry cannot manage data or write by RPC.
- An approved editor can add a site and a dated sample, then edit its results.
- Verify detected `0`, `ND`, and `No result` separately in the public explorer.
- Save invalid data or a duplicate sample code: no partial measurements are saved.
- Open the same record in two sessions: saving from the older version is rejected.
- Confirm deletion by typing the sample code: only that sample and its results go.
- Deactivate a site: it disappears from the public map but its samples remain.
- Refresh the explorer after edits. It fetches uncached data; an already-open
  explorer does not subscribe to live database updates.
- Check narrow-screen forms, keyboard navigation, login failure and sign-out.

## Revoke an editor

```sql
delete from public.pfas_editors where user_id = 'REPLACE_WITH_AUTH_USER_UUID'::uuid;
```

Every subsequent write checks this table, even if the user still has a valid
session token. Membership is not stored in editable profile metadata or cached JWT roles.

## Data behavior

- Each save replaces the sample's complete set of measured compounds in one
  database transaction. A `No result` selection creates no measurement row.
- ND stores `detected=false, value=null`. Detected values must be finite and >= 0.
- Updates and deletes use revision checks to reject stale edits.
- Site deletion is deliberately unavailable; deactivation preserves research data.
- All existing data tables remain publicly readable, including inactive sites and
  notes through direct database queries. Deactivation is not a privacy feature.

## Validation

`cd src && npm ci && npm run lint && npm test && npm run build`

GitHub Actions also applies migrations and runs `supabase/tests/admin_management.sql`
against disposable PostgreSQL. The auth fixture emulates JWT identity and roles;
it does not replace a real Supabase Auth/browser smoke test. Never run the auth
fixture on an actual Supabase project. No CI job applies production migrations.
