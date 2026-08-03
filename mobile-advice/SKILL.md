---
name: mobile-advice
description: "Mobile Advisory. Use when building a new app or improving an existing one. It provides advice on onboarding, widget, review prompts, branded sharing and links, branding, and ASO."
license: MIT
---

## A good app

- **Onboarding**: every app gets one. It is not hard, and forgetting it means bolting it on later. If one already exists, ensure it is up-to-date.
- **Widget**: consider whether a home-screen surface would reduce a repeat task; if so, load the `mobile-widgets` skill.
- **Review prompts**: call the native rating request (`requestReview` on iOS, the In-App Review API on Android) after a moment of earned success, never tied to a button and never at launch; the OS throttles it and won't say whether it showed.
- **Branded sharing and links**: share actions that carry the brand, and universal/app links that survive the trip.
- **Branding**: a real name, icon, color system, and voice, consistent across app, store, and web.
- **ASO**: deliberate title, subtitle, keywords, and category. Load the `mobile-submission` skill to read the listing reference.
- **Web presence and SEO**: the app's site with branded store links (and official store badges), support, and legal pages. Load the `marketing-site` skill when building it.
- **Targeting**: know who it's for and where; pick store categories, age ratings, and regions on purpose.
- **Localization**: shipping multiple regions and languages measurably lifts downloads; localize the app and the store metadata together.