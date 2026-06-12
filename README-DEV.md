# Development Setup Guide

This guide explains how to use the development utilities for the CV project.

## Quick Start

### Option 1: Manual sourcing (works immediately)

```bash
# In the project directory
source dev.sh

# Show available commands
cv-help

# Example workflow
cv-build-all      # Build both PDFs
cv-dev-web        # Start website dev server
```

### Option 2: Auto-load with direnv (recommended)

[direnv](https://direnv.net/) automatically loads the development environment when you enter the project directory.

#### Installation

**Ubuntu/Debian:**
```bash
sudo apt install direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc
source ~/.bashrc
```

**macOS:**
```bash
brew install direnv
echo 'eval "$(direnv hook zsh)"' >> ~/.zshrc
source ~/.zshrc
```

**Other shells:** See [direnv documentation](https://direnv.net/docs/hook.html)

#### Enable for this project

```bash
cd /path/to/cv
direnv allow
```

Now the dev commands will be automatically available whenever you `cd` into this directory!

### Option 3: Global installation

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
# Load CV project dev utilities
[ -f ~/Projects/github/cv/dev.sh ] && source ~/Projects/github/cv/dev.sh
```

## Available Commands

### PDF Generation

- **`cv-build-en`** - Build English resume PDF
- **`cv-build-es`** - Build Spanish resume PDF
- **`cv-build-all`** - Build both English and Spanish PDFs

### Website Development

- **`cv-dev-web`** - Start development server at http://localhost:4321
- **`cv-build-web`** - Build website for production
- **`cv-preview-web`** - Preview production build locally

### Utilities

- **`cv-copy-pdfs`** - Copy generated PDFs to website/dist/ folder
- **`cv-deploy`** - Full deployment build (PDFs + website + copy)
- **`cv-install`** - Install website Node.js dependencies
- **`cv-clean`** - Clean all build artifacts
- **`cv-help`** - Show help message with all commands

## Common Workflows

### Content update sync (required)
When CV content changes, use this order:
1. Update canonical JSON in `data/cv-en.json` and/or `data/cv-es.json`
2. Mirror changes in LaTeX files under `latex/resume/en/` and/or `latex/resume/es/`
3. Regenerate LinkedIn files: `python3 scripts/generate-linkedin.py`
4. Regenerate InfoJobs output: `python3 scripts/generate-infojobs.py`
5. Validate builds (`cv-build-all`, then `cv-build-web`)

### Local development (website only)
```bash
cv-dev-web
# Opens http://localhost:4321
```

### Update PDFs and test locally
```bash
cv-build-all      # Generate PDFs
cv-dev-web        # Test in browser
```

### Full deployment preparation
```bash
cv-deploy         # Builds everything and copies PDFs to website
cv-preview-web    # Preview final result
```

### Clean start
```bash
cv-clean          # Remove build artifacts
cv-install        # Reinstall dependencies
cv-deploy         # Full rebuild
```

## Prerequisites

- **XeLaTeX** - For PDF generation (TeXLive distribution)
- **Node.js 18+** - For website development
- **npm** - Comes with Node.js

## Troubleshooting

### Commands not found
- Make sure you've sourced the script: `source dev.sh`
- Or allow direnv: `direnv allow`
- Check your shell configuration

### PDF build fails
- Verify XeLaTeX is installed: `xelatex --version`
- Check for LaTeX errors in build output

### Website won't start
- Install dependencies: `cv-install`
- Check Node.js version: `node --version` (should be 18+)
- Clear cache: `rm -rf website/node_modules website/dist`

### PDFs not appearing in website
- Run `cv-copy-pdfs` after building PDFs
- Or use `cv-deploy` for full build pipeline

## CI/CD Integration

The GitHub Actions workflow uses the same build scripts:
- `.github/workflows/deploy.yml`

Local builds match production builds for consistency.
