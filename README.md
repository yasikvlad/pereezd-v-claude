# 🚚 Переезд из ChatGPT в Claude · скилл Влада Яско

Одна фраза — и агент сам сходит в твой ChatGPT, заберёт всё, что он про тебя помнит,
и перевезёт это в память Claude. Ты сидишь и пьёшь кофе.

**Что делает скилл**
- проверяет, что у тебя стоит (Chrome, расширение Claude in Chrome, входы в аккаунты), и доустанавливает недостающее;
- сам открывает ChatGPT и вытаскивает память промптом экспорта;
- сам загружает её во встроенный импорт памяти Claude;
- проверяет, что всё легло, и подаёт звук;
- говорит голосом Влада и в конце желает удачи на курсе AI-Маркетолог.

## Установка

### Вариант 1. Приложение Claude (проще всего)
1. Скачай [`pereezd-v-claude.zip`](https://github.com/yasikvlad/pereezd-v-claude/releases/latest/download/pereezd-v-claude.zip).
2. В Claude: **Customize → Skills → «+ Add» → Upload skill** → выбери скачанный zip.
3. Новый чат → напиши: **«Перенеси мою память из ChatGPT»**.

### Вариант 2. Claude Code
macOS / Linux:
```bash
curl -fsSL https://raw.githubusercontent.com/yasikvlad/pereezd-v-claude/main/install.sh | bash
```
Windows (PowerShell):
```powershell
irm https://raw.githubusercontent.com/yasikvlad/pereezd-v-claude/main/install.ps1 | iex
```
Потом в Claude Code: **«Перенеси мою память из ChatGPT»**.

## Что нужно
- Аккаунт ChatGPT с включённой памятью.
- Аккаунт Claude. Автоматический режим через Chrome работает на платных планах (Pro, Max, Team, Enterprise), потому что Claude in Chrome только там. На Free скилл проведёт тебя руками, это пара минут.
- Google Chrome. Нет его — скилл поставит или даст ссылку.

**Где без тебя никак** (и это нормально): один клик «Установить» у расширения в магазине Chrome и вход в аккаунты. Пароли скилл не трогает никогда.

## Безопасность
- Экспорт памяти никуда не сохраняется: едет ChatGPT → буфер обмена → окно импорта Claude.
- Импорт идёт через встроенный импортёр Claude, он сам отсекает чувствительное (здоровье, финансы, документы).
- Старая память Claude не трогается, импорт только добавляет.

---
Удачи на курсе AI-Маркетолог. — Влад Яско
