@echo off
setlocal enabledelayedexpansion

set filePath=%~dp0
set filePath=%filePath:~0,-1%
set parentPath=%filePath%\..

set buildPath=%parentPath%\build
set resumeFile=%parentPath%\resume.tex
set lang=%1

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

echo Building resume for language: %lang%...

REM Build PDF with xelatex
xelatex -output-directory "%buildPath%" --jobname "%lang%" "%resumeFile%"
if errorlevel 1 (
  echo Error: Failed to compile LaTeX document!
  exit /b 1
)

REM Copy PDF to project root
if exist "%buildPath%\%lang%.pdf" (
  copy /y "%buildPath%\%lang%.pdf" "%parentPath%\resume-%lang%.pdf" >nul
  echo √ Success! %parentPath%\resume-%lang%.pdf created!
) else (
  echo Error: PDF file not generated!
  exit /b 1
)

REM Clean up build directory
rmdir /q/s "%buildPath%"

exit /b 0
