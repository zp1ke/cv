# Resume

Professional CV/Resume with dual outputs:
- **📄 PDF**: LaTeX-generated professional resumes in English and Spanish
- **🌐 Website**: Modern portfolio hosted on [GitHub Pages](https://zp1ke.github.io/cv/)

Both formats are automatically built and deployed via GitHub Actions on every push to main.

## Quick Links

- 🌍 **Live Website**: https://zp1ke.github.io/cv/
- 📥 **Download PDF**: [English](https://zp1ke.github.io/cv/resume-en.pdf) | [Español](https://zp1ke.github.io/cv/resume-es.pdf)

## Development Environment

This project includes a DevContainer configuration for easy setup with VS Code:
- Pre-configured with LaTeX (TeXLive full scheme) and Node.js
- LaTeX Workshop extension
- No manual installation required

## Prerequisites

### For PDF Generation
- **xelatex** command available on system path

**Windows:**
Download from [MiKTeX](https://miktex.org/download)

**Linux:**
```bash
sudo apt install texlive-xetex texlive-fonts-recommended texlive-fonts-extra
```

**MacOS:**
Download from [MacTeX](https://www.tug.org/mactex/mactex-download.html)

### For Website Development
- **Node.js** 18+ and npm
- Download from [nodejs.org](https://nodejs.org/)

## Build

### Build PDFs Locally

**Windows:**
```cmd
.\latex\scripts\build-resume.cmd [LANGUAGE_CODE]
```

**Linux and MacOS:**
```bash
sh ./latex/scripts/build-resume.sh [LANGUAGE_CODE]
```

Supported language codes: `en`, `es`

### Build Website Locally

```bash
cd website
npm install        # First time only
npm run dev        # Development server at http://localhost:4321
npm run build      # Production build
```

### Automatic Deployment

Push to `master` branch to trigger automatic build and deployment:
1. ✅ Both PDFs are compiled
2. ✅ Website is built with Astro
3. ✅ Everything deployed to GitHub Pages

## Project Structure

### LaTeX CV
- `latex/resume.tex` - Main LaTeX document
- `latex/document-format.cls` - Custom document class
- `latex/resume/en/` - English content files
- `latex/resume/es/` - Spanish content files
- `latex/scripts/` - Build scripts
- `latex/output/` - Generated PDF output files

### Website
- `website/` - Astro static site
  - Uses shared content from `data/`
  - `src/components/` - Reusable components
  - `src/pages/` - Routes (bilingual)
  - `public/` - Static assets

### Documentation
- `.github/copilot-instructions.md` - Comprehensive project guide
- `website/README.md` - Website-specific documentation

## Updating Content

**Important**: The canonical source of CV content is JSON in `data/`:
- `data/cv-en.json`
- `data/cv-es.json`

When updating your CV, change JSON first, then propagate to all relevant counterparts:
- **LaTeX** (`latex/resume/en/*.tex`, `latex/resume/es/*.tex`) for PDF output
- **LinkedIn pack** (`linkedin/`) via generator script
- **InfoJobs pack** (`infojobs/es/profile.md`) via generator script

**Workflow:**
```bash
# 1. Update canonical JSON content
vim data/cv-en.json data/cv-es.json

# 2. Mirror changes in LaTeX counterparts
vim latex/resume/en/experience.tex latex/resume/es/experience.tex

# 3. Regenerate LinkedIn files
python3 scripts/generate-linkedin.py

# 4. Regenerate InfoJobs files
python3 scripts/generate-infojobs.py

# 5. Commit all related changes together
git add data/ latex/resume/ linkedin/ infojobs/
git commit -m "Sync CV content across outputs"

# 6. Push to trigger automatic deployment
git push
```

## Custom Domain Setup

To use your own domain instead of `zp1ke.github.io/cv`:

1. Create `website/public/CNAME` with your domain
2. Update `website/astro.config.mjs` (change `site` and `base`)
3. Configure DNS records at your domain provider
4. Enable custom domain in GitHub Pages settings

See `website/README.md` for detailed instructions.

## Libraries & Credits

- [FontAwesome 4.x](https://fontawesome.com/v4/icons/) - Icon font
- [Astro](https://astro.build/) - Static site generator
- Custom LaTeX document class based on Awesome CV

## Contributing

When updating the CV:
1. Update `data/cv-en.json` and `data/cv-es.json` first
2. Mirror changes to LaTeX and regenerate LinkedIn content
3. Update InfoJobs when relevant
4. Keep all outputs aligned in the same commit
5. Maintain consistency across both language versions (English/Spanish)
6. Use reverse chronological order for experience/education
7. Test both PDF compilation and website build before committing
8. Follow the coding standards in `.github/copilot-instructions.md`
