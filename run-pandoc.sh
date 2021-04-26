#!/bin/bash
shopt -s globstar
shopt -s nullglob

rm -r docs/chapter

for f in raw/**/*.md; do
  file_rel=$(realpath --relative-to="raw" "$f")

  echo $file_rel

  if [[ "$file_rel" == "index.md" ]]; then
    pandoc -f gfm -t html5 --template=pandoc-template.html "raw/index.md" -o "docs/index.html"

  else
    file_basename=$(basename "$f" .md)
    file_root=${file_rel%.md}
    mkdir -p "docs/$file_root"
    pandoc -f gfm -t html5 --template=pandoc-template.html "raw/$file_root.md" -o "docs/$file_root/index.html"
  fi

done