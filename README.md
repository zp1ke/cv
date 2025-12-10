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
.\scripts\build-resume.cmd [LANGUAGE_CODE]
```

**Linux and MacOS:**
```bash
sh ./scripts/build-resume.sh [LANGUAGE_CODE]
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
- `resume.tex` - Main LaTeX document
- `document-format.cls` - Custom document class
- `resume/en/` - English content files
- `resume/es/` - Spanish content files
- `scripts/` - Build scripts

### Website
- `website/` - Astro static site
  - `src/data/` - CV content in JSON format
  - `src/components/` - Reusable components
  - `src/pages/` - Routes (bilingual)
  - `public/` - Static assets

### Documentation
- `.github/copilot-instructions.md` - Comprehensive project guide
- `website/README.md` - Website-specific documentation

## Updating Content

**Important**: This project maintains content in TWO formats:
- **LaTeX** (.tex files) for PDF generation
- **JSON** (in `website/src/data/`) for web display

When updating your CV, you must update BOTH formats to keep them in sync.

**Workflow:**
```bash
# 1. Update LaTeX content
vim resume/en/experience.tex

# 2. Update corresponding JSON
vim website/src/data/cv-en.json

# 3. Commit both together
git add resume/en/experience.tex website/src/data/cv-en.json
git commit -m "Add new work experience"

# 4. Push to trigger automatic deployment
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
1. Update both LaTeX and JSON content files
2. Maintain consistency across both language versions (English/Spanish)
3. Use reverse chronological order for experience/education
4. Test both PDF compilation and website build before committing
5. Follow the coding standards in `.github/copilot-instructions.md`
