# Apple: App Store Connect via asc

`asc` (rorkai) is the primary tool. Update it before serious submission work (`brew upgrade asc`), check auth with `asc auth doctor`, and use `--output json` for anything you'll parse. Auth is App Store Connect API key via env/profile: `ASC_KEY_ID`, `ASC_ISSUER_ID`, `ASC_PRIVATE_KEY_PATH` (or `ASC_PRIVATE_KEY`/`_B64`), `ASC_APP_ID`. The `.p8` key is downloadable exactly once from App Store Connect — make sure the human stores it in a secret manager at creation time. Team keys require Account Holder or Admin to create, under Users and Access > Integrations > App Store Connect API. When the CLI lacks coverage, `asc schema` plus `asc auth token` give you a direct authenticated API path; check current Apple API docs before hand-rolling calls. For deep metadata, localization, screenshot, or pricing work, the CLI author ships a companion skill pack (`rorkai/app-store-connect-cli-skills`) — install the relevant skill rather than re-deriving commands.

## Flow

```bash
asc apps list --bundle-id <bundle> --output json     # resolve app id
asc status --app <app-id> --include app,builds,testflight,appstore,submission,review
asc builds upload --app <app-id> --ipa <path>
asc builds wait --app <app-id> --latest              # upload succeeded ≠ build usable
asc validate --app <app-id> --version <version>
asc publish testflight --app <app-id>
asc publish appstore --app <app-id> --version <version> --submit --confirm
asc submit status --version-id <version-id>          # poll review state
```

Validate before publishing (`asc validate`; the old `asc submit preflight` is deprecated). Default flow is TestFlight first, then App Review when asked. A build's first distribution to an *external* TestFlight group triggers Beta App Review — a lighter, separate review with its own delay; internal groups need none. If `asc` upload fails, Transporter (which accepts the same API keys) and Xcode Organizer are the fallback upload paths — binary upload is not available via plain REST.

## Build

Ask the signing question before building: local certificates/profiles vs cloud (EAS) — don't guess. After Expo prebuild or any native regeneration, re-check entitlements and the build number; prebuild can silently reset them. Verify the exported IPA's bundle ID, version, and build number match what you intend before uploading.

## Console boundary

Not available via API/CLI — browser automation or human:

- App record creation (the Apps API explicitly disallows it; `asc web` or browser automation, else human)
- App Privacy questionnaire — and it must be *published* before an App Review submission will go through
- Agreements, tax, banking, identity — account owner only
- API key creation and role grants — account owner only

Most everything else — metadata, localizations, screenshots, review details, build attachment, review submission, TestFlight groups/testers — is API-covered.

## Readiness judgment points

The ones reviewers actually catch: account creation without in-app account deletion (hard rejection); third-party login without Sign in with Apple where required; vague permission purpose strings; App Privacy answers that don't match the SDKs actually compiled in; digital goods sold outside IAP; no working demo/reviewer access for gated features (give credentials and exact steps in review notes); UGC without report/block; screenshots showing states the reviewer can't reach.
