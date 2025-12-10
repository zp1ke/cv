# GitHub Copilot Instructions for CV Project

## Project Overview
This is a personal CV/Resume project built with LaTeX. It generates professional PDF resumes in multiple languages (English and Spanish) using the XeLaTeX compiler.

## Project Structure
- `resume.tex` - Main LaTeX document template
- `document-format.cls` - Custom document class defining CV structure and styling
- `fontawesome.sty` - FontAwesome icon package for social media icons
- `fonts/` - Custom fonts directory (Roboto family)
- `resume/en/` - English version content files
- `resume/es/` - Spanish version content files
- `scripts/` - Build scripts for different platforms
- `build/` - Temporary build directory (ignored by git)
- Generated PDFs: `resume-en.pdf`, `resume-es.pdf`

## Content Files (per language)
Each language directory contains modular content files:
1. `profile.tex` - Personal information, contact details, social links
2. `summary.tex` - Professional summary/objective
3. `skills.tex` - Technical skills, languages, and competencies
4. `experience.tex` - Work experience entries
5. `education.tex` - Educational background
6. `opensource.tex` - Open source contributions and projects
7. `madewith.tex` - Footer attribution

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

## Building the Resume

### Prerequisites
- XeLaTeX compiler installed
- TeXLive distribution recommended

### Build Commands
**Linux/MacOS:**
```bash
sh ./scripts/build-resume.sh en  # English version
sh ./scripts/build-resume.sh es  # Spanish version
```

**Windows:**
```cmd
.\scripts\build-resume.cmd en    # English version
.\scripts\build-resume.cmd es    # Spanish version
```

### Build Process
1. Validates language parameter (en or es)
2. Creates temporary build directory
3. Compiles LaTeX to PDF using XeLaTeX
4. Copies PDF to project root as `resume-{lang}.pdf`
5. Cleans up temporary files

## Common Tasks

### Adding New Experience
1. Open `resume/{lang}/experience.tex`
2. Add new `\cventry` block at the top (reverse chronological)
3. Include: project/company, location, dates, responsibilities
4. Update both English and Spanish versions
5. Keep formatting consistent with existing entries

### Updating Skills
1. Edit `resume/{lang}/skills.tex`
2. Maintain skill categories (programming languages, frameworks, databases)
3. Use star ratings: `\faStar` (filled), `\faStarHalfEmpty` (half), `\faStarO` (empty)
4. Keep skills relevant and up-to-date

### Adding Open Source Projects
1. Edit `resume/{lang}/opensource.tex`
2. Add `\cventry` with role, project name, link, dates
3. Include brief description and impact
4. Maintain reverse chronological order

### Updating Personal Information
1. Edit `resume/{lang}/profile.tex`
2. Update contact details, social links, or tagline
3. Ensure consistency across all language versions

## Best Practices for AI Assistance

### When Editing Content
- Always specify which language version to update (or update both)
- Maintain professional tone and concise descriptions
- Use action verbs for experience descriptions
- Keep technical terms in English even in Spanish version
- Verify LaTeX syntax is correct before suggesting changes

### When Adding Features
- Follow existing document class structure
- Test changes by compiling both language versions
- Ensure new features work with XeLaTeX
- Maintain responsive design for different page sizes

### When Debugging
- Check for common LaTeX errors: unclosed braces, missing packages, undefined commands
- Verify file paths are correct relative to project root
- Ensure all referenced files exist in both language directories
- Test compilation with verbose output for detailed error messages

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
