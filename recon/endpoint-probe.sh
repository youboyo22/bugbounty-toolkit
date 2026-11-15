#!/usr/bin/env bash
# endpoint-probe.sh — passive HTTP probe for an authorised target list.
# Usage: ./endpoint-probe.sh targets.txt [out.csv]
# Input: one host per line. Output: host,status,server,content-type,length
set -euo pipefail

TARGETS="${1:?usage: endpoint-probe.sh <targets.txt> [out.csv]}"
OUT="${2:-endpoints.csv}"
printf 'host,status,server,content_type,length\n' > "$OUT"

while read -r host; do
  [ -z "$host" ] && continue
  body=$(curl -fsS -m 15 -D - -o /dev/null -s "https://${host}" || true)
  status=$(printf '%s' "$body" | awk 'toupper($1) ~ /^HTTP\// {c=$2} END{print c+0}')
  server=$(printf '%s' "$body" | awk -F': ' 'tolower($1)=="server"{sub(/^[^:]+: /,"");print;exit}')
  ctype=$(printf '%s' "$body" | awk -F': ' 'tolower($1)=="content-type"{sub(/^[^:]+: /,"");print;exit}')
  printf '%s,%s,%s,%s,\n' "$host" "${status:-0}" "${server:-}" "${ctype:-}" >> "$OUT"
done < "$TARGETS"

echo "[+] wrote $OUT"
