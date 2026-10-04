#!/bin/bash
# Renders cv-en.html / cv-pt.html to the PDFs in ../cv with headless Brave (or Chrome).
set -euo pipefail
cd "$(dirname "$0")"
B="/Applications/Brave Browser.app/Contents/MacOS/Brave Browser"
[ -x "$B" ] || B="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
for lang in ${@:-en pt}; do
  [ -f "cv-$lang.html" ] || continue
  out="../cv/Anderson-Silva-CV-2026-$(echo $lang | tr a-z A-Z).pdf"
  "$B" --headless=new --disable-gpu --no-pdf-header-footer --run-all-compositor-stages-before-draw \
    --virtual-time-budget=3000 --print-to-pdf="$out" "file://$PWD/cv-$lang.html" 2>/dev/null
  echo "built $out ($(pdfinfo "$out" | awk '/^Pages/{print $2}') pages)"
done
