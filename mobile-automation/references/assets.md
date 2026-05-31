# Assets Automation

Use this reference for screenshots, App Store app previews, Google Play preview video prep, feature graphics, and store media upload.

## Default Strategy

Default to Maestro for cross-platform capture unless the repo already has a mature native test stack.

Provider selection:

- Maestro: best default for Expo, React Native, Flutter, native iOS, native Android, and mixed apps.
- fastlane `snapshot`: best when iOS XCUITest screenshot flows already exist.
- fastlane `screengrab`: best when Android Espresso/instrumentation screenshot tests already exist.
- `xcrun simctl` + `adb`: raw fallback for simple manual capture scripts.
- Detox: good for React Native projects that already use Detox.
- Appium: good when the team already uses WebDriver.
- Firebase Test Lab: good for Android device coverage/evidence, not polished store creatives.

## Workflow

1. Discover framework, app IDs, existing test flows, build commands, supported locales, store media folders, and target devices.
2. Create `scratchpad/mobile-capture-plan.yaml` from `assets/mobile-capture-plan-template.yaml`.
3. Build/install app on simulator/emulator or use an existing artifact.
4. Run flows and capture raw screenshots/videos.
5. Normalize output paths, dimensions, format, naming, and locale folders.
6. Validate against Apple/Google media constraints.
7. Dry-run upload or upload only when explicitly authorized.

## CLI Recipes

Maestro:

```bash
maestro test .maestro/store-home.yaml
maestro record --local store/previews/core-flow.mp4 .maestro/core-flow.yaml
```

iOS raw capture:

```bash
xcrun simctl io booted screenshot store/screenshots/ios/en-US/iphone_6_9/home.png
xcrun simctl io booted recordVideo --codec h264 store/previews/en-US/core-flow.mp4
```

Android raw capture:

```bash
adb exec-out screencap -p > store/screenshots/android/en-US/phone/home.png
adb shell screenrecord /sdcard/core-flow.mp4
adb pull /sdcard/core-flow.mp4 store/previews/en-US/core-flow.mp4
```

fastlane:

```bash
bundle exec fastlane snapshot
bundle exec fastlane screengrab
bundle exec fastlane deliver --skip_binary_upload true
bundle exec fastlane supply --skip_upload_apk true --skip_upload_aab true
```

## Store Constraints To Check

Apple:

- Screenshots: 1-10 screenshots, `.jpeg`, `.jpg`, or `.png`.
- App previews: optional, up to 3 per supported display size/language; `.mov`, `.m4v`, or `.mp4`.
- App Preview processing can be asynchronous; report pending processing as `ready_warn`.

Google Play:

- Screenshots: at least 2, JPEG or 24-bit PNG with no alpha, min 320px, max 3840px.
- Preview video is a YouTube URL in listing metadata; video hosting is outside the Play media upload itself.

## Upload Paths

- Apple: prefer fastlane `deliver`; use App Store Connect API screenshot/app-preview resources when direct API control is needed.
- Google: prefer fastlane `supply` or Android Publisher API `edits.images.upload`.
- For first-time store records, run the submission skill or generate human console tasks first.

## Verification

- List generated files and dimensions.
- Open a representative screenshot/video locally when possible.
- Confirm no alpha channel for Google screenshots.
- Confirm Apple preview codec/container when previews exist.
- Dry-run upload if supported by the chosen CLI.

## Sources

- fastlane snapshot: https://docs.fastlane.tools/actions/snapshot/
- fastlane screengrab: https://docs.fastlane.tools/actions/screengrab/
- Apple screenshots/App Previews: https://developer.apple.com/help/app-store-connect/manage-app-information/upload-app-previews-and-screenshots/
- App Store Connect screenshot sets API: https://developer.apple.com/documentation/appstoreconnectapi/app_screenshot_sets
- Google Play media upload: https://developers.google.com/android-publisher/upload
- Android adb: https://developer.android.com/tools/adb
- Firebase Test Lab Robo tests: https://firebase.google.com/docs/test-lab/android/robo-ux-test
- Maestro CLI: https://docs.maestro.dev/maestro-cli
