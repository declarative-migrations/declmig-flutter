# Product-link boundary

Shared Auth buffers only a same-origin HTTPS `/u/*` product link derived from
the reviewed `AUTH_CALLBACK_URL`. This application independently allowlists
only `/u/status`; malformed, credential-bearing, fragmented, secret-query, or
unsupported links render the status home with a safe notice.

The organization has not yet recorded an owned public domain. The encrypted
profiles intentionally use `https://m.declarative-migrations.invalid/auth/callback`
as a non-routable placeholder, and the marketing site currently publishes only
at `declarative-migrations.github.io`. Therefore this PR does not claim Android
App Link, iOS Universal Link, desktop handler, Supabase callback, or Cloudflare
verification.

Once a domain is selected and recorded in the Linear/GitHub project mapping:

1. replace the encrypted callback/admin placeholder values through ores-sops;
2. configure the exact `m.<owned-domain>` route in `declmig-infra`;
3. add the release-signed Android host declaration and association identity;
4. add iOS/desktop runners before adding their platform association records;
5. allowlist the exact callback in Supabase and test cold/warm, logged-out
   return, invalid/expired callback, supported/unsupported route, and browser
   fallback behavior on signed devices.

Dummy domains, fingerprints, and Apple team IDs must never be published as
working association documents.
