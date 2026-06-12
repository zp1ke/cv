# LinkedIn Content Pack

This folder contains copy-paste content for LinkedIn profile sections.

## Canonical Source
Use shared repository JSON as source of truth:
- `data/cv-en.json`
- `data/cv-es.json`

These LinkedIn files should be updated whenever those JSON files change.

## Folder Layout
- `linkedin/en/` English LinkedIn content
- `linkedin/es/` Spanish LinkedIn content

## Suggested Update Workflow
1. Update CV content in JSON files.
2. Regenerate LinkedIn files: `python3 scripts/generate-linkedin.py`.
3. If CV PDF content is intended to match web content, sync LaTeX files too.
4. Review diffs to ensure dates, company names, and achievements are consistent.

## Limits
The generator applies practical LinkedIn-oriented limits:
- Headline: 220 chars
- About: 2600 chars
- Experience bullets: max 4 per role, trimmed for readability

Length report is generated in `linkedin/LIMITS.md`.

## LinkedIn Sections Covered
- Headline
- About
- Experience
- Education
- Skills
- Projects/Featured
