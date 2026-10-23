#!/usr/bin/env bash
# Разведка окружения для скилла «Переезд в Claude».
# Без флагов только проверяет. Флаги:
#   --install-chrome   поставить Google Chrome (macOS через brew) или открыть страницу загрузки
#   --open-extension   открыть страницу расширения Claude in Chrome в Chrome
#   --open-claude      открыть страницу загрузки приложения Claude

EXT_URL="https://chromewebstore.google.com/detail/claude/fcoeoabgfenejglbffodgkkbkcdhcgfn"
CHROME_URL="https://www.google.com/chrome/"
CLAUDE_URL="https://claude.com/download"

case "$(uname -s)" in
  Darwin) OS=mac ;;
  Linux) OS=linux ;;
  MINGW*|MSYS*|CYGWIN*) OS=windows ;;
  *) OS=unknown ;;
esac

open_url() {
  case "$OS" in
    mac) open "$1" ;;
    linux) xdg-open "$1" >/dev/null 2>&1 ;;
    windows) cmd.exe /c start "" "$1" ;;
  esac
}

open_in_chrome() {
  case "$OS" in
    mac) open -a "Google Chrome" "$1" 2>/dev/null || open "$1" ;;
    windows) cmd.exe /c start chrome "$1" 2>/dev/null || open_url "$1" ;;
    *) (google-chrome "$1" >/dev/null 2>&1 &) || open_url "$1" ;;
  esac
}

chrome=no
case "$OS" in
  mac) [ -d "/Applications/Google Chrome.app" ] || [ -d "$HOME/Applications/Google Chrome.app" ] && chrome=yes ;;
  linux) command -v google-chrome >/dev/null 2>&1 || command -v google-chrome-stable >/dev/null 2>&1 && chrome=yes ;;
  windows)
    for p in "/c/Program Files/Google/Chrome/Application/chrome.exe" "/c/Program Files (x86)/Google/Chrome/Application/chrome.exe" "$LOCALAPPDATA/Google/Chrome/Application/chrome.exe"; do
      [ -f "$p" ] && chrome=yes
    done ;;
esac

claude_app=no
case "$OS" in
  mac) [ -d "/Applications/Claude.app" ] || [ -d "$HOME/Applications/Claude.app" ] && claude_app=yes ;;
  windows) [ -d "$LOCALAPPDATA/AnthropicClaude" ] && claude_app=yes ;;
esac

claude_cli=no
command -v claude >/dev/null 2>&1 && claude_cli=yes

for arg in "$@"; do
  case "$arg" in
    --install-chrome)
      if [ "$chrome" = yes ]; then
        echo "chrome: уже стоит"
      elif [ "$OS" = mac ] && command -v brew >/dev/null 2>&1; then
        brew install --cask google-chrome && chrome=yes
      else
        open_url "$CHROME_URL"; echo "chrome: открыл страницу загрузки"
      fi ;;
    --open-extension) open_in_chrome "$EXT_URL"; echo "extension: открыл страницу расширения" ;;
    --open-claude) open_url "$CLAUDE_URL"; echo "claude: открыл страницу загрузки" ;;
  esac
done

echo "os=$OS"
echo "chrome=$chrome"
echo "claude_desktop=$claude_app"
echo "claude_code_cli=$claude_cli"
echo "extension_url=$EXT_URL"
