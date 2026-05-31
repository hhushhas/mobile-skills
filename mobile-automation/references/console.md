# Human Console Tasks

Use this reference when CLI/API automation is unavailable, unsafe, or requires a one-time secret download.

## Task Shape

Each task should include:

- Title
- Why it is needed
- Direct URL, if known
- Fallback navigation
- Required role
- Fields and controls
- Exact value to enter/select/upload
- Secret-handling warning
- Confirmation evidence to return
- CLI/API validation to run afterward

Preserve dashboard control types. Do not turn checkboxes, radio buttons, dropdowns, file uploads, or questionnaires into prose.

## Known Console-Only Or Credential-Custody Tasks

### Apple API Key

- Direct URL: https://appstoreconnect.apple.com/access/integrations/api
- Fallback: Apple developer/account dashboard -> Users and Access -> Integrations -> API access.
- Required role: Admin for team keys.
- Control: button, Generate API Key.
- Fields:
  - Name: project-specific, for example `Mobile Automation CI`.
  - Access: least role that covers the needed Apple account work; use Admin only when provisioning endpoints or capability/profile management require it.
- Secret handling:
  - Download `.p8` once.
  - Store as `op://`, CI secret, or secure local ref.
  - Do not commit.
- Confirmation:
  - Key ID, Issuer ID, role, and secret ref.

### Apple APNs Auth Key

- Direct URL: https://developer.apple.com/account/resources/authkeys/list
- Fallback: Apple Developer -> Certificates, Identifiers & Profiles -> Keys.
- Required role: Account Holder or Admin.
- Control: button, add key.
- Fields:
  - Key Name: project-specific, for example `Acme APNs`.
  - Service checkbox: Apple Push Notification service.
  - Configure: choose team/environment options shown by Apple.
- Secret handling:
  - Download `.p8` once.
  - Record Key ID and Team ID.
  - Store as `op://`, CI secret, or secure local ref.
  - Do not commit.
- Confirmation:
  - Key ID, Team ID, bundle ID coverage, and secret ref.

### Firebase APNs Key Upload

- Direct URL: https://console.firebase.google.com/
- Fallback: Firebase Console -> Project Settings -> Cloud Messaging -> iOS app configuration -> APNs authentication key.
- Required role: Firebase project Owner/Editor or equivalent.
- Control: file upload.
- Fields:
  - APNs key file: secure `.p8` ref from Apple.
  - Key ID: Apple APNs key ID.
  - Team ID: Apple team ID.
- Secret handling:
  - Use the local secure file only for upload.
  - Do not copy key contents into chat or scratchpads.
- Confirmation:
  - Firebase project ID, iOS Firebase app ID, uploaded key ID, and timestamp.

### Google Auth Platform OAuth Client

- Direct URL: https://console.cloud.google.com/auth/clients
- Fallback: Google Cloud Console -> Google Auth Platform -> Clients.
- Required role: project Editor/Owner or credentials admin.
- Controls: Create client, application type dropdown, text fields.
- Android fields:
  - Application type: Android.
  - Package name: app package.
  - SHA-1 certificate fingerprint: debug/upload/provider-managed SHA-1 as required.
- iOS fields:
  - Application type: iOS.
  - Bundle ID: iOS bundle ID.
  - Team ID/app identifier: enter when the console requires it.
- Secret handling:
  - Store client secrets only in secret manager if created.
  - Mobile native client IDs are not secret, but keep exported JSON out of public chat.
- Confirmation:
  - Client ID, application type, package/bundle, SHA/team facts.

### Provider Signing Fingerprints

- Direct URL: https://play.google.com/console/
- Fallback: Play Console -> app -> Setup -> App integrity -> App signing.
- Required role: account access that can view app integrity/signing details.
- Fields:
  - Copy SHA-1 and SHA-256 for the App signing key certificate.
  - Copy upload key fingerprints if needed.
- Confirmation:
  - SHA-1, SHA-256, certificate type, app package, source path in the provider console.
