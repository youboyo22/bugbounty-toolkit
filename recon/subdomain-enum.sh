#!/usr/bin/env bash
# subdomain-enum.sh — passive subdomain discovery for an authorised target.
# Usage: ./subdomain-enum.sh example.com [output-file]
set -euo pipefail

TARGET="${1:?usage: subdomain-enum.sh <domain> [output-file]}"
OUT="${2:-$TARGET.subdomains.txt}"

echo "[*] crt.sh: $TARGET"
curl -fsS --max-time 60 "https://crt.sh/?q=%25.${TARGET}&output=json" \
  | grep -oE '"name_value":"[^"]+"' | sed 's/"name_value":"//;s/"$//' \
    | tr '\\n' '\n' | sed 's/\*\.//' | tr '[:upper:]' '[:lower:]' \
      | sort -u > "$OUT.raw" || true

echo "[*] dns bufferoverflow"
curl -fsS --max-time 30 "https://dns.bufferover.run/dns?q=.${TARGET}" \
  | grep -oE '"FDNS_A":"[^"]+"' | cut -d'"' -f4 | cut -d',' -f2 \
    | sed 's/\*\.//' | sort -u >> "$OUT.raw" || true

sort -u "$OUT.raw" | sed '/^$/d' > "$OUT"
rm -f "$OUT.raw"

echo "[+] $(wc -l < "$OUT") unique names -> $OUT"
echo "[*] resolving live hosts (optional): while read h; do getent hosts \"$h\" >/dev/null && echo \"$h\"; done < \"$OUT\""
