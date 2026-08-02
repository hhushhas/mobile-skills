# Store listing and brand guide

A store listing is the app's product position in a few fields. It should help the right person recognize a real problem, understand how the app solves it, and believe the promise because the copy points to features they can use in the submitted build. Treat it as a marketing and branding document grounded in product truth, not as a feature dump or a search-keyword exercise.

## Start with product truth

Before writing, inspect the submitted build and the source that produces it. Resolve:

- The current product name, platform coverage, release state, and the primary audience. A first-release draft should say so when no public store presence exists, because “available now” is not true until the listing is live.
- The painful moment and the outcome the app changes. A useful positioning sentence is: “When `<person>` is dealing with `<specific problem>`, `<app>` uses `<real mechanism>` so they can `<concrete outcome>`.”
- The features a reviewer can reach from a clean install, including auth, permissions, network requirements, limits, paid paths, supported languages, and account deletion. These facts determine what the copy can promise.
- Data handling that affects trust: whether audio, images, transcripts, health data, identifiers, diagnostics, or account data leave the device, how long they are kept, and whether the user can delete them.
- Platform differences, disabled release features, unfinished flows, and dependencies that are present in source but unavailable or unproven in the build. A feature belongs in the listing only when the submitted app exposes it and the reviewer can use it.

Use the live store state for existing titles, descriptions, release status, and metadata. Local docs preserve the copy and the decisions the store cannot return; they do not prove that a listing was uploaded or published.

## Keep one canonical project draft

Create or update `docs/store-listing.md` in the app repository. Read an existing file before changing it, preserve its useful platform sections, and rewrite it in place so it describes the final intended listing as one coherent document. Keep factual notes at the top when they affect the release, such as Android-only coverage, first-submission status, a replacement for stale copy, or a confirmed pre-submission blocker.

Use this shape:

```markdown
# <Product> store listing draft

<Platform or release-state note, when it changes how the draft should be read.>

## Pre-submission blockers
- <Confirmed issue, consequence, and required fix.>

## Title
<Product> — <specific outcome or use case>

## Short description
<One sentence that names the audience or pain and the mechanism or outcome.>

## Google Play full description
<Problem-led description with benefit sections and a short close.>

## Apple App Store subtitle
<Short category or outcome.>

## Apple App Store keywords
<Comma-separated, truthful search terms.>

## Apple App Store promotional text
<A concise reason to choose the app now.>

## Apple App Store description
<Platform-accurate version of the full description.>

## Google testing instructions
<Exact clean-install path, account requirements, permissions, and test data.>

## Apple review notes
<Exact review path and platform-specific permission or data behavior.>

## Claims deliberately avoided (keep it this way)
- <Unsupported or risky claim, with the factual reason it stays out.>
```

Omit sections for platforms that do not ship. Add a `Pre-submission blockers` section only when there is a real issue, and state the consequence and owner input clearly. A `TODO` is acceptable for a missing authorized value such as review credentials, but it must remain visibly unresolved and must never be replaced with an invented claim or secret.

## Write the position before the fields

Choose one primary user and one recognizable moment. Open with the situation they are trying to escape: a missed alarm, a talk they cannot follow, work split between chat and a task board, or another specific cost of the current approach. The first paragraph should make that person feel seen before it explains the product.

Then name the mechanism that makes the app different. “Tracks drinks” is a category; “counts chai, coffee, milk, and juice at water-equivalent values” explains why this tracker is worth using. “Uses AI” is a technology label; “suggests tasks from conversation and cites the evidence, with confirmation before anything changes” describes a trustworthy product behavior.

End the main description with the practical outcome and a short invitation to use the app. Keep the voice concrete, warm, and assured. Prefer a specific noun or verb over words such as seamless, revolutionary, powerful, or best.

## Field conventions

**Title:** Use `<Brand> — <clear outcome or use case>` by default. Use an em dash, not a colon: `Super Alarm — Scan to Wake Up`. Keep the brand first and make the second half understandable to someone who has never heard of the app. Do not turn the title into a keyword list, attach an unsupported platform claim, or promise a result the app cannot produce.

**Short description:** Make one sentence that connects the audience or pain to the mechanism or outcome. It should add information beyond the title, so “the fastest” or a slogan alone is not enough. Keep it readable at a glance and validate it against the current store limit before upload.

**Full description:** Use a problem-led opening, then a small number of benefit-oriented sections. Each bullet should name a real capability and explain why it matters to the user. A useful sequence is:

1. **Recognize the problem.** Show a concrete situation in two or three short paragraphs.
2. **Explain the core job.** Describe the app's main flow and the outcome it creates.
3. **Group supporting features by benefit.** Use headings such as “Log in seconds,” “Built for real rooms,” or “Private by design,” then give evidence in concise bullets.
4. **State important limits and trust facts.** Mention connectivity, account requirements, supported languages, retention, or a required wellness disclaimer when they affect a reasonable user's decision.
5. **Close with the outcome.** Give the reader a reason to start using the app without adding a guarantee.

Write separate platform descriptions when the builds differ. Apple copy can share the same position and evidence, but it must not claim Android-only features, unsupported device behavior, or a flow that iOS cannot reach.

**Apple fields:** Make the subtitle a compact category or outcome that complements the title. Use keywords for truthful use cases, audiences, and supported capabilities; remove terms that are already redundant or that the app does not support. Promotional text should reinforce the central reason to choose the app. Keep the description aligned with the build and the Google copy while preserving platform-specific behavior.

**Review and testing notes:** Give a reviewer the shortest reliable path through a clean install. Include whether an account is required, how to reach the main feature, which permissions to grant and why, whether an internet connection is needed, and what data is sent or retained. Keep credentials as secure references or authorized submission inputs, never in the listing document or chat.

## Claims discipline

Maintain `Claims deliberately avoided (keep it this way)` as a living guardrail. Record claims that sound attractive but are false, unshipped, unverified, legally sensitive, or easy for a reviewer to disprove. Recheck this list whenever the build changes.

Common exclusions include:

- Future, disabled, stubbed, or platform-specific features that the submitted build does not expose.
- “Free,” “no ads,” “unlimited,” pricing, or subscription claims when the current product or checkout does not establish them.
- “No account required,” “works offline,” “on-device AI,” “nothing leaves your phone,” or “no data collected” unless the actual auth, network, SDK, and storage paths prove the exact wording.
- Accuracy, reliability, health, weight-loss, financial, safety, or other outcome guarantees that the product cannot substantiate.
- Store availability, cross-platform support, device support, language counts, or integrations that are planned, incomplete, or absent from the release build.
- Security or privacy absolutes when the service uses cloud processing, anonymous identifiers, diagnostics, analytics, or retention that the phrase would hide.

The listing should say what the app does and what the user can verify. It should not borrow trust from a stronger claim than the product earns.

## Final review

Before sending metadata to `asc` or `gplay`, check the draft against the exact artifact and current store limits:

- The title uses the brand plus an outcome with an em dash, and every field is within the current platform limit.
- The opening pain point, mechanism, screenshots, and final call to action describe the same product position.
- Every feature, number, language, permission, privacy statement, and platform claim is reachable or provable in the submitted build.
- Google and Apple sections agree on the product while accounting for real platform differences.
- Testing instructions work from a clean install, and review credentials or other sensitive values are supplied through the authorized submission path.
- Blockers and intentionally avoided claims are explicit, so a later agent does not mistake an aspirational draft for release-ready copy.

When listing copy drives branded screenshots or other store media, pass the central promise and its short headlines to `mobile-screenshots`, then follow that skill's capture and validation workflow.
