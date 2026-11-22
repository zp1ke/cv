# Website dependency, CI, docs, and Play privacy policies

> **Status: in progress.** P1–P4 are done: Dependabot, the Astro 7 lockfile, CI pins, and the READMEs now match `main`, mise, and `https://sp1ke.dev`. Still to do: the Play privacy policies. Not tied to a release date.

Registry versions below were queried when this roadmap was written. Re-check them before editing manifests; do not treat them as permanent targets if a newer patch has shipped.

Play privacy requirements are taken from [Prepare your app for review](https://support.google.com/googleplay/android-developer/answer/9859455?hl=en#privacy_policy) (Privacy policy section). That article is not legal advice. It says to consult a legal representative for what a given app must disclose.

## Goal

Bring the website toolchain and its operator docs in line with what the repo actually builds and deploys.

1. `website/package-lock.json` installs an Astro release outside the `astro <=7.4.6` advisory range observed in `npm audit`.
2. Dependabot watches `website/` npm, and CI caches the lockfile with current Actions tags.
3. `README.md`, `README-DEV.md`, and `website/README.md` describe `main`, mise, and `https://sp1ke.dev` instead of missing tools and the old project-site URL.
4. `https://sp1ke.dev/forma` is a public HTML privacy policy for Forma, and the existing MineSweeper, AquaPact, and Teditox policy pages no longer contradict the apps or Play's privacy-policy rules.

## Why

- `npm ci` in `.github/workflows/deploy.yml` installs the lockfile, not the floating ranges in `website/package.json`. P2 replaced locked `astro@5.16.5` (inside `astro <=7.4.6`) with `astro@7.4.13`. `npm audit` on that lockfile now reports 0 vulnerabilities.
- Dependabot used to list only `package-ecosystem: devcontainers` at `/`, and there is no `.devcontainer`. P1 replaced that with weekly `npm` updates for `/website`. P3 pointed the npm cache at `website/package-lock.json` and bumped the four Actions pins.
- The READMEs used to describe `master`, `dev.sh`, a missing DevContainer, and `https://zp1ke.github.io/cv/`. P4 aligned them with deploy on `main`, `mise.toml`, and `https://sp1ke.dev`.
- Google Play requires a privacy-policy URL on the store listing and inside the app, even when the app does not access personal or sensitive data and does not target children. The URL must be an active public `http://` or `https://` page with a valid SSL certificate, reachable worldwide with no login and no geofencing, shown as a normal non-editable webpage (not a PDF), specific to that app, and it must disclose how the app collects, uses, and shares user data, including the types of parties it is shared with. Forma has no such page or in-app link. The policies already hosted here do not all meet that bar.

## Current state

| Area | Today |
|---|---|
| Direct deps | `website/package.json` depends on `astro@^7.4.13`. `@astrojs/check@^0.9.12` and `typescript@^5.9.3` are `devDependencies`. `engines.node` is `>=22.23.4`. |
| Lockfile | `website/package-lock.json` locks `astro@7.4.13`, `@astrojs/check@0.9.12`, and `typescript@5.9.3`. |
| Advisory | `npm audit` after the P2 install reported 0 vulnerabilities. `npm audit fix --force` was not used. |
| Registry (at writing) | Latest `astro` was `7.4.13` (`engines.node >=22.23.4`). Latest `astro@5` was `5.18.2`. Latest `@astrojs/check` was `0.9.12`, peer `typescript@^5.0.0 \|\| ^6.0.0`. Latest `typescript` was `7.0.2`; latest 5.x was the already-locked `5.9.3`. |
| Node pin | `mise.toml` `[tools] node = "22.23.5"`. CI `actions/setup-node@v7.1.0` uses `node-version: '22.23.5'`. `website/package.json` `engines.node` is `>=22.23.4`. |
| Dependabot | `.github/dependabot.yml` schedules weekly `npm` updates for `/website`. It does not list `devcontainers`. No `.devcontainer` directory. |
| CI | `.github/workflows/deploy.yml` triggers on `push` to `main` and `workflow_dispatch`. `node-version` is `22.23.5`. `cache-dependency-path` is `website/package-lock.json`. Actions: `actions/checkout@v7.0.1`, `actions/setup-node@v7.1.0`, `actions/upload-pages-artifact@v5.0.0`, `actions/deploy-pages@v5.0.1`. TeX Live is installed with `apt-get` on every build. |
| Actions tags (at writing) | Latest releases: `actions/checkout` `v7.0.1`, `actions/setup-node` `v7.1.0`, `actions/upload-pages-artifact` `v5.0.0`, `actions/deploy-pages` `v5.0.1`. |
| Site config | `website/astro.config.mjs` is `output: 'static'`, `site: 'https://sp1ke.dev'`, `base: '/'`. `website/public/CNAME` contains `sp1ke.dev`. |
| Docs | `README.md`, `README-DEV.md`, and `website/README.md` describe deploy on `main`, the live host `https://sp1ke.dev`, and `mise.toml` tasks. Node is documented as `22.23.5`. They do not tell the reader to source `dev.sh` or use a DevContainer. |
| Privacy pages | Astro routes: `website/src/pages/minesweeper.astro` (`/minesweeper`), `website/src/pages/aquapact.astro` (`/aquapact`), `website/src/pages/teditox.astro` (`/teditox`), wrapped by `website/src/layouts/PrivacyLayout.astro`. No `website/src/pages/forma.astro`. Pages are HTML, not PDFs. `website/astro.config.mjs` `site` is `https://sp1ke.dev` and `base` is `/`, so the public URLs are `https://sp1ke.dev/minesweeper`, `/aquapact`, and `/teditox`. |
| Forma | App repo `~/Documents/github/forma`. `android/app/build.gradle.kts` sets `applicationId = "com.sp1ke.forma"`. No privacy URL in `lib/`. Release `android/app/src/main/AndroidManifest.xml` requests `RECEIVE_BOOT_COMPLETED` and `SCHEDULE_EXACT_ALARM` only. `INTERNET` is only in the debug and profile manifests. `lib/data/services/android_alert_notifier.dart` requests notification and exact-alarm permission. Data stays on device (`sqflite`, `shared_preferences`): profiles (name, color, units, quiet hours), routines, session logs, body measurements and notes (`lib/domain/models/profile.dart`, `body_entry.dart`, `session_log.dart`). Export is a user-picked `forma-export.zip` via `file_picker` (`lib/data/services/export_files.dart`). |
| Existing policy gaps | `minesweeper.astro` is a generic template (last updated July 13, 2024). It asserts accounts, affiliates, first and last name, usage data, IP address, device IDs, Google login, and sharing with other users. MineSweeper source is not in this repo or `~/Documents/github`. `aquapact.astro` (February 12, 2025) describes local hydration data and no third-party sharing, but includes a non-disclosure bullet ("New Feature: Future updates may include additional features") and says changes are posted within the app rather than on this URL. `teditox.astro` (August 12, 2025) matches local files and settings, but does not state that the release manifest has no `INTERNET` permission. Teditox already opens `https://sp1ke.dev/teditox` from `about_screen.dart`, under a comment that still says "placeholder". All three contact `miche.atucha@gmail.com`. `PrivacyLayout.astro` renders an English-only slot. |

## Target

| Area | Target |
|---|---|
| Astro | Locked `astro` version is `>=7.4.7` and, unless a newer patch has superseded it, the latest 7.x re-checked at implementation time (`7.4.13` when this roadmap was written). |
| Checker and TypeScript | `@astrojs/check` and `typescript` are `devDependencies`. TypeScript stays on a range accepted by that check package's peer (observed `^5 \|\| ^6` for `0.9.12`). Do not set TypeScript 7 while check remains on `0.9.x`. |
| Node | `mise.toml`, `.github/workflows/deploy.yml`, and `website/package.json` `engines.node` require a Node 22 release that satisfies the chosen Astro `engines` field. |
| Dependabot | `.github/dependabot.yml` updates `npm` in `/website` on a weekly schedule and does not list `devcontainers`. |
| CI cache and Actions | `cache-dependency-path` is `website/package-lock.json`. The four Actions above are bumped to the latest release tags re-checked at implementation time. Trigger remains `main`. |
| Docs | Root and website READMEs match `main`, `https://sp1ke.dev`, existing `CNAME` / `site` / `base`, and `mise run` tasks. No instructions to source `dev.sh` or to open a missing DevContainer. |
| Forma privacy policy | `https://sp1ke.dev/forma` is a public HTML page, specific to Forma, disclosing on-device collection, use, sharing parties (none, unless the user exports or shares a file), and the permissions above. `~/Documents/github/forma` links to that URL from inside the app. |
| Existing policies | MineSweeper, AquaPact, and Teditox pages are app-specific HTML disclosures. MineSweeper no longer claims collection this repo cannot verify. AquaPact no longer has the "New Feature" filler. Teditox states the release manifest does not request `INTERNET`. |

## Status

Track progress with task lists: `[ ]` not started, `[x]` done. Update this table and the matching checkboxes as work lands.

| Phase | Scope | Status |
|---|---|---|
| P1 | Dependabot watches `website/` npm | completed |
| P2 | Astro 7 lockfile, Node pin, devDependencies | completed |
| P3 | CI npm cache path and Actions tags | completed |
| P4 | README drift (`main`, mise, `sp1ke.dev`) | completed |
| P5 | Forma Play privacy policy | not started |
| P6 | Fix hosted MineSweeper, AquaPact, and Teditox policies | not started |

## Phases

### P1. Point Dependabot at the website npm lockfile

**Status: completed.** `.github/dependabot.yml` now schedules weekly npm updates for `/website`. The unused `devcontainers` entry is gone. This does not change the installed tree.

**Steps.**

- [x] In `.github/dependabot.yml`, remove the `package-ecosystem: devcontainers` entry at `directory: "/"`.
- [x] Add `package-ecosystem: npm`, `directory: "/website"`, `schedule.interval: weekly`.
- [x] Confirm the file does not reference `.devcontainer` and that no `.devcontainer` directory is created in this phase.
- [x] Verify `website/package.json` and `website/package-lock.json` remain the only npm manifests Dependabot is pointed at.

**Done when:** `.github/dependabot.yml` lists weekly npm updates for `/website` and does not list `devcontainers`.

### P2. Upgrade Astro off locked 5.16.5

**Status: completed.** Registry re-check still showed `astro@7.4.13` (`engines.node >=22.23.4`) and `@astrojs/check@0.9.12` (peer `typescript@^5 || ^6`). The lockfile now has `astro@7.4.13`, `@astrojs/check@0.9.12`, and `typescript@5.9.3`. Node is pinned to `22.23.5`. `npm audit fix --force` was not used. `mise.toml` sets `NODE_ENV=production`, so the install task is `npm install --include=dev`; otherwise the checker is omitted and `astro check` cannot run.

**Steps.**

- [x] Re-check `npm view astro version`, `npm view astro engines`, and `npm view @astrojs/check peerDependencies` before editing. Pick the latest `astro` release that is `>=7.4.7`.
- [x] Do not run `npm audit fix --force`. When this roadmap was written it proposed `astro@7.4.1`, still inside `<=7.4.6`.
- [x] In `website/package.json`, set `astro` to that 7.x release and move `astro`, `@astrojs/check`, and `typescript` so the checker and TypeScript are `devDependencies`.
- [x] Set `@astrojs/check` to a release whose peer range matches the chosen Astro line. Keep `typescript` inside that peer range (do not set `typescript@7` against `@astrojs/check@0.9.x`).
- [x] Add `engines.node` in `website/package.json` to the minimum declared by the chosen Astro release (`>=22.23.4` for `astro@7.4.13` at writing).
- [x] Set `mise.toml` `[tools] node` and `.github/workflows/deploy.yml` `node-version` to a Node 22 version that satisfies that `engines` field, not the floating major `"22"` / `'22'`.
- [x] From `website/`, refresh `website/package-lock.json` with `npm install` so the locked `astro` version matches the manifest.
- [x] Verify `npm run build` in `website/` (`astro check && astro build`) succeeds, and `npm ls astro` shows a version `>=7.4.7`.

**Done when:** `website/package-lock.json` locks `astro` at `>=7.4.7`, Node is pinned to a release that satisfies that Astro `engines` field in mise, CI, and `package.json`, and `npm run build` in `website/` completes.

### P3. Fix the npm cache path and bump Actions

**Status: completed.** Re-checked tags were still `actions/checkout@v7.0.1`, `actions/setup-node@v7.1.0`, `actions/upload-pages-artifact@v5.0.0`, and `actions/deploy-pages@v5.0.1`. The workflow caches `website/package-lock.json` and still triggers on `main`.

**Steps.**

- [x] In `.github/workflows/deploy.yml`, change `cache-dependency-path` from `website/package.json` to `website/package-lock.json`.
- [x] Re-check the latest release tags for `actions/checkout`, `actions/setup-node`, `actions/upload-pages-artifact`, and `actions/deploy-pages` (at writing: `v7.0.1`, `v7.1.0`, `v5.0.0`, `v5.0.1`).
- [x] Bump those four `uses:` pins in `.github/workflows/deploy.yml` to the re-checked tags. Leave `on.push.branches` as `[main]`.
- [x] Verify the workflow file no longer contains `cache-dependency-path: website/package.json` or the old pins `actions/checkout@v4`, `actions/setup-node@v4`, `actions/upload-pages-artifact@v3`, and `actions/deploy-pages@v4`.

**Done when:** `deploy.yml` caches `website/package-lock.json`, pins the four Actions at the re-checked latest tags, and still deploys on push to `main`.

### P4. Align READMEs with mise, `main`, and `sp1ke.dev`

**Status: completed.** The three READMEs now describe deploy on `main`, `https://sp1ke.dev`, and the `mise.toml` tasks. Node is documented as `22.23.5`. Privacy pages remain P5 and P6.

**Steps.**

- [x] In `README.md`, replace live-site and PDF links that use `https://zp1ke.github.io/cv/` with `https://sp1ke.dev/` and `/resume-en.pdf` / `/resume-es.pdf`, matching `website/public/CNAME` and `base: '/'`.
- [x] In `README.md` and `website/README.md`, change deploy instructions that say `master` so they say `main`, matching `.github/workflows/deploy.yml`.
- [x] Remove the DevContainer section from `README.md` (no `.devcontainer` exists). Point local setup at `mise.toml` tasks (`mise run dev-web`, `mise run build-web`, `mise run deploy`) instead of `source dev.sh`.
- [x] Rewrite `README-DEV.md` so it no longer tells the reader to `source dev.sh`, allow direnv, or run `cv-*` commands. Document the tasks already defined in `mise.toml`. Replace the Node.js 18+ prerequisite with the Node pin from P2.
- [x] In `README.md` Custom Domain Setup, stop describing creation of `website/public/CNAME` and edits to `site` / `base` as unfinished work. Those files already set `sp1ke.dev` and `base: '/'`.
- [x] In `website/README.md`, replace the subdomain example value `zp1ke.github.io` so it is not presented as this repo's current Pages host.
- [x] Verify `rg` over `README.md`, `README-DEV.md`, and `website/README.md` no longer finds `source dev.sh`, `Node.js 18+`, `DevContainer`, `push to \`master\``, or `https://zp1ke.github.io/cv/` as current instructions.

**Done when:** those three docs describe deploy on `main`, the live host `https://sp1ke.dev`, and mise tasks, and do not instruct the reader to source `dev.sh` or use a DevContainer.

### P5. Host a Forma privacy policy and link it from the app

**Status: not started.** Play requires a privacy-policy URL on the store listing and inside the app before publish, including for apps that do not transmit data. Forma (`com.sp1ke.forma`) has neither. This site already hosts the other apps' policies as HTML on `https://sp1ke.dev`, which meets the hosting rules (public HTTPS page, no login, not a PDF) once deployed. Comes after the site still builds, and does not depend on the Astro major bump.

**Steps.**

- [ ] Add `website/src/pages/forma.astro` using `PrivacyLayout`, with `appName="Forma"`, so the route is `/forma` and the Play URL is `https://sp1ke.dev/forma`.
- [ ] Write the page as HTML in that file, not a PDF or download. State that it applies to Forma only.
- [ ] Disclose only practices present in `~/Documents/github/forma`: on-device profiles, routines, session logs, and body measurements/notes; `sqflite` and `shared_preferences`; user-picked `forma-export.zip`; no developer account and no transmission to the developer; release manifest permissions `RECEIVE_BOOT_COMPLETED` and `SCHEDULE_EXACT_ALARM`; notification and exact-alarm permission requested in `lib/data/services/android_alert_notifier.dart`; `INTERNET` only in debug and profile manifests.
- [ ] Name sharing parties: the developer does not share data with third parties; the user can copy or share the export file themselves.
- [ ] Include a last-updated date and a contact method. Do not replace `miche.atucha@gmail.com` with `matt@sp1ke.dev` unless the user asks; the existing policies use the Gmail address.
- [ ] Add an English section and a Spanish section on the same URL. Forma ships `lib/l10n/app_en.arb` and `lib/l10n/app_es.arb`, and Play stores one privacy-policy URL.
- [ ] In `~/Documents/github/forma`, add an in-app control that opens `https://sp1ke.dev/forma`. There is no privacy URL in `lib/` today.
- [ ] Verify `website/src/pages/forma.astro` exists, the Forma app source references `https://sp1ke.dev/forma`, and the page text does not claim analytics, accounts, or ads.

**Done when:** `https://sp1ke.dev/forma` is the HTML policy for Forma, the Forma app links to it, and the page matches the on-device data and permissions in that repo. Pasting the URL into Play Console is not part of this phase.

### P6. Correct the hosted MineSweeper, AquaPact, and Teditox policies

**Status: not started.** The same Play rules apply to the policies already on this site. AquaPact and Teditox are close. MineSweeper is a generic template and must not stay that way. Do this after P5 so the Forma page is the pattern.

**Steps.**

- [ ] In `website/src/pages/minesweeper.astro`, remove unverified template claims: Account, Affiliate, first and last name, Usage Data, IP address, device identifiers, Google login, and sharing with other users. Do not replace them with a "collects nothing" claim unless the `com.h4j4x.minesweeper` app is checked. Its source is not in this repo or `~/Documents/github`.
- [ ] If MineSweeper source cannot be inspected, stop that page at a factual gap note in this roadmap and do not publish invented collection or non-collection language.
- [ ] In `website/src/pages/aquapact.astro`, delete the "New Feature: Future updates may include additional features" bullet. State that `https://sp1ke.dev/aquapact` is the policy, not only a copy posted inside the app. Keep the local hydration, notification-time, and no-third-party statements already there.
- [ ] In `website/src/pages/teditox.astro`, state that the release `android/app/src/main/AndroidManifest.xml` in `~/Documents/github/teditox` requests no `INTERNET` permission (`INTERNET` is only in the debug and profile manifests), and that files leave the device only if the user shares them.
- [ ] In `~/Documents/github/teditox/lib/src/features/settings/presentation/about_screen.dart`, remove the "Privacy Policy link (placeholder)" comment. The tap already opens `https://sp1ke.dev/teditox`.
- [ ] Add a Spanish section to the AquaPact and Teditox pages on the same URL. Teditox already has Spanish strings for the privacy-policy link. Leave MineSweeper English-only until its behavior is verified.
- [ ] Verify the three pages are still HTML routes under `website/src/pages/`, still use `PrivacyLayout`, and `minesweeper.astro` no longer contains "Third-party Social Media" or "First name and last name".

**Done when:** AquaPact and Teditox policies match the practices named above, Teditox's in-app link is no longer marked a placeholder, and MineSweeper no longer asserts unverified collection. Play Console edits for those listings are not part of this phase.

## Risks

- Astro 5 to 7 can break `website/src` pages or `astro check` even though `output: 'static'` avoids shipping SSR and the image endpoint. Mitigation: P2 is not done until `npm run build` in `website/` succeeds; do not bump Actions in the same untested edit.
- `npm audit fix --force` installs a still-vulnerable Astro. Mitigation: P2 forbids that command and requires locked `astro >=7.4.7`.
- Floating `node = "22"` can resolve below Astro 7's `engines.node`. Mitigation: pin an explicit 22.x in mise, CI, and `engines` together.
- Actions major bumps move onto a newer runner Node and can fail independently of the site build. Mitigation: re-check tags in P3 and keep the workflow trigger on `main`.
- `@astrojs/check@0.9.12` does not peer TypeScript 7. Mitigation: do not set `typescript@7` in P2 unless a newer check release declares that peer.
- A privacy page that invents collection, or that claims "no collection" without checking the app, can fail Play review or mislead users. Mitigation: P5 copies only Forma source facts; P6 does not rewrite MineSweeper into a no-collection policy without that app's source.
- Forma body measurements and workout logs are health-related even though they stay on device. Omitting them would not meet Play's "comprehensively discloses" rule. Mitigation: P5 names those fields and states they are not sent to the developer.
- This roadmap is not a legal opinion. Google's article says to consult a legal representative. Mitigation: the pages disclose observed behavior; they do not claim GDPR, COPPA, or Families compliance beyond what the code shows.

## Success criteria

- [x] `website/package-lock.json` locks `astro` at `>=7.4.7`, and `npm run build` in `website/` succeeds.
- [x] `mise.toml`, `.github/workflows/deploy.yml`, and `website/package.json` `engines` agree on a Node 22 release that satisfies that Astro `engines` field.
- [x] `.github/dependabot.yml` schedules weekly npm updates for `/website` and does not list `devcontainers`.
- [x] `.github/workflows/deploy.yml` caches `website/package-lock.json` and no longer pins `actions/checkout@v4`, `actions/setup-node@v4`, `actions/upload-pages-artifact@v3`, or `actions/deploy-pages@v4`.
- [x] `README.md`, `README-DEV.md`, and `website/README.md` match `main`, mise, and `https://sp1ke.dev`, with no `dev.sh` or DevContainer setup steps.
- [ ] `website/src/pages/forma.astro` exists, Forma links to `https://sp1ke.dev/forma`, and the page discloses on-device data, export, and the release permissions without claiming analytics or accounts.
- [ ] `minesweeper.astro` no longer asserts unverified name, usage-data, IP, or Google-login collection. `aquapact.astro` has no "New Feature" filler. `teditox.astro` states that the release manifest does not request `INTERNET`.

## Explicitly not in scope

- Caching or replacing the `apt-get install` of `texlive-xetex`, `texlive-fonts-extra`, and `texlive-latex-extra` in `.github/workflows/deploy.yml`. That install is slow, but this roadmap does not pick a TeX Live action.
- Regenerating LinkedIn or InfoJobs output, or editing `data/cv-en.json` / `data/cv-es.json`. Content sync is unchanged.
- Deduplicating `website/src/pages/index.astro` and `website/src/pages/es/index.astro`.
- Adding a `.devcontainer`. The README claim is removed in P4 rather than implemented.
- Committing `website/dist`, `latex/output`, or other generated artifacts. `.gitignore` already ignores `dist/` and `*.pdf`.
- Submitting Play Console declarations. The account holder pastes `https://sp1ke.dev/forma` under Monitor and improve → Policy and programs → App content → Privacy Policy. Data safety, ads, target audience, and content rating are separate forms and are not filled here.
- Changing the contact address on the existing policies from `miche.atucha@gmail.com` to `matt@sp1ke.dev` or `michel@sp1ke.dev`. Those CV addresses are different strings; this roadmap does not pick a new one.
- Adding a privacy-policy link inside AquaPact or MineSweeper. Those app trees are not in `~/Documents/github`. Teditox already links to its page; Forma is linked in P5.
