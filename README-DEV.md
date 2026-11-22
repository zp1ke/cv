# Development Setup Guide

Local tasks are defined in `mise.toml`. Run them from the repository root with `mise run`. There is no `dev.sh` and no direnv setup.

## Prerequisites

- **XeLaTeX** (`xelatex` on `PATH`) for PDF generation
- **Node.js 22.23.5** for the website. `mise.toml` pins this release. Astro requires `>=22.23.4`.
- **npm**, installed with that Node release
- **Python 3.14**, pinned in `mise.toml`, for the LinkedIn and InfoJobs generators
- [mise](https://mise.jdx.dev/) to install those tool versions and run the tasks

## Tasks

`mise run help` prints the same list.

### PDF generation

- `mise run build-en` — English resume PDF
- `mise run build-es` — Spanish resume PDF
- `mise run build-all` — both PDFs

### Website

- `mise run dev-web` — development server at http://localhost:4321
- `mise run build-web` — production build (`astro check && astro build`)
- `mise run preview-web` — preview the production build locally
- `mise run install` — `npm install --include=dev` in `website/`

`mise.toml` sets `NODE_ENV=production`. The install task passes `--include=dev` so `@astrojs/check` and TypeScript are still installed.

### Generators and full build

- `mise run generate-linkedin` — both English and Spanish LinkedIn files
- `mise run generate-infojobs` — Spanish InfoJobs profile only
- `mise run copy-pdfs` — copy `latex/output/resume-en.pdf` and `resume-es.pdf` into `website/dist/`
- `mise run deploy` — PDFs, website, copy PDFs, LinkedIn, and InfoJobs
- `mise run clean` — remove LaTeX and website build artifacts
- `mise run build -- <output> <lang>` — dispatcher for `latex`, `linkedin`, `infojobs`, or `website`, with `en` or `es`

InfoJobs is Spanish only. LinkedIn and the website build always produce both languages.

## Common workflows

### Content update

1. Update `data/cv-en.json` and/or `data/cv-es.json`.
2. Mirror the change in `latex/resume/en/` and/or `latex/resume/es/`.
3. `mise run generate-linkedin`
4. `mise run generate-infojobs`
5. `mise run build-all`, then `mise run build-web`

### Website only

```bash
mise run dev-web
```

### PDFs, then the site

```bash
mise run build-all
mise run dev-web
```

### Full local build

```bash
mise run deploy
mise run preview-web
```

### Clean start

```bash
mise run clean
mise run install
mise run deploy
```

## Troubleshooting

### `mise: command not found`

Install mise, then run the task again from the repository root. Do not source a project shell script; there is not one.

### PDF build fails

Check `xelatex --version`. LaTeX errors are printed by `latex/scripts/build-resume.sh`.

### Website will not start

`mise run install`, then `mise run dev-web`. `node --version` should be `v22.23.5` when mise is active. To reset the website tree: `rm -rf website/node_modules website/dist`.

### PDFs missing from the site

`mise run copy-pdfs` after the PDFs exist, or `mise run deploy` for the full pipeline. The copy step needs `website/dist/`.

## CI

`.github/workflows/deploy.yml` builds both PDFs and the website on push to `main`, then deploys `website/dist` to GitHub Pages. It does not run the LinkedIn or InfoJobs generators.
