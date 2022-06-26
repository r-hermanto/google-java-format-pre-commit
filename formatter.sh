#!/usr/bin/env bash
mkdir -p .cache

VERSION="1.15.0"
GJF_JAR="google-java-format-${VERSION}-all-deps.jar"
JAR_URL="https://github.com/google/google-java-format/releases/download/v${VERSION}/${GJF_JAR}"

if [ ! -f ".cache/$GJF_JAR" ]
then
    curl -o ".cache/${GJF_JAR}" -LJ ${JAR_URL}
    chmod u+x ".cache/$GJF_JAR"
fi

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
if [ -n "$changed_java_files" ]
then
  echo "Reformat staged java files: $changed_java_files"
  java -jar ".cache/${GJF_JAR}" --aosp --replace --set-exit-if-changed $changed_java_files
fi

