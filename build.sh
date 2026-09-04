#!/usr/bin/env bash

set -euo pipefail
cd "$(dirname "$0")"

if [ -z "$1" ]; then
  filename="main"
else
  filename="${1%.*}"
fi


echo "Compiling ${filename}..."

typst compile --root . --font-path assets/fonts "${filename}.typ" "${filename}.pdf" &
typst compile --root . --font-path assets/fonts --features html --input target=html "${filename}.typ" "${filename}.html" &

wait
echo "Built: ${filename}.pdf and ${filename}.html"
typst --version
