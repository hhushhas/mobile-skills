# Google Play: via gplay

`gplay` (tamtom) is the primary tool. Update before serious work (`brew upgrade tamtom/tap/gplay`), check with `gplay auth doctor --output json`. Auth is a Google Cloud service account, and setup has two halves that both must exist: the GCP side (service account created, Google Play Android Developer API enabled) *and* the Play Console side (the service account granted app access under Users and permissions) — API enablement alone silently gives you 403s. Store the JSON as a ref (`env:GOOGLE_APPLICATION_CREDENTIALS`), never inline. When `gplay` lacks coverage, fall back to the Android Publisher API v3 directly (scope `https://www.googleapis.com/auth/androidpublisher`); for Gradle-native projects, Gradle Play Publisher is a mature alternative. The CLI author ships a companion skill pack (`tamtom/gplay-cli-skills`) for metadata, screenshots, IAP, and rollout work — install rather than re-derive.

## Tracks: resolve names before every call

User-facing track names are not API track names. "Open testing" is `beta` in the API/CLI; "internal testing" is `internal`; closed tracks have custom names that must match Play Console exactly. Always inspect actual tracks inside an edit (`gplay tracks get`) before updating one — never pass a user's phrasing straight through.

## Flow

```bash
gplay preflight --bundle <aab>                       # offline artifact checks
gplay publish track --package <pkg> --track <track> --bundle <aab>   # high-level path
# or explicit edit lifecycle when you need control:
gplay edits create --package <pkg> --output json
gplay bundles upload --package <pkg> --edit <id> --file <aab>
gplay tracks update --package <pkg> --edit <id> --track <track> --releases <json>
gplay edits validate --package <pkg> --edit <id>
gplay edits commit --package <pkg> --edit <id>       # the point of no return
gplay status --package <pkg>                         # verify track state after
```

One edit per coherent release; validate before commit; commit is the store mutation. There is no App Store-style public review lifecycle to poll — after commit, poll *track state*, and expect propagation delay before testers see anything.

## Gotchas (all field-tested)

- First production release: production countries/regions must be set in Play Console first — the API can only commit a `completed` release after targeting exists, may reject `countryTargeting` on completed releases, and may not support a staged `inProgress` first release. Set countries in console, send that change for review, then retry via API.
- Play Console can show an open-testing track as paused/inactive while the API reports a `beta` release with `status: completed`. Resume the track in Play Console, then send the change for review.
- Internal testing links 404 while the internal track only has a draft release, even with tester lists selected.
- Special permissions (e.g. `FOREGROUND_SERVICE_MICROPHONE`) require a console declaration, often with a demo video showing the in-app justification — budget for recording one.
- New personal developer accounts must run a closed test with a minimum tester count over a multi-week window before production access — check the current requirement on Play policy pages before promising a production date.
- Notification-only email addresses go under Users and permissions > Email recipients; they don't need console access.

## Console boundary

API-covered: edits, bundle upload, listings, images, release notes, tracks/rollouts, testers, and Data Safety labels (via `applications.dataSafety` with prepared JSON). Web-only — browser automation or human: app creation, content rating questionnaire, target audience, ads declaration, privacy policy URL field, sensitive-permission declarations. Owner-only: developer account creation, Play App Signing enrollment, service-account grants, payments/agreements.

## Readiness judgment points

Data Safety answers that don't match the SDKs and network calls actually in the build are the top rejection driver — audit against reality, not intention. Account creation requires both in-app deletion *and* a public web deletion URL. Target API level must meet the current requirement (it ratchets yearly). Tester/reviewer instructions must cover login, region locks, and paid features.
