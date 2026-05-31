# Security

Report security issues privately through GitHub Security Advisories when available, or contact the repository owner.

Do not include secrets in issues, discussions, pull requests, screenshots, logs, or reproduction bundles.

These skills should never publish or request raw:

- App Store Connect private keys
- Google service account JSON
- keystores or keystore passwords
- provisioning profiles or certificates
- reviewer account passwords
- OAuth client secrets
- push device tokens
- `.p8`, `.p12`, or other signing materials
- private scratchpad or memory files

Use secret references such as `op://`, `env:`, `secret:`, `ref:`, or secure local paths.
