---
name: mobile-automation
description: "Automate tedious mobile app chores. Use for iOS/Android screenshot capture, demo video recording, native auth/deep-link setup, push notification setup, Firebase/Apple/Google/Expo/EAS CLI checks, validation, and precise human console guidance when a provider dashboard step cannot be automated."
license: MIT
---

# Mobile Automation

Use this skill for mobile app setup chores that slow down development:

- screenshots and demo videos
- authentication plumbing
- deep links, Universal Links, and Android App Links
- push notifications
- provider CLI/API checks for Apple, Google, Firebase, Expo/EAS, and similar services

Keep the skill focused on app setup chores. Do not create packets, ledgers, memory files, status contracts, handoffs, or execution-mode state.

## References

Load only the reference needed for the requested task.

| Task | Read |
| --- | --- |
| Screenshots, screen recordings, demo videos | `references/assets.md` |
| Native auth, OAuth, Sign in with Apple, Google Sign-In, links | `references/auth.md` |
| Push notifications, APNs, FCM, Expo/EAS | `references/push.md` |
| Dashboard-only provider setup | `references/console.md` |

## Working Style

Start by inspecting the app shape: framework, native folders, bundle ID, package name, build commands, provider config, and existing test/capture tooling.

Prefer existing project tools and config over adding new dependencies. If a new CLI/tool is needed, first check maintenance, recency, adoption, and obvious risk flags.

Prefer CLI/API automation when it is reliable. When a provider dashboard step is unavoidable, give exact human guidance: page, fallback navigation, control type, value, upload, and how to confirm it.

Make local source/config edits when the user asks to set up, configure, scaffold, or fix the app. Keep edits scoped to the requested chore.

Do not paste or save secrets. Use refs such as `op://`, `env:`, `secret:`, `ref:`, or secure local paths.

## Task Selection

- Screenshots or videos: use `references/assets.md`.
- Login/auth/OAuth/deep links: use `references/auth.md`.
- Push notifications/APNs/FCM/Expo push: use `references/push.md`.
- A required console/key/credential step: use `references/console.md`.
- Broad request like "set up the mobile app chores": handle assets, auth, and push in that order, loading each reference only when needed.

## Screenshots And Videos

Default to Maestro for cross-platform capture unless the repo already has a mature native test setup.

Good defaults:

- Maestro for Expo, React Native, Flutter, native iOS, and native Android.
- fastlane `snapshot` when iOS XCUITest screenshot flows already exist.
- fastlane `screengrab` when Android instrumentation screenshot flows already exist.
- `xcrun simctl` and `adb` for simple raw captures.
- Detox or Appium only when the project already uses them.

If a written plan helps, create a small capture plan from `assets/mobile-capture-plan-template.yaml` or adapt the project's existing flow files. Avoid inventing a big state file.

Verify by opening representative generated images/videos, checking filenames/output paths, and confirming that the captures show the intended app state.

## Auth And Links

Automate local app config and provider API work where supported:

- iOS entitlements, URL schemes, Associated Domains, and provisioning-profile refresh.
- Android intent filters, App Links, custom schemes, SHA fingerprints, and `assetlinks.json`.
- Firebase apps/config downloads and Android SHA registration.
- Firebase/Auth provider config when required client IDs/secrets already exist as secure refs.

Use console guidance for credential ownership steps such as initial Apple API keys, Sign in with Apple Services ID/private key setup, Google native OAuth client creation, and Play App Signing fingerprints.

Verify with provider readback, generated association files, `adb` link checks, simulator/device link opens, and entitlement/profile inspection.

## Push

Automate the pieces that are deterministic:

- Android Firebase/FCM app setup, `google-services.json`, Gradle dependencies, and build checks.
- iOS Push Notifications capability, entitlements, profile refresh, and `aps-environment` validation.
- Expo/EAS credential checks when the project already uses Expo/EAS.
- FCM send smoke test when a real device token and secure send credentials are available.

Use console guidance for APNs `.p8` creation/download and Firebase iOS APNs key upload when no supported CLI/API path exists.

Verify push with a physical-device path whenever possible. Do not claim push works from config inspection alone.

## Guardrails

- Never commit `.p8`, `.p12`, `.mobileprovision`, service account JSON, keystores, OAuth secrets, reviewer passwords, device tokens, or raw console exports.
- Do not claim auth or push works without a real validation path.
- Do not use Firebase Dynamic Links for new work; it is deprecated/shut down. Prefer Universal Links and Android App Links.
- Regenerate iOS provisioning profiles after capability changes.
- Prefer APNs token auth keys over APNs TLS certificates unless a vendor requires certificates.
- Treat generated screenshots and videos as human-reviewable assets even when capture is automated.

## Final Output

Lead with what was completed.

Include:

- task area: assets, auth, push, or mixed
- local files changed
- commands run and important results
- generated assets or configs
- console steps still needed, if any
- validation evidence
- blockers or next step
