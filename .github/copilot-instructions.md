# GitHub Copilot Instructions for CV Project

## Project Overview
This is a personal CV/Resume project with dual outputs:
1. **PDF Resumes**: Professional LaTeX-generated PDFs in English and Spanish using XeLaTeX compiler
2. **Web Portfolio**: Modern Astro-based static website deployed to GitHub Pages with PDF download links

Both outputs are automatically built and deployed via GitHub Actions on every push to master.

## Project Structure

### LaTeX CV (PDF Generation)
- `resume.tex` - Main LaTeX document template
- `document-format.cls` - Custom document class defining CV structure and styling
- `fontawesome.sty` - FontAwesome icon package for social media icons
- `fonts/` - Custom fonts directory (Roboto family)
- `resume/en/` - English version content files
- `resume/es/` - Spanish version content files
- `scripts/` - Build scripts for different platforms
- `build/` - Temporary build directory (ignored by git)
- Generated PDFs: `resume-en.pdf`, `resume-es.pdf`

### Astro Website
- `website/` - Astro static site project
  - `src/data/` - CV content in JSON format (cv-en.json, cv-es.json)
  - `src/components/` - Reusable Astro components
  - `src/layouts/` - Page layouts
  - `src/pages/` - Routes (index.astro for English, es/index.astro for Spanish)
  - `public/` - Static assets (favicon, PDFs copied during build)
  - `astro.config.mjs` - Astro configuration
  - `package.json` - Node.js dependencies

### CI/CD
- `.github/workflows/deploy.yml` - GitHub Actions workflow for building and deploying both PDFs and website

## Content Files

### LaTeX Content (per language)
Each language directory (`resume/en/`, `resume/es/`) contains modular content files:
1. `profile.tex` - Personal information, contact details, social links
2. `summary.tex` - Professional summary/objective
3. `skills.tex` - Technical skills, languages, and competencies
4. `experience.tex` - Work experience entries
5. `education.tex` - Educational background
6. `opensource.tex` - Open source contributions and projects

### Website Content
Content is maintained separately in JSON format:
- `website/src/data/cv-en.json` - English version
- `website/src/data/cv-es.json` - Spanish version

**IMPORTANT**: LaTeX and JSON content must be kept in sync manually. When updating CV content, update both formats.

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
- Use semantic macro names from `document-format.cls`
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
- **For Website**: Node.js 18+ and npm

### Build Commands

**LaTeX PDFs (Linux/MacOS):**
```bash
sh ./scripts/build-resume.sh en  # English version
sh ./scripts/build-resume.sh es  # Spanish version
```

**LaTeX PDFs (Windows):**
```cmd
.\scripts\build-resume.cmd en    # English version
.\scripts\build-resume.cmd es    # Spanish version
```

**Website (Local Development):**
```bash
cd website
npm install          # First time only
npm run dev          # Development server at http://localhost:4321
npm run build        # Production build
```

### Build Process

**PDF Build:**
1. Validates language parameter (en or es)
2. Creates temporary build directory
3. Compiles LaTeX to PDF using XeLaTeX
4. Copies PDF to project root as `resume-{lang}.pdf`
5. Cleans up temporary files

**Website Build (GitHub Actions):**
1. Builds both English and Spanish PDFs
2. Installs Node.js dependencies
3. Builds Astro static site
4. Copies PDFs to website dist folder
5. Deploys to GitHub Pages

## Common Tasks

### Updating CV Content

**Important**: When updating CV content, you must update BOTH formats:

1. **Update LaTeX files** in `resume/{lang}/` (for PDF output)
2. **Update JSON files** in `website/src/data/cv-{lang}.json` (for web output)
3. Commit both changes together

**Example workflow:**
```bash
# Edit LaTeX
vim resume/en/experience.tex

# Edit corresponding JSON
vim website/src/data/cv-en.json

# Commit together
git add resume/en/experience.tex website/src/data/cv-en.json
git commit -m "Add new work experience"
git push  # Triggers automatic deployment
```

### Adding New Work Experience
1. Open `resume/{lang}/experience.tex`
2. Add new `\cventry` block at the top (reverse chronological)
3. Include: company, location, dates, achievement-focused bullets
4. Update `website/src/data/cv-{lang}.json` with same content
5. Update both English and Spanish versions
6. Keep formatting consistent with existing entries

### Updating Skills
1. Edit `resume/{lang}/skills.tex`
2. Update `website/src/data/cv-{lang}.json` skills section
3. Maintain skill categories consistently across formats
4. Keep skills relevant and up-to-date

### Adding Open Source Projects
1. Edit `resume/{lang}/opensource.tex`
2. Update `website/src/data/cv-{lang}.json` opensource array
3. Add `\cventry` with role, project name, link, dates
4. Include achievement-focused descriptions
5. Maintain reverse chronological order

### Updating Personal Information
1. Edit `resume/{lang}/profile.tex`
2. Update `website/src/data/cv-{lang}.json` profile section
3. Ensure consistency across all language versions and formats

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
- Always specify which format to update (LaTeX, JSON, or both)
- Update both LaTeX and JSON when changing CV content
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
- Primary color: `awesome-concrete` (defined in resume.tex)
- Available colors: awesome-emerald, awesome-skyblue, awesome-red, awesome-pink, awesome-orange, awesome-nephritis, awesome-concrete, awesome-darknight
- Section highlighting can be toggled with `\setbool{acvSectionColorHighlight}{true/false}`

## Fonts
- Main font: Roboto (Light, Regular, Medium, Bold variants)
- Icon font: FontAwesome 4.x
- All fonts stored in `fonts/` directory

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
