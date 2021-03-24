@echo off
set filePath=%~dp0
set filePath=%filePath:~0,-1%
set parentPath=%filePath%\..

set buildPath=%parentPath%\build
set resumeFile=%parentPath%\resume.tex

set lang=%1

if "%lang%"=="" ( goto error )
if not exist %parentPath%\resume\%lang% goto error

if exist %buildPath% rmdir /q/s %buildPath%
mkdir %buildPath%

xelatex %resumeFile% -output-directory %buildPath% --jobname %lang%
copy /y %buildPath%\%lang%.pdf %parentPath%\resume-%lang%.pdf

echo %parentPath%\resume-%lang%.pdf created!
rmdir /q/s %buildPath%
goto:eof

:error
  echo Error: Must pass supported language as first parameter!
  echo Supported languages: en, es.
