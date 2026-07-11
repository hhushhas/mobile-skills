# Mobile Skills

[![skills.sh](https://skills.sh/b/hhushhas/mobile-skills)](https://skills.sh/hhushhas/mobile-skills)

Agent Skills for iOS and Android store work.

This repo contains two skills:

- `mobile-submission`: take an iOS/Android app from repo to the stores — readiness review against Apple and Google policy, version bumps, builds, App Store Connect and Google Play upload and submission, and rejection recovery.
- `mobile-screenshots`: generate and upload store-compliant listing media (screenshots, icons, feature graphics, previews) from simulators and emulators — no physical device needed.

Both work CLI-first through [`asc`](https://github.com/rorkai/App-Store-Connect-CLI) (App Store Connect) and [`gplay`](https://github.com/tamtom/play-console-cli) (Google Play), use browser automation for web-only console forms, and hand the human only the steps an account owner must personally do. The store is treated as the source of truth — no packets, ledgers, or state files. The `asc`/`gplay` companion skill packs ([app-store-connect-cli-skills](https://github.com/rorkai/app-store-connect-cli-skills), [gplay-cli-skills](https://github.com/tamtom/gplay-cli-skills)) go deeper on metadata, pricing, and multi-locale screenshot pipelines.

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