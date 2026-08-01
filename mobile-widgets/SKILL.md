---
name: mobile-widgets
description: "Use when adding a home-screen or Lock Screen widget, extending an app beyond its main UI, making a widget feel native, or debugging stale, resized, miscolored, misconfigured, or missing widget state."
license: MIT
---

# Mobile Widgets

Treat a widget as a focused product surface, not a shrunken app screen. Start with one primary job, decide what a person must understand at a glance, and keep the fastest actions safe and reversible. Use platform-native appearance, system color and rendering rules, clear empty and permission states, accessibility labels, and a deep link that opens the matching app scene. A widget should earn its place outside the app by reducing a repeat task, not by reproducing navigation.

Inspect the app before choosing an implementation: native targets, React Native or Expo boundaries, package and bundle identifiers, minimum OS versions, build system, persisted data source, authentication, and existing capabilities. Define a small widget snapshot plus an update contract before writing views. iOS widgets run in a separate extension process and share data through an App Group; Android widgets are hosted remote surfaces and must read persisted application state. Never depend on the main app’s in-memory state.

Use [references/apple.md](references/apple.md) for WidgetKit, SwiftUI, App Groups, timelines, App Intents, Apple identity, signing, and App Store Connect. Use [references/android.md](references/android.md) for Jetpack Glance, RemoteViews, responsive sizes, launcher behavior, state updates, previews, and Android verification. Prefer Glance for a Compose-based Android app when its supported surface is enough; use RemoteViews when the project or required widget behavior needs it. Do not add a framework just to make a widget look modern.

Design each supported family or size as an intentional hierarchy. Compact surfaces show the answer; larger surfaces add context or one useful action. Do not stretch one layout into every size. Use timelines and event-driven updates for predictable changes, and let the system budget refreshes. A countdown that needs continuous real-time updates belongs in a platform feature such as Live Activities, not in a widget that polls every second.

Define an action contract before adding controls. Navigation opens the matching app scene; reversible actions such as snooze or a sleep preset may run directly; destructive actions such as dismiss, cancel, delete, or disable stay out of one-tap controls or route through an explicit in-app confirmation. For alarm-like products, reconcile widget state after create, edit, fire, snooze, dismiss, reboot, locale or time-zone change, permission change, and scheduler recovery. A timeline is a fallback for known future changes, not proof that a widget will update at an exact instant.

For store work, load `mobile-submission` for signing, App Store Connect, Play Console, and release state, and load `mobile-screenshots` for listing media. Keep Apple credentials and signing choices aligned with those skills: check live auth, ask before creating keys or profiles, never print secrets, and do not claim a release or widget asset is live without store or device proof.

## Verification

Build the same app and extension artifacts that will ship. Exercise every supported family or size, preview and empty states, light and dark appearance, Dynamic Type or font scaling, accessibility, deep links, every widget action, stale data, time-zone and locale changes, and the minimum supported OS. For each supported platform, install the signed device artifact on a physical device and its real launcher when hardware is available; simulator or emulator proof does not prove placement, launcher rendering, signing, or cross-process updates. Verify that every scheduler event listed above changes the widget and that every widget action changes the source of truth. Record failures plainly and stop at the exact missing proof.
