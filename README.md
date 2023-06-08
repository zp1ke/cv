# Resume

Resume using [LaTeX](https://www.latex-project.org/).

### Prerequisites

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

### Build

On Windows:
```
.\scripts\build-resume.cmd [LANGUAGE_CODE]
```

On Linux and MacOS:
```
sh ./scripts/build-resume.sh [LANGUAGE_CODE]
```

Supported language codes (**LANGUAGE_CODE**): es, en.
