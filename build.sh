#!/usr/bin/env bash
set -u
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DIR"
export TEXINPUTS="$DIR/styles:${TEXINPUTS:-}"
export BSTINPUTS="$DIR/styles:${BSTINPUTS:-}"
pdflatex -interaction=nonstopmode main.tex > build.log 2>&1 || true
bibtex main >> build.log 2>&1 || true
pdflatex -interaction=nonstopmode main.tex >> build.log 2>&1 || true
pdflatex -interaction=nonstopmode main.tex >> build.log 2>&1 || true
[ -f main.pdf ] && echo "OK: $(ls -lh main.pdf | awk '{print $5}') main.pdf" || echo "FAIL"
