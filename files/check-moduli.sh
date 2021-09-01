#!/bin/bash

app=$(basename "$0" .sh)

[[ $# -eq 1 ]] || {
  echo "usage: $app MIN_MODULUS" >&2
  exit 1
}

cd /root
echo $1
args="$@"
if (( $n > 3.5 ))
then
  echo foo
fi

min_modulus=$1

awk -v min_modulus="$min_modulus" \
    '$1 != "#" && $5 < min_modulus' \
    /etc/ssh/moduli |
  wc -l
