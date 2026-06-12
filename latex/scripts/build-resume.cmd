@echo off
setlocal enabledelayedexpansion

set filePath=%~dp0
set filePath=%filePath:~0,-1%
set parentPath=%filePath%\..

set buildPath=%parentPath%\build
set outputPath=%parentPath%\output
set resumeFile=%parentPath%\resume.tex
set lang=%1

REM Check if xelatex is available
where xelatex >nul 2>&1
if errorlevel 1 (
  echo Error: xelatex command not found!
  echo Please install MiKTeX or TeXLive with XeLaTeX support.
  echo.
  echo Download from: https://miktex.org/download
  exit /b 1
)

REM Validate language parameter
if "%lang%"=="" (
  echo Error: Must pass supported language as first parameter!
  echo Supported languages: en, es.
  echo Usage: %~nx0 [en^|es]
  exit /b 1
)

if not exist "%parentPath%\resume\%lang%" (
  echo Error: Unsupported language '%lang%'!
  echo Supported languages: en, es.
  exit /b 1
)

REM Clean and create build directory
if exist "%buildPath%" rmdir /q/s "%buildPath%"
mkdir "%buildPath%"
if not exist "%outputPath%" mkdir "%outputPath%"

echo Building resume for language: %lang%...

REM Build PDF with xelatex
pushd "%parentPath%"
xelatex -output-directory "%buildPath%" --jobname "%lang%" "%resumeFile%"
popd
if errorlevel 1 (
  echo Error: Failed to compile LaTeX document!
  exit /b 1
)

REM Copy PDF to latex output directory
if exist "%buildPath%\%lang%.pdf" (
  copy /y "%buildPath%\%lang%.pdf" "%outputPath%\resume-%lang%.pdf" >nul
  echo √ Success! %outputPath%\resume-%lang%.pdf created!
) else (
  echo Error: PDF file not generated!
  exit /b 1
)

REM Clean up build directory
rmdir /q/s "%buildPath%"

exit /b 0
