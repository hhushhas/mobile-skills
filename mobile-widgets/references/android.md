# Android: App Widgets and Jetpack Glance

Android widgets are launcher-hosted remote surfaces. Use Jetpack Glance for a Compose-based app when its supported APIs cover the design; use traditional `RemoteViews` when the project already uses it or needs a view/API that Glance cannot express. In both cases, keep the widget stateless and read a persisted application snapshot because the widget host and app process are separate.

## Product and layout

- Follow [Android’s App Widgets overview](https://developer.android.com/develop/ui/views/appwidgets/overview) and [design guidance](https://developer.android.com/develop/ui/views/appwidgets/layouts). Start with one primary job and classify the surface as information, collection, or control before adding actions.
- For Glance, prefer `SizeMode.Responsive` with a small set of deliberate layouts and branch on `LocalSize`. For `RemoteViews`, provide responsive or exact layouts and correct `AppWidgetProviderInfo` size and resize metadata. A compact layout should answer the question immediately; larger layouts may add context or one safe action.
- Use Material role colors, dynamic system color where available, light/dark resources, system widget background and corner treatment, readable typography, and meaningful content descriptions. Avoid fixed brand colors that ignore the launcher’s theme or a layout that only looks right in one emulator.
- Use `actionStartActivity` or a deep link for navigation. Use an `ActionCallback` or supported widget action for a state change. Keep destructive or hard-to-reverse actions out of one-tap widget controls.

## State and updates

Read the same persisted source used by the app, such as the project’s database, preferences, or a versioned serialized snapshot. Do not hold application state in a `GlanceAppWidget` instance or assume the main activity remains alive. If the widget has its own configuration, store that separately and bind it to the widget instance.

Update immediately after a user changes displayed data in the app or widget, and handle relevant broadcasts such as locale, time, and time-zone changes. Use periodic updates only for content that genuinely changes without an app event; do not poll every minute. Follow [Manage and update GlanceAppWidget](https://developer.android.com/develop/ui/compose/glance/glance-app-widget) and let the platform’s current limits win over remembered values.

For alarms and other scheduled products, make the scheduler or canonical store the source of widget invalidation. Trigger an update after creation, edit, fire, snooze, dismiss, reboot recovery, time-zone or locale changes, permission changes, and scheduler reconciliation. Re-read the canonical next occurrence during rendering so a delayed callback or recreated widget cannot display an old schedule.

## Implementation

Declare the provider metadata and receiver in the manifest, inspect the merged manifest, and verify exported status, preview resources, min/max sizes, resize mode, and any configuration activity. Use `AppWidgetManager.requestPinAppWidget()` only as an optional convenience: if the launcher does not support pinning or an OEM permission blocks it, show a launcher-picker path and a device-specific settings fallback rather than claiming the pin succeeded.

Provide a widget-picker preview. On current Android releases, use generated Glance previews where supported and retain a `previewImage` fallback for older launchers. Update the preview when the visual design changes. Check [generated previews](https://developer.android.com/develop/ui/compose/glance/generated-previews) and the project’s compile SDK before choosing APIs.

Use the current stable or approved Glance version from the project’s dependency catalog and the [Glance release notes](https://developer.android.com/jetpack/androidx/releases/glance); do not copy a version from this reference into a build without checking live project constraints.

## Verification

Run the project’s normal Android unit, lint, and build gates on the approved execution host. Build the signed device artifact, install it on an emulator and a physical device with a real launcher when Android is in scope, and verify the package and signing identity before testing. A generic path for an APK is:

```bash
./gradlew :app:assembleRelease --no-daemon
apksigner verify --verbose --print-certs <release-apk>
adb install -r <release-apk>
```

If the release artifact is an AAB, verify its signing certificate with `jarsigner -verify -verbose -certs <release-aab>` and create a device-specific APK set with the approved upload keystore. Keep passwords in secret-backed files rather than command history or logs:

```bash
bundletool get-device-spec --output=<device-spec.json>
bundletool build-apks --bundle=<release-aab> --output=<release.apks> \
  --device-spec=<device-spec.json> --ks=<upload-keystore> \
  --ks-key-alias=<alias> --ks-pass=file:<keystore-password-file> \
  --key-pass=file:<key-password-file>
bundletool install-apks --apks=<release.apks>
```

Use the project’s approved signing identity and confirm the installed package matches the intended application ID and certificate before testing.

Test adding and removing the widget, every supported size and resize breakpoint, picker preview, empty/off/error states, light/dark and dynamic color, accessibility, deep links, every action, app-to-widget refreshes, widget-to-app refreshes, all scheduler reconciliation events, locale/time-zone changes, reboot or process death, and at least one OEM launcher. Inspect the merged manifest and confirm no widget update path silently fails. Do not report physical-device readiness without proof on a real Android device when one is in scope.

For store media or release work, load `mobile-screenshots` and `mobile-submission` through Skillbox. A widget screenshot must come from a reachable installed build and must not be presented as product behavior if the widget cannot actually be placed or configured.

## Sources

- [App widgets overview](https://developer.android.com/develop/ui/views/appwidgets/overview)
- [Create a simple widget](https://developer.android.com/develop/ui/views/appwidgets)
- [Provide flexible widget layouts](https://developer.android.com/develop/ui/views/appwidgets/layouts)
- [Build UI with Glance](https://developer.android.com/develop/ui/compose/glance/build-ui)
- [Manage and update GlanceAppWidget](https://developer.android.com/develop/ui/compose/glance/glance-app-widget)
- [Enable users to configure app widgets](https://developer.android.com/develop/ui/compose/glance/configuration)
- [Generated widget previews](https://developer.android.com/develop/ui/compose/glance/generated-previews)
- [Glance release notes](https://developer.android.com/jetpack/androidx/releases/glance)
