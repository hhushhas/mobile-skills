# Apple: WidgetKit and SwiftUI

WidgetKit renders a widget extension outside the app process. Build a small, glanceable view for each supported `WidgetFamily`, then supply the data through a `TimelineProvider` or `AppIntentTimelineProvider`. Keep the view passive and deterministic: the containing app prepares shared data, the timeline predicts known changes, and `WidgetCenter` reloads timelines when the displayed source data actually changes.

## Product and layout

- Follow [Apple’s widget HIG](https://developer.apple.com/design/human-interface-guidelines/widgets). Choose the widget’s job, context, family, and rendering treatment before choosing a layout. Use system family sizes such as `.systemSmall`, `.systemMedium`, and `.systemLarge`, plus Lock Screen accessory families when they serve a real use case.
- Treat the widget as glanceable information with a focused interaction. Use `widgetURL(_:)` or `Link` to open the matching app scene. Use a `Button` or `Toggle` backed by an `AppIntent` only when the interaction performs a real widget action; a button that only opens the app should be a link.
- Use semantic SwiftUI styles, `containerBackground(for: .widget)`, the supplied color scheme, widget rendering mode, Dynamic Type, and accessibility labels. Avoid drawing a fake app card over the system widget surface or relying on color alone to communicate state.
- Gate interactive `AppIntent` buttons, toggles, and configurable-widget APIs with the deployment target they require, commonly `@available(iOS 17.0, *)`, and provide a useful static or `Link`/`widgetURL` fallback on earlier supported OS versions. Never let an unavailable action turn the widget into an empty state.
- Use [Live Activities](https://developer.apple.com/documentation/activitykit) when the requirement is frequent, time-sensitive progress. Widgets are not an always-running surface and WidgetKit may delay timeline reloads.

## Shared state and updates

Give the app and extension a shared App Group entitlement and read/write a small versioned snapshot through `UserDefaults(suiteName:)`, a shared file, or a shared database. Confirm the same App Group is present in both targets and in the provisioning profiles. Do not put tokens, private credentials, or volatile in-memory objects in the widget container.

Use a timeline for predictable changes such as the next alarm boundary, and use `WidgetCenter.shared.reloadTimelines(ofKind:)` or `reloadAllTimelines()` only after displayed data changes. Use SwiftUI dynamic date styles for relative times that should remain current while rendered. Respect WidgetKit’s refresh budget; do not request minute-by-minute reloads to simulate a live surface.

For alarms and other scheduled products, make the scheduler or canonical store the source of widget invalidation. Trigger a reload after creation, edit, fire, snooze, dismiss, reboot recovery, time-zone or locale changes, permission changes, and scheduler reconciliation. Re-read the canonical next occurrence inside the timeline provider so a delayed or coalesced reload cannot display an old alarm.

Read [Keeping a widget up to date](https://developer.apple.com/documentation/widgetkit/keeping-a-widget-up-to-date), [Timeline](https://developer.apple.com/documentation/widgetkit/timeline), [WidgetCenter](https://developer.apple.com/documentation/widgetkit/widgetcenter), and [Displaying dynamic dates](https://developer.apple.com/documentation/widgetkit/displaying-dynamic-dates) when choosing refresh behavior. Live framework output and the target OS behavior win over any remembered limit.

## Target, identity, and signing

Add a Widget Extension target through Xcode or the project’s native-generation system, then inspect the generated target, bundle identifier, entitlements, deployment target, and embedding settings. For React Native or Expo, treat the extension and App Group as native iOS changes and re-check them after every prebuild or native regeneration.

Before building or uploading, ask whether signing uses local certificates and profiles or a cloud service. For App Store Connect state, use the existing `asc` workflow: run `asc auth doctor`, resolve the app with `asc apps list --bundle-id <bundle> --output json`, and use `asc status` for live state. The standard API-key variables are `ASC_KEY_ID`, `ASC_ISSUER_ID`, `ASC_PRIVATE_KEY_PATH` or its secret-backed alternatives, and `ASC_APP_ID`. Keep the `.p8` key in the approved secret manager and never echo it.

An Apple ID is a team identity, not a substitute for App Store Connect API-key auth. If Xcode, Transporter, or another Apple tool explicitly requires account authentication, use the project’s approved `APPLE_ID`, `APPLE_TEAM_ID`, and app-specific-password secret without placing them in source, command transcripts, or process listings. Creating team API keys, certificates, profiles, agreements, or account roles remains an account-owner or authorized-admin action. Follow [mobile-submission](https://github.com/hhushhas/mobile-skills/tree/main/mobile-submission) for the current Apple auth and submission procedure.

## Verification

Use Xcode previews for every supported family and representative timeline entry, then build the signed device artifact and install the actual app plus extension in Simulator and on a physical iOS device. Use the project’s live scheme and destination rather than assuming a device name:

```bash
xcodebuild -list -workspace <workspace>.xcworkspace
xcodebuild -showBuildSettings -workspace <workspace>.xcworkspace -scheme <scheme>
xcodebuild -workspace <workspace>.xcworkspace -scheme <scheme> \
  -destination 'platform=iOS Simulator,name=<available-device>' build
xcodebuild -workspace <workspace>.xcworkspace -scheme <scheme> \
  -configuration Release -archivePath <archive-path> archive
xcodebuild -exportArchive -archivePath <archive-path> \
  -exportPath <export-path> -exportOptionsPlist <export-options.plist>
xcrun devicectl list devices
xcrun devicectl device install app --device <device-udid> <exported-app-path>
```

Use `-project <project>.xcodeproj` when the project has no workspace, and check `xcrun devicectl help` before relying on device-install flags. Confirm the signed artifact contains the intended App Group and widget extension; an unsigned Simulator build is not device or release proof.

After installation, test the widget gallery, every family, app-to-widget updates, widget-to-app deep links, App Intent actions and their earlier-OS fallback, locked-screen behavior, light/dark and tinted or accented rendering where supported, accessibility, scheduler reconciliation, and the minimum deployment target. Do not report physical-device readiness without proof on a real iOS device when one is in scope.

## Sources

- [WidgetKit](https://developer.apple.com/documentation/widgetkit)
- [Creating a widget extension](https://developer.apple.com/documentation/widgetkit/creating-a-widget-extension)
- [Making a configurable widget](https://developer.apple.com/documentation/widgetkit/making-a-configurable-widget)
- [Adding interactivity to widgets and Live Activities](https://developer.apple.com/documentation/widgetkit/adding-interactivity-to-widgets-and-live-activities)
- [Linking to specific app scenes](https://developer.apple.com/documentation/widgetkit/linking-to-specific-app-scenes-from-your-widget-or-live-activity)
- [Adding accessible descriptions](https://developer.apple.com/documentation/activitykit/adding-accessible-descriptions-to-widgets-and-live-activities)
- [App Intents](https://developer.apple.com/documentation/appintents)
