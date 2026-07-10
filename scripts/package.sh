#!/usr/bin/env bash
# Package each skill folder as a ZIP suitable for ChatGPT / Claude skill upload.
set -euo pipefail

cd "$(dirname "$0")/.."
mkdir -p dist

for skill in mobile-submission mobile-automation; do
  out="dist/${skill}.zip"
  rm -f "$out"
  zip -rq "$out" "$skill" -x "*.DS_Store"
  echo "built $out"
done
