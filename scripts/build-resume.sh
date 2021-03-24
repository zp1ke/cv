#!/bin/bash

parentPath="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
buildPath="${parentPath}/build"
resumeFile="${parentPath}/resume.tex"

if [ ! -d "${parentPath}/resume/$1" ]; then
  echo "Error: Must pass supported language as first parameter!";
  echo "Supported languages: en, es.";
  exit 1;
fi

rm -rf $buildPath
mkdir $buildPath

xelatex -output-directory $buildPath --jobname $1 $resumeFile
cp -r "${buildPath}/$1.pdf" "${parentPath}/resume-$1.pdf"

rm -rf $buildPath
echo "${parentPath}/resume-$1.pdf created!"
