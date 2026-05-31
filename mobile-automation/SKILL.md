---
name: mobile-automation
description: "Automate mobile app setup chores before release. Use for iOS/Android screenshot and demo video capture, store media prep, native auth/deep-link setup, push notification provisioning, Firebase/Apple/Google/Expo/EAS checks, CLI-first execution, validation, and precise human console tasks for dashboard-only gaps."
license: MIT
---

# Mobile Automation

Use this skill to remove repetitive mobile app setup work before submission: screenshots, demo/app-preview videos, authentication plumbing, deep links, push notifications, and provider credentials.

The parent agent is the orchestrator. It owns decisions, state, packet, ledger, human guidance, secret handling, verification, and final reporting. Prefer CLI/API execution where reliable; create exact human console tasks only for credential-custody or dashboard-only gaps.

Canonical project artifacts:

- `scratchpad/mobile-automation-packet.yaml`
- `scratchpad/mobile-automation-ledger.md`
- `scratchpad/mobile-automation-human-tasks.md`
- `scratchpad/mobile-capture-plan.yaml`
- `scratchpad/mobile-automation-learnings.md`
- `scratchpad/mobile-automation-memory.md`

Optional reusable private memory:

- a user-private memory file such as `~/.agents/private/mobile-automation-memory.md`, if the agent/runtime supports it

Use `assets/mobile-automation-packet-template.yaml` for the packet shape. Prefer a project-provided `scratchpad/mobile-automation-packet-template.yaml` when it exists.

## Reference Index

Load only the references needed for the requested mode.

| Need | Read |
| --- | --- |
| Screenshot, demo video, store media capture/upload | `references/assets.md` |
| Native auth, OAuth, Sign in with Apple, Google Sign-In, links | `references/auth.md` |
| Push notifications, APNs, FCM, Expo/EAS, validation | `references/push.md` |
| Human console task format and known console-only gaps | `references/console.md` |

## Mode Selection

- If the user asks for screenshots, app previews, demo videos, store media, or listing images, run `assets`.
- If the user asks for login, authentication, OAuth, Sign in with Apple, Google Sign-In, deep links, Universal Links, App Links, or reviewer access, run `auth`.
- If the user asks for push notifications, APNs, FCM, Expo push, notification credentials, or push smoke tests, run `push`.
- If the user asks to prepare the whole mobile app setup, run `full`: assets + auth + push, then summarize readiness for the submission skill.
- Default `controls.action` is `dry-run`: inspect, plan, validate, generate packets/tasks, and do not mutate provider accounts.
- Local source edits are allowed when the user clearly asks to set up, configure, scaffold, or fix the app.
- Provider account writes require an explicit request such as `configure Firebase`, `enable Apple capabilities`, `upload credentials`, or `execute`.

Packet status:

- `ready`: requested automation is complete and verified.
- `ready_warn`: no known blocker, but manual review or external async processing remains.
- `blocked`: missing credential/account/device/domain access or a failing validation prevents completion.

## Memory

Read memory before asking operational setup questions:

1. `scratchpad/mobile-automation-memory.md`
2. User-private memory such as `~/.agents/private/mobile-automation-memory.md`, if available

Use memory for reusable, non-secret facts:

- preferred Apple team, Google/Firebase project, Expo account, Play account, default domains
- credential reference locations such as `op://`, `env:`, `secret:`, `ref:`, or secure local paths
- recurring console blockers, CLI commands, simulator/device defaults, capture device sets
- preferred screenshot locales, supported stores, push provider, auth provider, reviewer account conventions

Do not store secret values, private keys, keystore passwords, service account JSON, `.p8`, `.p12`, provisioning profiles, reviewer passwords, OAuth client secrets, device tokens, or full logs in memory.

Priority order: user request > packet > project memory > global private memory > ask.

## Workflow

### 1. Discovery

Inspect the repo and existing scratchpads. Discover:

- framework: native iOS, native Android, React Native, Expo/EAS, Flutter, Capacitor, other
- iOS bundle ID, Android package name, app name, Apple team ID, Google/Firebase project IDs, Expo project ID
- build commands, release lanes, simulator/emulator compatibility, existing Maestro/Detox/Appium/XCTest/Espresso tests
- auth providers, redirect URLs, URL schemes, Universal Links, App Links, reviewer/demo access
- push provider, APNs/FCM/Expo/OneSignal/Braze setup, entitlements, permissions, real-device test path
- store media folders, screenshot locales/devices, preview videos, feature graphic, listing metadata
- credential refs, missing console setup, and domain ownership paths

Record findings in `scratchpad/mobile-automation-ledger.md`.

### 2. Plan

Create or update `scratchpad/mobile-automation-packet.yaml`.

For assets, create or update `scratchpad/mobile-capture-plan.yaml` with:

- platforms, locales, device classes, orientation, scenes, deep links, test credentials refs, output folders
- capture provider: Maestro, fastlane snapshot/screengrab, xcrun/adb, Detox, Appium, Firebase Test Lab
- validation: dimensions, formats, count, alpha channel, video codec/duration, store folder shape

If provider account writes or credential uploads are needed, list them explicitly before execution.

### 3. Execute

Follow the mode reference:

- `assets`: read `references/assets.md`
- `auth`: read `references/auth.md`
- `push`: read `references/push.md`
- `full`: read each relevant reference only when its phase begins

Prefer deterministic CLIs and official APIs. Use direct browser/computer-use only when the user explicitly wants that path. The default fallback is a precise human task.

### 4. Human Console Tasks

Create `scratchpad/mobile-automation-human-tasks.md` for dashboard-only work using `references/console.md`.

Rules:

- Include direct URLs only as best-effort convenience links.
- Always include fallback navigation.
- Preserve dashboard control shape: checkbox, radio, dropdown, text field, textarea, file upload, questionnaire, matrix/table.
- Give the exact value to select, paste, upload, or leave unchanged.
- Mark unknown fields as unknown and research/update the reference instead of inventing values.

### 5. Verification

Verify with the closest real evidence available:

- local source/config diffs
- CLI/API readback
- generated artifacts and hashes
- simulator/emulator screenshots or recordings
- profile/entitlement inspection
- Firebase/Apple/Google/Expo readback
- physical-device push/auth smoke test when required

If blocked, say exactly what is missing and where to resolve it.

## Guardrails

- Keep secrets as refs: `op://`, `env:`, `secret:`, `ref:`, or secure local paths.
- Never commit `.p8`, `.p12`, `.mobileprovision`, service account JSON, keystores, OAuth secrets, reviewer passwords, device tokens, or raw console exports.
- Do not claim auth or push works without a real validation path.
- Do not silently use Firebase Dynamic Links for new work; it is deprecated/shut down. Prefer Universal Links and Android App Links.
- Regenerate iOS provisioning profiles after capability changes.
- Prefer APNs token auth keys over APNs TLS certificates unless a vendor requires certificates.
- Treat app-preview/demo videos as human-reviewable creative assets even when capture is automated.
- Keep project-specific decisions in the project repo/spec. Keep this skill project-agnostic.

## Final Output

Lead with the result.

Include:

- mode: assets, auth, push, or full
- packet path/status
- local edits made
- provider writes performed or skipped
- generated artifacts and output folders
- auth result
- push result
- human console tasks path and completion state
- validation evidence
- ledger path
- learnings added
- next step
