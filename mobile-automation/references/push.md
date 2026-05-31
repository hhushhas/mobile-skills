# Push Automation

Use this reference for APNs, FCM, Expo Push Service, push credentials, notification entitlements, native config, and push smoke tests.

## Default Strategy

Use Firebase/FCM as the default cross-platform push path unless the project already uses Expo Push Service, OneSignal, Braze, or a custom provider.

Android FCM is mostly automatable. iOS APNs is split: automate capabilities, entitlements, profiles, and validation; treat `.p8` key creation/download and Firebase APNs upload as credential-custody or console tasks unless a supported tool such as EAS handles credentials interactively.

Prefer APNs token auth keys over TLS certificates unless a vendor requires certificates.

## Workflow

1. Discover push provider, framework, bundle ID, package name, Firebase project/app IDs, Apple team ID, Expo project ID, and credential refs.
2. Inspect local permissions, notification handlers, Gradle dependencies, iOS entitlements, background modes, and provisioning profiles.
3. For Android FCM, create/list Firebase app, download config, patch dependencies, and build.
4. For iOS, enable Push Notifications capability, patch entitlements, regenerate profiles, and validate `aps-environment`.
5. For Expo/EAS, prefer EAS credential flow when project security posture accepts Expo-hosted credentials.
6. Run a real-device smoke test when device token and send credentials are available.

## Automatable

Android/Firebase:

- Firebase project/app discovery or creation.
- `google-services.json` download.
- Gradle plugin/dependency checks and local patches.
- FCM HTTP v1 send smoke test with service-account access and a real device token.

iOS/Apple:

- Bundle ID lookup/create.
- Enable Push Notifications capability where supported.
- Patch `aps-environment` entitlements and notification usage strings/handlers when needed.
- Regenerate provisioning profiles.
- Validate profile and signed app entitlements.

Expo/EAS:

- Run `eas credentials` and `eas build` when the user accepts interactive Expo credential management.
- Validate `expo-notifications` config and EAS project IDs.

## Manual Or Console-Only

- Apple APNs `.p8` key creation/download in Certificates, Identifiers & Profiles.
- Apple API key bootstrap; Apple account API keys are not APNs keys.
- Firebase iOS APNs key upload; official docs describe Firebase Console upload and no documented Firebase CLI/Management API endpoint was found.
- Physical-device push validation when no real device/token is available.

## Commands And Checks

Firebase:

```bash
firebase projects:list
firebase apps:list --project PROJECT_ID
firebase apps:create android APP_NAME --package-name com.example.app --project PROJECT_ID
firebase apps:create ios APP_NAME --bundle-id com.example.app --project PROJECT_ID
firebase apps:sdkconfig android FIREBASE_APP_ID > android/app/google-services.json
firebase apps:sdkconfig ios FIREBASE_APP_ID > ios/GoogleService-Info.plist
```

Android:

```bash
./gradlew :app:dependencies
./gradlew :app:assembleRelease
```

iOS:

```bash
security cms -D -i path/to/profile.mobileprovision | plutil -p -
codesign -d --entitlements :- path/to/App.app
```

FCM smoke test:

```bash
curl -X POST \
  -H "Authorization: Bearer $(gcloud auth application-default print-access-token)" \
  -H "Content-Type: application/json" \
  "https://fcm.googleapis.com/v1/projects/PROJECT_ID/messages:send" \
  -d '{"message":{"token":"DEVICE_FCM_TOKEN","notification":{"title":"Test","body":"Hello"}}}'
```

## Risks

- Stale iOS provisioning profiles are the most common push setup failure after enabling capabilities.
- APNs `.p8` files are one-time-download secrets. If lost, rotate rather than trying to recover.
- Push does not have a meaningful simulator-only final verification path; use a physical device for confidence.
- Expo/EAS is often the smoothest Expo path, but it keeps credentials with Expo.
- Never commit `.p8`, `.p12`, service account JSON, provisioning profiles, keystores, or device tokens.

## Sources

- Apple APNs token auth: https://developer.apple.com/help/account/capabilities/communicate-with-apns-using-authentication-tokens
- Apple private service keys: https://developer.apple.com/help/account/keys/create-a-private-key/
- Apple capability types: https://developer.apple.com/documentation/appstoreconnectapi/capabilitytype
- Firebase CLI: https://firebase.google.com/docs/cli
- Firebase Android setup: https://firebase.google.com/docs/android/setup
- FCM Android setup: https://firebase.google.com/docs/cloud-messaging/android/get-started
- FCM iOS setup: https://firebase.google.com/docs/cloud-messaging/get-started?platform=ios
- Expo push setup: https://docs.expo.dev/push-notifications/push-notifications-setup/
- Expo FCM credentials: https://docs.expo.dev/push-notifications/fcm-credentials/
- OneSignal Create App API: https://documentation.onesignal.com/reference/create-an-app
