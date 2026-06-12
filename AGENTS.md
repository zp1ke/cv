# AGENTS.md

## Purpose
This file guides coding agents working in this repository so updates stay consistent across:
- LaTeX CV PDFs (English and Spanish)
- Astro website (English and Spanish)
- InfoJobs text export

## Project Outputs
1. PDF resumes generated from LaTeX:
- `resume-en.pdf`
- `resume-es.pdf`

2. Website generated with Astro from JSON data:
- English route: `/`
- Spanish route: `/es/`

3. InfoJobs profile source:
- `resume/infojobs.md`

## Core Rule: Keep Content In Sync
When updating CV content, update all relevant representations in the same change:
- LaTeX: `resume/en/*.tex` and/or `resume/es/*.tex`
- Website JSON: `website/src/data/cv-en.json` and/or `website/src/data/cv-es.json`
- InfoJobs text: `resume/infojobs.md` (especially for Spanish-facing profile text)

Do not update only one format unless explicitly requested.

## Repository Map
- Root LaTeX entrypoint: `resume.tex`
- Custom class: `document-format.cls`
- Fonts and icon package: `fonts/`, `fontawesome.sty`
- LaTeX content modules:
  - `resume/en/` and `resume/es/`
  - `profile.tex`, `summary.tex`, `skills.tex`, `experience.tex`, `education.tex`, `opensource.tex`, plus optional topic sections
- Build scripts:
  - Linux/macOS: `scripts/build-resume.sh`
  - Windows: `scripts/build-resume.cmd`
- Website app: `website/`
  - Content: `website/src/data/cv-en.json`, `website/src/data/cv-es.json`
  - Pages: `website/src/pages/index.astro`, `website/src/pages/es/index.astro`
  - Shared components/layouts: `website/src/components/`, `website/src/layouts/`
- CI deployment workflow: `.github/workflows/deploy.yml`

## Build and Validation Commands
Run from repository root unless noted.

### Build PDF resumes
- English: `sh ./scripts/build-resume.sh en`
- Spanish: `sh ./scripts/build-resume.sh es`

### Website commands (must run inside `website/`)
- Install deps: `npm install`
- Dev server: `npm run dev`
- Production build: `npm run build`

Important: Node/npm commands belong in `website/`.

## Editing Patterns

## Preferred Agent Tools and Workflow
- Use fast search tools first:
  - File discovery: `rg --files`
  - Text search: `rg "pattern"`
- Prefer minimal patch-style edits to avoid accidental formatting drift.
- Read before writing when touching multiple related files.
- For CV content tasks, plan updates as a synchronized batch across all required formats.
- Validate the changed surface area only (targeted PDF builds and website build).
- Avoid broad refactors unless explicitly requested.

### LaTeX updates
- Keep section ordering and structure consistent across languages.
- Preserve macro usage from `document-format.cls`.
- Keep entries reverse-chronological for experience and education.
- Prefer concise, achievement-focused bullets.

### JSON updates
- Maintain schema consistency between `cv-en.json` and `cv-es.json`.
- Keep key names and section structures aligned between languages.
- Ensure valid JSON (no trailing commas, proper quoting).

### Content style
- Professional, concise language.
- Keep technical terms in English when appropriate, including in Spanish content.
- Align role dates and company names exactly across all formats.

## Common Task Playbooks

### Add or edit work experience
1. Update `resume/en/experience.tex` and `resume/es/experience.tex`.
2. Update `website/src/data/cv-en.json` and `website/src/data/cv-es.json` experience sections.
3. Update `resume/infojobs.md` if the change affects profile-facing Spanish content.
4. Build/validate PDFs and website.

### Update skills
1. Edit `resume/en/skills.tex` and `resume/es/skills.tex`.
2. Edit matching skills sections in both JSON files.
3. Keep category naming and ordering coherent.

### Update profile/contact
1. Edit both language `profile.tex` files.
2. Edit profile sections in both JSON files.
3. Ensure links/usernames match across all outputs.

## Safety and Scope Rules for Agents
- Do not commit generated PDFs or temporary build artifacts.
- Do not remove unrelated user changes.
- Prefer minimal, surgical edits.
- Keep existing formatting and conventions unless asked to refactor.
- If a task is content-only, avoid unrelated visual or structural changes.

## Recommended Verification Before Finishing
- CV content changed:
  - Confirm all required formats were updated (LaTeX + JSON + InfoJobs as applicable).
  - Build at least the affected PDF language(s).
  - Build website (`npm run build` inside `website/`).
- Website-only style/layout changed:
  - Run website build.
  - Verify both `/` and `/es/` pages still render correctly.

## PR Review and Pre-Push Checklist
### PR review checklist
1. Scope is focused and includes only files relevant to the stated CV/site change.
2. Content parity is preserved across LaTeX, JSON, and InfoJobs when applicable.
3. English and Spanish structure remain aligned (ordering, dates, section presence).
4. Diff quality is clean (no accidental reformatting or unrelated edits).

### Pre-push validation checklist
1. Build affected PDF language(s): `sh ./scripts/build-resume.sh en|es`.
2. Build website in `website/`: `npm run build`.
3. Spot-check routes `/` and `/es/` for rendering regressions.
4. Confirm no generated artifacts are staged for commit.

## Notes for Future Agents
- This project has dual sources for the same CV content (LaTeX and JSON). Drift is the most common failure mode.
- Always check whether the requested change should be mirrored in the other language.
- Prefer atomic commits/messages grouped by one logical CV update.
