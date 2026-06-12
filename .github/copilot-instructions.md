# GitHub Copilot Instructions for CV Project

## Project Overview
This is a personal CV/Resume project with dual outputs:
1. **PDF Resumes**: Professional LaTeX-generated PDFs in English and Spanish using XeLaTeX compiler
2. **Web Portfolio**: Modern Astro-based static website deployed to GitHub Pages with PDF download links

Both outputs are automatically built and deployed via GitHub Actions on every push to main.

## Project Structure

### LaTeX CV (PDF Generation)
- `latex/resume.tex` - Main LaTeX document template
- `latex/document-format.cls` - Custom document class defining CV structure and styling
- `latex/fontawesome.sty` - FontAwesome icon package for social media icons
- `latex/fonts/` - Custom fonts directory (Roboto family)
- `latex/resume/en/` - English version content files
- `latex/resume/es/` - Spanish version content files
- `latex/scripts/` - Build scripts for different platforms
- `latex/build/` - Temporary build directory (ignored by git)
- Generated PDFs: `latex/output/resume-en.pdf`, `latex/output/resume-es.pdf`

### Astro Website
- `website/` - Astro static site project
   - Uses shared CV content from repository root `data/`
  - `src/components/` - Reusable Astro components
  - `src/layouts/` - Page layouts
  - `src/pages/` - Routes (index.astro for English, es/index.astro for Spanish)
  - `public/` - Static assets (favicon, PDFs copied during build)
  - `astro.config.mjs` - Astro configuration
  - `package.json` - Node.js dependencies

### CI/CD
- `.github/workflows/deploy.yml` - GitHub Actions workflow for building and deploying both PDFs and website

### InfoJobs Conversion
- `infojobs/es/profile.md` - Generated Spanish CV content formatted for InfoJobs profile updates.

## Content Files

### LaTeX Content (per language)
Each language directory (`latex/resume/en/`, `latex/resume/es/`) contains modular content files:
1. `profile.tex` - Personal information, contact details, social links
2. `summary.tex` - Professional summary/objective
3. `skills.tex` - Technical skills, languages, and competencies
4. `experience.tex` - Work experience entries
5. `education.tex` - Educational background
6. `opensource.tex` - Open source contributions and projects

### Website Content
Canonical CV content is maintained in JSON format:
- `data/cv-en.json` - English version
- `data/cv-es.json` - Spanish version

**IMPORTANT**: `data/` JSON is the source of truth. When content changes, propagate to LaTeX, LinkedIn, and InfoJobs (when applicable).

## Key Technologies
- **LaTeX**: Document preparation system
- **XeLaTeX**: Extended TeX compiler with Unicode and font support
- **FontAwesome**: Icon font for social media and visual elements
- **Roboto**: Primary font family

## Coding Standards

### LaTeX Code Style
- Use consistent indentation (2 spaces)
- Add section comments with `%-------------------------------------------------------------------------------`
- Group related content with blank lines
- Use semantic macro names from `latex/document-format.cls`
- Keep lines under 100 characters when possible

### Content Organization
- Maintain consistent structure across language versions (en/es)
- Order sections logically: profile → summary → skills → experience → education → opensource
- Use reverse chronological order for experience and education
- Include dates in format: `Mon. YYYY` or `Mon. YYYY - Mon. YYYY`

### Macros and Commands
Common macros used in this project:
- `\name{First}{Last}` - Set name
- `\position{Title}` - Set position/title
- `\mobile{number}`, `\email{address}` - Contact info
- `\github{username}`, `\linkedin{username}` - Social links
- `\cvsection{Title}` - Start new section
- `\cventry{}{}{}{dates}{}` - Work/education entry
- `\cvitems` - Bullet points within entries
- `\cvskill{Technology}{Level}` - Skill with proficiency level

### Version Control
- Never commit PDF files (in .gitignore)
- Never commit build artifacts (*.aux, *.out, build/)
- Keep both language versions in sync structurally
- Use meaningful commit messages for content updates

## Building the Project

### Prerequisites
- **For PDFs**: XeLaTeX compiler (TeXLive distribution recommended)
- **For Website**: Node.js 18+, npm, and direnv

### Build Commands

**LaTeX PDFs (Linux/MacOS):**
```bash
sh ./latex/scripts/build-resume.sh en  # English version
sh ./latex/scripts/build-resume.sh es  # Spanish version
```

**LaTeX PDFs (Windows):**
```cmd
.\latex\scripts\build-resume.cmd en    # English version
.\latex\scripts\build-resume.cmd es    # Spanish version
```

**Website (Local Development):**
> **Note:** All npm/node commands MUST be executed inside the `website/` directory. The project uses `direnv` to manage the Node.js environment, which is only active within this directory.

```bash
cd website
npm install          # First time only
npm run dev          # Development server at http://localhost:4321
npm run build        # Production build
```

### Build Process

**PDF Build:**
1. Validates language parameter (en or es)
2. Creates temporary build directory under `latex/build/`
3. Compiles LaTeX to PDF using XeLaTeX
4. Copies PDF to `latex/output/resume-{lang}.pdf`
5. Cleans up temporary files

**Website Build (GitHub Actions):**
1. Builds both English and Spanish PDFs
2. Installs Node.js dependencies
3. Builds Astro static site
4. Copies PDFs to website dist folder
5. Deploys to GitHub Pages

## Common Tasks

### Updating CV Content

**Important**: `data/` is the main source of truth. When updating CV content, you must propagate to ALL relevant formats:

1. **Update JSON files first** in `data/cv-{lang}.json` (shared source for web and LinkedIn)
2. **Update LaTeX files** in `latex/resume/{lang}/` (for PDF output)
3. **Regenerate LinkedIn files** with `python3 scripts/generate-linkedin.py`
4. **Regenerate InfoJobs files** with `python3 scripts/generate-infojobs.py`
5. Commit all changes together

**Example workflow:**
```bash
# Edit canonical JSON first
vim data/cv-en.json data/cv-es.json

# Edit corresponding LaTeX files
vim latex/resume/en/experience.tex latex/resume/es/experience.tex

# Regenerate LinkedIn pack
python3 scripts/generate-linkedin.py

# Regenerate InfoJobs pack
python3 scripts/generate-infojobs.py

# Commit together
git add data/ latex/resume/ linkedin/ infojobs/
git commit -m "Sync CV content across outputs"
git push  # Triggers automatic deployment
```

### Adding New Work Experience
1. Update `data/cv-{lang}.json` first
2. Open `latex/resume/{lang}/experience.tex`
3. Add new `\cventry` block at the top (reverse chronological)
4. Include: company, location, dates, achievement-focused bullets
5. Regenerate LinkedIn files with `python3 scripts/generate-linkedin.py`
6. Update both English and Spanish versions
7. Keep formatting consistent with existing entries

### Updating Skills
1. Update `data/cv-{lang}.json` skills section first
2. Edit `latex/resume/{lang}/skills.tex`
3. Regenerate LinkedIn files with `python3 scripts/generate-linkedin.py`
4. Maintain skill categories consistently across formats
5. Keep skills relevant and up-to-date

### Adding Open Source Projects
1. Update `data/cv-{lang}.json` opensource array first
2. Edit `latex/resume/{lang}/opensource.tex`
3. Add `\cventry` with role, project name, link, dates
4. Include achievement-focused descriptions
5. Regenerate LinkedIn files with `python3 scripts/generate-linkedin.py`
6. Maintain reverse chronological order

### Updating Personal Information
1. Update `data/cv-{lang}.json` profile section first
2. Edit `latex/resume/{lang}/profile.tex`
3. Regenerate LinkedIn files with `python3 scripts/generate-linkedin.py`
4. Regenerate InfoJobs output with `python3 scripts/generate-infojobs.py`
5. Ensure consistency across all language versions and formats

### Website-Specific Updates

**Styling changes:**
- Edit component files in `website/src/components/`
- Modify layout in `website/src/layouts/Layout.astro`
- Adjust CSS variables in Layout.astro for color scheme

**Adding new pages:**
- Create new `.astro` files in `website/src/pages/`

**Updating metadata:**
- Edit `website/astro.config.mjs` for site configuration

## Deployment

### Automatic Deployment (GitHub Actions)
- Triggered on every push to `master` branch
- Builds both PDFs and website
- Deploys to GitHub Pages automatically
- No manual intervention required

### Custom Domain Setup

1. **Create CNAME file:**
   ```bash
   echo "yourdomain.com" > website/public/CNAME
   ```

2. **Update Astro config** (`website/astro.config.mjs`):
   ```js
   export default defineConfig({
     site: 'https://yourdomain.com',
     base: '/',  // Change from '/cv' to '/'
   });
   ```

3. **Configure DNS records** (at your domain provider):
   - For apex domain: Add A records pointing to GitHub Pages IPs
   - For subdomain: Add CNAME record pointing to `zp1ke.github.io`

4. **Enable in GitHub Settings:**
   - Go to Settings → Pages
   - Enter custom domain
   - Enable HTTPS

5. **Commit and push:**
   ```bash
   git add website/public/CNAME website/astro.config.mjs
   git commit -m "Configure custom domain"
   git push
   ```

See `website/README.md` for detailed DNS configuration.

## Best Practices for AI Assistance

### When Editing Content
- Always specify which format to update (LaTeX, JSON, LinkedIn, InfoJobs, or all)
- Treat `data/` JSON as source of truth, then propagate to LaTeX and LinkedIn (and InfoJobs when relevant)
- Maintain professional tone and concise descriptions
- Use action verbs and achievement-focused language
- Keep technical terms in English even in Spanish version
- Verify LaTeX syntax and JSON validity before suggesting changes

### When Adding Features
- **LaTeX**: Follow existing document class structure, test with XeLaTeX
- **Website**: Use Astro components, maintain responsive design
- Test changes in both environments before committing
- Ensure new features work across both English and Spanish versions

### When Debugging
- **LaTeX**: Check for unclosed braces, missing packages, undefined commands
- **Website**: Validate JSON syntax, check component imports
- Verify file paths are correct relative to project root
- Test compilation/build with verbose output for detailed error messages
- Check GitHub Actions logs for deployment issues

## Color Scheme
- Primary color: `awesome-concrete` (defined in `latex/resume.tex`)
- Available colors: awesome-emerald, awesome-skyblue, awesome-red, awesome-pink, awesome-orange, awesome-nephritis, awesome-concrete, awesome-darknight
- Section highlighting can be toggled with `\setbool{acvSectionColorHighlight}{true/false}`

## Fonts
- Main font: Roboto (Light, Regular, Medium, Bold variants)
- Icon font: FontAwesome 4.x
- All fonts stored in `latex/fonts/` directory

## Maintenance Notes
- Keep version number updated in footer (currently 1.2.1)
- Review and update content at least quarterly
- Remove outdated skills and experiences
- Ensure all links are current and working
- Check for LaTeX package updates that might affect compilation

## Git Workflow
- Main branch for stable, production-ready CV
- Create feature branches for significant updates
- Test compilation before committing changes
- Keep commits atomic and well-documented
