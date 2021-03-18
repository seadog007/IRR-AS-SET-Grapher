#!/bin/bash

[ -z "$1" ] && echo 'Please Input Inital AS-Set' && exit 1

tmp="$(mktemp)"
tmp2="$(mktemp)"
./lookup.sh "$1" > "$tmp"
sort -u "$tmp" > "$tmp2"
echo 'digraph{rankdir="LR";' > "$tmp"
cat "$tmp2" >> "$tmp"
echo '}' >> "$tmp"
cp "$tmp" "$1.output"
rm "$tmp" "$tmp2"

