#!/usr/bin/env bash
set -euo pipefail

OUT_DIR="docs/evidence/command_outputs"
mkdir -p "$OUT_DIR"

TS="$(date +%Y%m%d_%H%M%S)"
OUT_FILE="$OUT_DIR/${TS}_$(hostname)_evidence.txt"

{
  echo "=== Evidence capture ==="
  date
  echo
  echo "## hostnamectl"
  hostnamectl || true
  echo
  echo "## ip a"
  ip a || true
  echo
  echo "## ss -tulpn"
  ss -tulpn || true
  echo
  echo "## ufw status verbose"
  ufw status verbose || true
  echo
  echo "## systemctl status ssh"
  systemctl status ssh --no-pager || true
  echo
} | tee "$OUT_FILE"

echo
echo "Saved: $OUT_FILE"
