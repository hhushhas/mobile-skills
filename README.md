# Mobile Skills

[![skills.sh](https://skills.sh/b/hhushhas/mobile-skills)](https://skills.sh/hhushhas/mobile-skills)

Agent Skills for iOS and Android store work, field-tested on real submissions — new apps taken to production, rejections recovered, stale listings revived. The skills carry only what agents get wrong without them: the fragile store-specific gotchas, exact commands where sequences silently fail, and judgment calls reviewers actually enforce. Everything else is left to the model.

- **`mobile-submission`** — take an app from repo to the stores: readiness review against what reviewers actually reject, builds, App Store Connect and Google Play upload and submission, rejection recovery.
- **`mobile-screenshots`** — store-compliant listing media (screenshots, icons, feature graphics, previews) from simulators and emulators, no physical device needed: capture natively at accepted sizes, clean the status bar, validate locally, upload.

The working philosophy: CLI-first through [`asc`](https://github.com/rorkai/App-Store-Connect-CLI) (App Store Connect) and [`gplay`](https://github.com/tamtom/play-console-cli) (Google Play), browser automation for web-only console forms, and the human only for steps an account owner must personally do. Live state is the source of truth — the store over any local ledger, each subcommand's `--help` over any written table, no packets or state files. For deeper metadata, pricing, and multi-locale pipelines, the CLIs ship companion packs: [app-store-connect-cli-skills](https://github.com/rorkai/app-store-connect-cli-skills), [gplay-cli-skills](https://github.com/tamtom/gplay-cli-skills).

## Install

```bash
gh skill install hhushhas/mobile-skills mobile-submission
gh skill install hhushhas/mobile-skills mobile-screenshots
```

Or once indexed by your skill manager:

```bash
npx skills add hhushhas/mobile-skills
```

You can also copy a skill folder into your agent's skills directory and invoke `$mobile-submission` / `$mobile-screenshots`.
