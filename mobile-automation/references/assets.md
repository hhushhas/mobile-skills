# Screenshots And Videos

Use this reference for app screenshots, screen recordings, and demo videos.

## Default Strategy

Default to Maestro for cross-platform capture unless the repo already has a mature native test stack.

Provider selection:

- Maestro: best default for Expo, React Native, Flutter, native iOS, native Android, and mixed apps.
- fastlane `snapshot`: good when iOS XCUITest screenshot flows already exist.
- fastlane `screengrab`: good when Android Espresso/instrumentation screenshot tests already exist.
- `xcrun simctl` + `adb`: raw fallback for simple scripted captures.
- Detox: good for React Native projects that already use Detox.
- Appium: good when the team already uses WebDriver.
- Firebase Test Lab: useful for Android coverage/evidence, not polished demo capture.

## Workflow

1. Discover framework, app IDs, existing test flows, build commands, target device classes, and output folders.
2. Reuse existing Maestro/Detox/Appium/XCTest/Espresso flows when available.
3. If helpful, create a small capture plan from `assets/mobile-capture-plan-template.yaml`.
4. Build/install the app on a simulator/emulator or use an existing debug artifact.
5. Run flows and capture raw screenshots/videos.
6. Normalize filenames and folders.
7. Open representative outputs and confirm they show the intended app state.

## CLI Recipes

Maestro:

```bash
maestro test .maestro/home.yaml
maestro record --local screenshots/core-flow.mp4 .maestro/core-flow.yaml
```

iOS raw capture:

```bash
xcrun simctl io booted screenshot screenshots/ios/home.png
xcrun simctl io booted recordVideo --codec h264 screenshots/ios/core-flow.mp4
```

Android raw capture:

```bash
adb exec-out screencap -p > screenshots/android/home.png
adb shell screenrecord /sdcard/core-flow.mp4
adb pull /sdcard/core-flow.mp4 screenshots/android/core-flow.mp4
```

fastlane:

```bash
bundle exec fastlane snapshot
bundle exec fastlane screengrab
```

## Verification

- Confirm generated files exist and are non-empty.
- Open one or more representative images/videos.
- Check orientation, status bars, permission prompts, clocks, test data, and blank/loading states.
- Repeat once if the capture flow depends on animation or network state.
- Keep credentials, device tokens, and private data out of captures.

## Common Failure Modes

- App opens to a permission dialog instead of the target screen.
- Network-backed demo data is missing or inconsistent.
- Animations make screenshots flaky.
- Auth state expires between runs.
- Simulator/emulator size differs from the intended target.
- Video starts before the app is settled or ends before the core action completes.

## Sources

- Maestro CLI: https://docs.maestro.dev/maestro-cli
- fastlane snapshot: https://docs.fastlane.tools/actions/snapshot/
- fastlane screengrab: https://docs.fastlane.tools/actions/screengrab/
- Android adb: https://developer.android.com/tools/adb
- Firebase Test Lab Robo tests: https://firebase.google.com/docs/test-lab/android/robo-ux-test
