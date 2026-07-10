# Mobile Skills

[![skills.sh](https://skills.sh/b/hhushhas/mobile-skills)](https://skills.sh/hhushhas/mobile-skills)

Agent Skills for iOS and Android store work.

This repo contains one skill:

- `mobile-submission`: take an iOS/Android app from repo to the stores — readiness review against Apple and Google policy, version bumps, builds, App Store Connect and Google Play upload and submission, and rejection recovery.

It works CLI-first through [`asc`](https://github.com/rorkai/App-Store-Connect-CLI) (App Store Connect) and [`gplay`](https://github.com/tamtom/play-console-cli) (Google Play), uses browser automation for web-only console forms, and hands the human only the steps an account owner must personally do. The store is treated as the source of truth — no packets, ledgers, or state files.

A former `mobile-automation` skill (screenshots, auth, push) was removed; a focused screenshot skill may return later. The `asc`/`gplay` companion skill packs ([app-store-connect-cli-skills](https://github.com/rorkai/app-store-connect-cli-skills), [gplay-cli-skills](https://github.com/tamtom/gplay-cli-skills)) already cover screenshot upload, metadata, and pricing work.

## Install

### Codex / Agent Skills compatible agents

```bash
gh skill install hhushhas/mobile-skills mobile-submission
```

Or once indexed by your skill manager:

```bash
npx skills add hhushhas/mobile-skills
```

You can also copy the skill folder into your agent's skills directory and invoke `$mobile-submission`.

### ChatGPT / OpenAI Skills

Zip the `mobile-submission/` folder and upload it from ChatGPT's Skills page or your workspace skill editor.

### Claude Skills

Zip the `mobile-submission/` folder and upload it from Claude's Skills customization page. Team/Enterprise sharing depends on your organization settings.

## Repository Layout

```text
mobile-submission/
  SKILL.md
  references/
    apple.md
    google.md
```

Never commit credential files, App Store Connect keys, Google service account JSON, keystores, provisioning profiles, certificates, APNs keys, OAuth secrets, reviewer passwords, or device tokens.

## License

MIT
