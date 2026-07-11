# Android: emulator capture and gplay upload

Play's screenshot rule that bites: no side may exceed 2× the other — a modern 20:9 phone capture (1080×2400) fails it. A `pixel_2` AVD outputs 1080×1920 (16:9, and at the 1080p minimum Play wants for recommendation eligibility), which passes everything. Use an `arm64-v8a` system image on Apple Silicon.

## Capture

```bash
sdkmanager "system-images;android-36;google_apis;arm64-v8a"
avdmanager create avd --name play-shots --device pixel_2 \
  --package "system-images;android-36;google_apis;arm64-v8a"
emulator -avd play-shots -no-window -no-audio -gpu swiftshader_indirect &
adb wait-for-device
adb install -r app-release.apk

adb shell settings put global sysui_demo_allowed 1    # clean status bar: demo mode
adb shell am broadcast -a com.android.systemui.demo -e command enter
adb shell am broadcast -a com.android.systemui.demo -e command clock -e hhmm 0941
adb shell am broadcast -a com.android.systemui.demo -e command battery -e level 100 -e plugged false
adb shell am broadcast -a com.android.systemui.demo -e command network -e wifi show -e level 4
adb shell am broadcast -a com.android.systemui.demo -e command notifications -e visible false

adb exec-out screencap -p > shot.png                  # exec-out, not shell: a shell pipe corrupts binary
adb shell am broadcast -a com.android.systemui.demo -e command exit
```

Play bans status-bar carrier names and notifications in screenshots — demo mode isn't optional polish here. For Expo/RN, `npx expo run:android --variant release` installs into the running emulator. Driving to each state: deep links (`adb shell am start -a android.intent.action.VIEW -d <url>`), raw `adb shell input tap/swipe/text`, or a Maestro flow (same YAML works on the iOS simulator).

## Specs and upload

Screenshots: JPEG or 24-bit PNG, **no alpha**, each side 320–3840px, min 2 to publish, max 8 per device type; ≥4 at 1080p+ (16:9 or 9:16) for recommendation eligibility. Icon: 512×512 32-bit PNG **with** alpha, ≤1MB — note the inversion. Feature graphic: 1024×500, no alpha, required to publish and doubles as the promo-video cover.

Uploads live inside an edit like everything else: `gplay images upload --package <pkg> --edit <id> --locale en-US --type phoneScreenshots --file shot.png` (types: `phoneScreenshots`, `icon`, `featureGraphic`, tablet/TV/Wear variants — `gplay images --help` lists constraints), then validate and commit the edit. For keeping a local media tree in sync across locales, `gplay images pull/plan/sync` mirrors the fastlane directory layout.

After commit the change must still be **sent for review** and approved before it displays — hours to days. With managed publishing on, approved changes wait in "ready to publish" until manually published. Both look exactly like "my new icon won't show".
