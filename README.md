# Resume

Professional CV/Resume built with [LaTeX](https://www.latex-project.org/), supporting multiple languages (English and Spanish).

## Development Environment

This project includes a DevContainer configuration for easy setup with VS Code:
- Pre-configured with LaTeX (TeXLive full scheme)
- LaTeX Workshop extension
- No manual installation required

## Prerequisites

- **xelatex** command available on system path.

On Windows:
Download it [here](https://miktex.org/download).

On Linux:
Install with CLI.
```
sudo apt install texlive-xetex texlive-fonts-recommended texlive-fonts-extra
```

On MacOS:
Download it [here](https://www.tug.org/mactex/mactex-download.html).

## Build

On Windows:
```
.\scripts\build-resume.cmd [LANGUAGE_CODE]
```

On Linux and MacOS:
```
sh ./scripts/build-resume.sh [LANGUAGE_CODE]
```

Supported language codes (**LANGUAGE_CODE**): es, en.

## Project Structure

- `resume.tex` - Main LaTeX document
- `document-format.cls` - Custom document class
- `resume/en/` - English content files
- `resume/es/` - Spanish content files
- `scripts/` - Build scripts
- `.github/copilot-instructions.md` - GitHub Copilot instructions

## Libraries

- [Fontawesome](https://fontawesome.com/v4/icons/)
- Custom document class based on Awesome CV

## Contributing

When updating the CV:
1. Maintain consistency across both language versions
2. Use reverse chronological order for experience/education
3. Test compilation for both languages before committing
4. Follow the coding standards in `.github/copilot-instructions.md`
