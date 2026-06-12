# AGENTS.md

## Purpose
This file guides coding agents working in this repository so updates stay consistent across:
- LaTeX CV PDFs (English and Spanish)
- Astro website (English and Spanish)
- InfoJobs text export

## Project Outputs
1. PDF resumes generated from LaTeX:
- `latex/output/resume-en.pdf`
- `latex/output/resume-es.pdf`

2. Website generated with Astro from JSON data:
- English route: `/`
- Spanish route: `/es/`

3. InfoJobs profile source:
- `infojobs/es/profile.md`

## Core Rule: Keep Content In Sync
The canonical source of CV content is:
- `data/cv-en.json`
- `data/cv-es.json`

When updating CV content, start in JSON and propagate changes to all relevant counterparts in the same change:
- LaTeX: `latex/resume/en/*.tex` and/or `latex/resume/es/*.tex`
- LinkedIn pack: regenerate via `python3 scripts/generate-linkedin.py`
- InfoJobs text: `infojobs/es/profile.md` (generated from `data/cv-es.json`)

Do not update only one format unless explicitly requested.

## Repository Map
- Root LaTeX entrypoint: `latex/resume.tex`
- Custom class: `latex/document-format.cls`
- Fonts and icon package: `latex/fonts/`, `latex/fontawesome.sty`
- LaTeX content modules:
  - `latex/resume/en/` and `latex/resume/es/`
  - `profile.tex`, `summary.tex`, `skills.tex`, `experience.tex`, `education.tex`, `opensource.tex`, plus optional topic sections
- Build scripts:
  - Linux/macOS: `latex/scripts/build-resume.sh`
  - Windows: `latex/scripts/build-resume.cmd`
- Website app: `website/`
  - Content source (shared): `data/cv-en.json`, `data/cv-es.json`
  - Pages: `website/src/pages/index.astro`, `website/src/pages/es/index.astro`
  - Shared components/layouts: `website/src/components/`, `website/src/layouts/`
- CI deployment workflow: `.github/workflows/deploy.yml`

## Build and Validation Commands
Run from repository root unless noted.

### Build PDF resumes
- English: `sh ./latex/scripts/build-resume.sh en`
- Spanish: `sh ./latex/scripts/build-resume.sh es`

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
- Preserve macro usage from `latex/document-format.cls`.
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
1. Update `data/cv-en.json` and `data/cv-es.json` experience sections first.
2. Mirror those changes in `latex/resume/en/experience.tex` and `latex/resume/es/experience.tex`.
3. Regenerate LinkedIn files: `python3 scripts/generate-linkedin.py`.
4. Regenerate InfoJobs output: `python3 scripts/generate-infojobs.py`.
5. Build/validate PDFs and website.

### Update skills
1. Edit matching skills sections in `data/cv-en.json` and `data/cv-es.json` first.
2. Mirror changes in `latex/resume/en/skills.tex` and `latex/resume/es/skills.tex`.
3. Regenerate LinkedIn files: `python3 scripts/generate-linkedin.py`.
4. Keep category naming and ordering coherent.

### Update profile/contact
1. Edit profile sections in `data/cv-en.json` and `data/cv-es.json` first.
2. Mirror changes in `latex/resume/en/profile.tex` and `latex/resume/es/profile.tex`.
3. Regenerate LinkedIn files: `python3 scripts/generate-linkedin.py`.
4. Regenerate InfoJobs output: `python3 scripts/generate-infojobs.py`.
5. Ensure links/usernames match across all outputs.

## Safety and Scope Rules for Agents
- Do not commit generated PDFs or temporary build artifacts.
- Do not remove unrelated user changes.
- Prefer minimal, surgical edits.
- Keep existing formatting and conventions unless asked to refactor.
- If a task is content-only, avoid unrelated visual or structural changes.

## Recommended Verification Before Finishing
- CV content changed:
  - Confirm source-of-truth JSON was updated first (`data/cv-en.json`, `data/cv-es.json`).
  - Confirm all required counterparts were updated (LaTeX + LinkedIn + InfoJobs as applicable).
  - Regenerate LinkedIn pack (`python3 scripts/generate-linkedin.py`) and review diff.
  - Regenerate InfoJobs pack (`python3 scripts/generate-infojobs.py`) and review diff.
  - Build at least the affected PDF language(s).
  - Build website (`npm run build` inside `website/`).
- Website-only style/layout changed:
  - Run website build.
  - Verify both `/` and `/es/` pages still render correctly.

## PR Review and Pre-Push Checklist
### PR review checklist
1. Scope is focused and includes only files relevant to the stated CV/site change.
2. Source-of-truth JSON changes are mirrored in LaTeX, LinkedIn, and InfoJobs when applicable.
3. English and Spanish structure remain aligned (ordering, dates, section presence).
4. Diff quality is clean (no accidental reformatting or unrelated edits).

### Pre-push validation checklist
1. Regenerate LinkedIn content: `python3 scripts/generate-linkedin.py`.
2. Regenerate InfoJobs content: `python3 scripts/generate-infojobs.py`.
3. Build affected PDF language(s): `sh ./latex/scripts/build-resume.sh en|es`.
4. Build website in `website/`: `npm run build`.
5. Spot-check routes `/` and `/es/` for rendering regressions.
6. Confirm no generated artifacts are staged for commit.

## Notes for Future Agents
- This project intentionally uses JSON in `data/` as source of truth, with LaTeX/LinkedIn/InfoJobs as derived counterparts.
- Always check whether the requested change should be mirrored in the other language.
- Prefer atomic commits/messages grouped by one logical CV update.
