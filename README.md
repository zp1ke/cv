# Resume

Resume using [LaTeX](https://www.latex-project.org/).

### Prerequisites

- **xelatex** command available on system path.

On Windows:
You can download it [here](https://miktex.org/download).

On Linux:
```
sudo apt install texlive-xetex texlive-fonts-recommended texlive-fonts-extra
```

### Build

On Windows:
```
.\scripts\build-resume.cmd [LANG_CODE]
```

On Linux:
```
sh ./scripts/build-resume.sh [LANGUAGE_CODE]
```

Supported language codes (**LANGUAGE_CODE**): es, en.
