# Mobile Skills

[![skills.sh](https://skills.sh/b/hhushhas/mobile-skills)](https://skills.sh/hhushhas/mobile-skills)

Agent Skills compatible workflows for tedious iOS and Android app work.

Site: https://mobile-skills.msbilal.workers.dev

This repo currently contains:

- `mobile-submission`: prepare, review, and submit iOS/Android apps to App Store Connect and Google Play.
- `mobile-automation`: automate screenshots, demo videos, auth/deep-link setup, push notifications, provider checks, and precise human console guidance for dashboard-only gaps.

## Install

### Codex / Agent Skills compatible agents

Install the submission skill:

```bash
gh skill install hhushhas/mobile-skills mobile-submission
```

Install the automation skill:

```bash
gh skill install hhushhas/mobile-skills mobile-automation
```

Install from this repository once it is indexed by your skill manager:

```bash
npx skills add hhushhas/mobile-skills
```

You can also copy either skill folder into your agent's skills directory and invoke:

```text
$mobile-submission
$mobile-automation
```

### ChatGPT / OpenAI Skills

OpenAI skills can be uploaded from the Skills UI. Build the ZIPs and upload the one you want from ChatGPT's Skills page or your workspace skill editor:

```bash
./scripts/package.sh
# → dist/mobile-submission.zip, dist/mobile-automation.zip
```

### Claude Skills

Claude supports custom skill ZIP uploads. Build the ZIPs with `./scripts/package.sh` and upload from Claude's Skills customization page. Team/Enterprise sharing depends on your organization settings.

## Skills

### `mobile-submission`

Use this skill to take a mobile app from project discovery to App Store Connect and Google Play submission.

It covers:

- mobile store readiness review
- App Store Connect and Google Play app-record bootstrap
- rejection-risk gates
- submission packet generation
- guided human console tasks for dashboard-only fields
- Apple and Google CLI/API execution
- dry-run, submit, and resume flows
- optional ASO, store conversion, and paid acquisition growth pass

Expected project artifacts:

```text
scratchpad/mobile-submission-packet.yaml
scratchpad/mobile-submission-ledger.md
scratchpad/mobile-console-human-tasks.md
scratchpad/mobile-submission-learnings.md
scratchpad/mobile-submission-memory.md
```

### `mobile-automation`

Use this skill to reduce repetitive mobile app setup work.

It covers:

- screenshot capture and organized output folders
- demo video recording
- Maestro-first capture with fastlane/native CLI fallbacks
- Sign in with Apple, Google Sign-In, Firebase Auth, Universal Links, and Android App Links setup checks
- APNs, FCM, Expo/EAS, and push credential setup checks
- CLI/API execution where reliable
- exact human console tasks for credential-custody and dashboard-only gaps

Optional helper artifact:

```text
scratchpad/mobile-capture-plan.yaml
```

## Safety

These skills are designed to avoid accidental account/store changes:

- `mobile-submission` uses `dry-run` by default.
- Store submission requires explicit submit intent.
- `mobile-automation` calls out provider account writes before execution.
- Secrets must be referenced, not pasted.
- Dashboard-only work defaults to guided human console tasks, not browser automation.

Never commit project scratchpads, credential files, private memory, App Store Connect keys, Google service account JSON, keystores, provisioning profiles, certificates, APNs keys, OAuth secrets, reviewer passwords, or device tokens.

## Repository Layout

```text
mobile-submission/
  SKILL.md
  assets/mobile-submission-packet-template.yaml
  agents/openai.yaml
  references/

mobile-automation/
  SKILL.md
  assets/mobile-capture-plan-template.yaml
  agents/openai.yaml
  references/
```

## License

MIT
