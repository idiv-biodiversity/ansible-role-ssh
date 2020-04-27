#!/bin/bash

app=$(basename "$0" .sh)

[[ $# -eq 1 ]] || {
  echo "usage: $app MIN_MODULUS" >&2
  exit 1
}

min_modulus=$1

min_modulus_lines=$(
  awk -v min_modulus="$min_modulus" \
      '$1 != "#" && $5 < min_modulus' \
      /etc/ssh/moduli |
    wc -l
)

if [[ $min_modulus_lines -gt 0 ]]
then
  tmp=$(mktemp)
  trap 'rm -f "$tmp"' EXIT INT TERM

  {
    awk -v min_modulus="$min_modulus" \
        '$1 == "#" || $5 >= min_modulus' \
        /etc/ssh/moduli
  } > "$tmp"

  mv "$tmp" /etc/ssh/moduli

  echo XXXchangedXXX
fi
