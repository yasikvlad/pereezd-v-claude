#!/usr/bin/env bash
# Ставит скилл «Переезд в Claude» в Claude Code (macOS / Linux).
# curl -fsSL https://raw.githubusercontent.com/yasikvlad/pereezd-v-claude/main/install.sh | bash
set -euo pipefail

REPO="yasikvlad/pereezd-v-claude"
DEST="$HOME/.claude/skills/pereezd-iz-chatgpt"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

echo "🚚 Тащу скилл с GitHub..."
curl -fsSL "https://github.com/$REPO/archive/refs/heads/main.tar.gz" | tar -xz -C "$TMP"

mkdir -p "$HOME/.claude/skills"
rm -rf "$DEST"
cp -R "$TMP/pereezd-v-claude-main/pereezd-iz-chatgpt" "$DEST"
chmod +x "$DEST/scripts/"*.sh

echo
bash "$DEST/scripts/check_env.sh" || true
echo
echo "✅ Скилл стоит: $DEST"
echo "Дальше: открой Claude Code и напиши «Перенеси мою память из ChatGPT». Остальное сделают агенты."
