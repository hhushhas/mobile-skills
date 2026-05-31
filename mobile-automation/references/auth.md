# Auth Automation

Use this reference for native auth setup, Sign in with Apple, Google Sign-In, Firebase Auth, OAuth provider config, Universal Links, Android App Links, and custom schemes.

## Default Strategy

Automate app-local config and provider API work. Treat OAuth client ownership and one-time private keys as credential-custody tasks unless credentials already exist as secure refs.

Prefer verified Universal Links and Android App Links for auth redirects when possible. Use custom URL schemes only when the provider/framework requires them or as a secondary fallback.

## Workflow

1. Discover auth provider(s), bundle ID, package name, Firebase project/app IDs, Apple team ID, domains, redirect URLs, and signing mode.
2. Inspect local iOS/Android/Expo/Flutter config for entitlements, URL schemes, intent filters, Associated Domains, and App Links.
3. Extract Android SHA-1/SHA-256 fingerprints from debug/upload/production signing keys when available.
4. Configure supported Apple capabilities and regenerate profiles.
5. Configure Firebase project/apps/SHA/provider config when credentials exist.
6. Generate or validate `apple-app-site-association` and `assetlinks.json`.

## Automatable

Apple:

- Create/locate Bundle ID with Apple's account APIs when credentials allow it.
- Enable supported capabilities such as `APPLE_ID_AUTH` and `ASSOCIATED_DOMAINS`.
- Patch entitlements and `Info.plist` URL schemes.
- Regenerate/download provisioning profiles through Apple's account APIs or fastlane `sigh`/`match`.
- Generate AASA content when the domain/path contract is known.

Firebase/Google:

- Create/list Firebase projects/apps with Firebase CLI or Management API.
- Download `google-services.json` and `GoogleService-Info.plist`.
- Add/list/delete Android SHA fingerprints.
- Configure Firebase Auth OAuth identity providers through Identity Platform REST API when client ID/secret values are already available as refs.
- Generate `assetlinks.json`.

Local app:

- Patch Android intent filters and `android:autoVerify`.
- Patch iOS Associated Domains and URL schemes.
- Add reviewer-access notes and credential refs.

## Manual Or Console-Heavy

- Initial Apple API key creation/download.
- Apple Developer Program enrollment, agreements, and role grants.
- Sign in with Apple web Services ID, domain/return URL association, private key, and private relay email setup when not already present.
- Standard Google Auth Platform native OAuth client creation for Android/iOS app clients.
- Production signing SHA fingerprints when they are controlled by a provider console.

## Commands And Checks

Firebase:

```bash
firebase projects:list
firebase apps:list --project PROJECT_ID
firebase apps:create android APP_NAME --package-name com.example.app --project PROJECT_ID
firebase apps:create ios APP_NAME --bundle-id com.example.app --project PROJECT_ID
firebase apps:sdkconfig android FIREBASE_APP_ID > android/app/google-services.json
firebase apps:sdkconfig ios FIREBASE_APP_ID > ios/GoogleService-Info.plist
firebase apps:android:sha:list FIREBASE_APP_ID
firebase apps:android:sha:create FIREBASE_APP_ID SHA_HASH
```

Android fingerprints:

```bash
./gradlew signingReport
keytool -list -v -keystore path/to/keystore.jks -alias upload
```

Android App Links verification:

```bash
adb shell pm get-app-links --user 0 com.example.app
adb shell am start -a android.intent.action.VIEW -d "https://example.com/auth/callback" com.example.app
```

iOS profile/entitlement inspection:

```bash
security cms -D -i path/to/profile.mobileprovision | plutil -p -
codesign -d --entitlements :- path/to/App.app
```

## Risks

- Android package name + SHA-1 pairings must be unique across Firebase/Google Cloud projects; stale clients can block setup.
- Provider-managed signing certificate SHA can differ from local upload/debug keystores.
- Capability changes can invalidate old provisioning profiles.
- Modern Android Google Sign-In commonly uses the server/web client ID in app code, not the Android client ID.
- Firebase Dynamic Links is deprecated/shut down; do not choose it for new auth/deep-link work.

## Sources

- Apple Bundle IDs API: https://developer.apple.com/documentation/appstoreconnectapi/bundle-ids
- Apple capability types: https://developer.apple.com/documentation/appstoreconnectapi/capabilitytype
- Apple capabilities guidance: https://developer.apple.com/help/account/identifiers/enable-app-capabilities
- Sign in with Apple overview: https://developer.apple.com/help/account/capabilities/about-sign-in-with-apple/
- Firebase CLI: https://firebase.google.com/docs/cli
- Firebase Management API: https://firebase.google.com/docs/reference/firebase-management/rest
- Firebase Auth OAuth REST config: https://firebase.google.com/docs/auth/configure-oauth-rest-api
- Firebase Google Sign-In Android: https://firebase.google.com/docs/auth/android/google-signin
- Apple Associated Domains: https://developer.apple.com/documentation/xcode/supporting-associated-domains
- Android App Links verification: https://developer.android.com/training/app-links/verify-applinks
- Firebase Dynamic Links FAQ: https://firebase.google.com/support/dynamic-links-faq
