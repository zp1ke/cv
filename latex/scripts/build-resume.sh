#!/bin/bash

set -e  # Exit on error

scriptDir="$( cd -P "$( dirname "$0" )" >/dev/null 2>&1 && pwd )"
latexPath="$( cd -P "${scriptDir}/.." >/dev/null 2>&1 && pwd )"
buildPath="${latexPath}/build"
outputPath="${latexPath}/output"
resumeFile="${latexPath}/resume.tex"

# Check if xelatex is available
if ! command -v xelatex &> /dev/null; then
  echo "Error: xelatex command not found!";
  echo "Please install TeXLive or MiKTeX with XeLaTeX support.";
  echo "";
  echo "Installation instructions:";
  echo "  - Linux: sudo apt install texlive-xetex texlive-fonts-recommended texlive-fonts-extra";
  echo "  - macOS: brew install --cask mactex";
  echo "  - Windows: Download from https://miktex.org/download";
  exit 1;
fi

# Validate language parameter
if [ -z "$1" ]; then
  echo "Error: Must pass supported language as first parameter!";
  echo "Supported languages: en, es.";
  echo "Usage: $0 [en|es]";
  exit 1;
fi

if [ ! -d "${latexPath}/resume/$1" ]; then
  echo "Error: Unsupported language '$1'!";
  echo "Supported languages: en, es.";
  exit 1;
fi

# Clean and create build directory
rm -rf "$buildPath"
mkdir -p "$buildPath"
mkdir -p "$outputPath"

echo "Building resume for language: $1..."

# Build PDF with xelatex
if ! (cd "$latexPath" && xelatex -output-directory "$buildPath" --jobname "$1" "$resumeFile"); then
  echo "Error: Failed to compile LaTeX document!";
  exit 1;
fi

# Copy PDF to latex output directory
if [ -f "${buildPath}/$1.pdf" ]; then
  cp "${buildPath}/$1.pdf" "${outputPath}/resume-$1.pdf"
  echo "✓ Success! ${outputPath}/resume-$1.pdf created!"
else
  echo "Error: PDF file not generated!";
  exit 1;
fi

# Clean up build directory
rm -rf "$buildPath"

exit 0
