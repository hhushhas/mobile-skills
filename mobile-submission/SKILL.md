---
name: mobile-submission
description: "Take an iOS/Android app from repo to the stores: readiness review against Apple and Google policy, version bumps, builds, App Store Connect and Google Play upload and submission, and rejection recovery. Use when asked to submit, publish, ship, or release a mobile app, prepare a store listing, respond to an App Review or Play Console rejection, or check where a store release stands."
license: MIT
---

# Mobile Submission

The store is the source of truth. Never mirror store state into local packets, ledgers, or status files — when resuming work or unsure where a release stands, ask the store (`asc status`, `gplay status`) and trust what it says over anything written down earlier. The only release facts worth keeping in the repo are the ones the store can't give back: review-note phrasing, demo credentials as refs, console form answers. Keep those in a plain project doc (e.g. `docs/store-console-form-answers.md`) if the project wants one.

Work CLI-first. `asc` covers App Store Connect and `gplay` covers Google Play; read `references/apple.md` or `references/google.md` before touching that store — they hold the command sequences, the CLI-vs-console boundary, and the gotchas that burn releases. Route every task by capability: if the CLI covers it, use the CLI; if it's web-only (Apple app-record creation, Play's content rating questionnaire and declarations), drive the console with browser automation when a browser tool is available; only steps the account owner must personally do — agreements, tax and banking, identity verification, developer-account creation, granting API access — become instructions for the human, with exact page and field. Do what was asked and no more: "prepare" or "get ready" stops before any store mutation, "submit" goes all the way. Keep secrets as refs (`op://…`, `env:VAR`, secure paths) and never paste key contents, service-account JSON, or reviewer passwords into chat or files.

## New app

Discover the facts from the repo first: bundle ID, package name, framework and build system, permissions and their purpose strings, auth and account deletion, payments, UGC/AI surfaces, privacy/support/terms URLs, existing store assets. Then judge the app the way a reviewer will, against the current official policy pages (App Review Guidelines, Play policy center) for the app's actual risk surfaces — payments, kids, health, UGC, AI, tracking — not a generic checklist. Report what would likely get it rejected and fix with the user's approval before spending time on store plumbing. Then: store records and required setup forms, listing metadata and screenshots, build, upload, TestFlight/internal testing, and submission per the store references.

## Update

Read the diff since the last released version to classify the release, bump the version (below), write release notes from what actually changed, build, upload, and submit. Listing, privacy answers, and declarations usually carry over — touch them only when the changes altered behavior they describe (new permissions, new data collection, new SDKs).

## Rejection

Read the rejection notice precisely. Apple cites numbered guidelines — the number is an index into the current App Review Guidelines page; Google cites policy names that map to Play policy pages. Fetch the cited text, and web-search the exact citation for current community experience before theorizing. Diagnose against the app's real behavior, fix, and resubmit. Mechanics that matter: a metadata-rejected Apple status means you can fix listing/review info and resubmit without a new binary; the resolution center is a conversation — you can reply, ask the reviewer questions, or contest a misunderstanding before changing anything; Apple 4.3 (spam/design) is about product positioning, not code, and a well-argued reply sometimes beats rebuilding.

## Versioning

Semantic versioning for the user-visible version: patch for fixes and polish, minor for features and behavior changes, major for redesigns and breaking shifts — don't keep shipping user-visible changes as the same version. Every uploaded binary needs a bumped build identifier: iOS `CFBundleVersion` (Expo `ios.buildNumber`), Android `versionCode` — any changed AAB needs a new `versionCode`, no exceptions. Update app config, native config, and release notes together, and verify the built artifact actually contains the expected version and build before uploading it.
