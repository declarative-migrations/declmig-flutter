# declmig-flutter

Flutter for mobile, desktop, and mobile web. No React. UI lives in `lib/src/`.

## Customer authentication

The product is gated by Supabase Auth followed by Shared Auth token exchange.
Decrypt a reviewed profile with `ores-sops decrypt dev`, then run
`flutter run --dart-define-from-file=env/dec/dev.env`. Only the encrypted
`env/enc/{dev,prod}.env.enc` profiles are versioned; plaintext remains ignored.

`ADMIN_LOGIN_ENABLED` defaults to `no`. Exact `yes` reveals only an external
HTTPS portal action after the operator connects the approved VPN. This app has
no admin UI, SSH/VPN logic, credentials, or admin Shared Auth client.
