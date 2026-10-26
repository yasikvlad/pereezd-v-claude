# Способы переноса из ChatGPT в Claude: что известно

Это точка отсчёта для еженедельной проверки. Всё, что здесь уже есть, «новым» не считается.
Последнее обновление: 2026-10-26.

## Проверка 2026-10-26

За неделю нового нет. Новых репозиториев по теме с 23.10 не найдено (поиск GitHub по нескольким запросам). В release notes Claude нет изменений импорта памяти и Claude in Chrome (ближайшее: 21.10 Claude Duet для Pro/Max, не по теме). Промпт экспорта на claude.com/import-memory не показан без клика, сверить не удалось. Ссылки: claude.com/import-memory, claude.com/download, статьи support.claude.com отвечают 200. Не проверены из-за ограничений сети окружения: claude.ai (403 на curl), Chrome Web Store и help.openai.com (нет соединения). Скилл не менялся.

## Официальные способы

| Способ | Что переносит | Ограничения |
|---|---|---|
| Встроенный импорт памяти Claude (Settings → Memory → Start import, `claude.ai/settings/capabilities?open_memory_import=true`), запущен 2026-03-02 | Текстовую сводку памяти, которую отдаёт ChatGPT на промпт экспорта | Только то, что ChatGPT «вспомнил». Чувствительное фильтруется (переключатель «Include sensitive topics»). Файл не принимает. Помечен как экспериментальный |
| Экспорт данных ChatGPT (Settings → Data controls → Export data) | Все чаты: `conversations.json` (дерево `mapping`, большие архивы бьются на `conversations-000.json`…), `chat.html`, `user.json` (по сторонним данным там custom instructions) | Сохранённой памяти, Custom GPT и картинок в нём нет. Письмо идёт от минут до 7 дней. На Business/Enterprise через Privacy Portal |
| Claude Projects + RAG | Разбитый по темам экспорт как база знаний | Файл до 30 МБ. RAG только на платных планах. В память Claude не попадает |
| Claude Code локально | Читает `conversations.json`, делает выжимку в `CLAUDE.md` / auto memory / текст для импорта | Нужен Claude Code. Самый полный и приватный путь |

Официального импорта истории чатов (чат за чатом) в Claude на 2026-10-23 нет.

Память ChatGPT: saved memories, reference chat history, с 2026-06-04 Dreaming (Memory Summary в Settings → Personalization).

## Найденные проекты

| Проект | Звёзды / последний коммит | Суть | Вердикт |
|---|---|---|---|
| [Siamsnus/GPT2Claude-Migration-Kit](https://github.com/Siamsnus/GPT2Claude-Migration-Kit) | 29 / 2026-04-22 | Закладка или скрипт в консоли тянет память, чаты и инструкции через внутренний `/backend-api` | Полнее нашего, но неофициальный API, ToS OpenAI, в память Claude не кладёт |
| [midweste/chatgpt-to-claude](https://github.com/midweste/chatgpt-to-claude) | 9 / 2026-04-29 | Расширение Chrome, переносит чаты в проекты Claude через внутренний API claude.ai | Перенос памяти не доделан, ставится в режиме разработчика, тратит лимиты |
| [NextStat/chatgpt2md](https://github.com/NextStat/chatgpt2md) | 20 / 2026-03-01 | ZIP-экспорт → Markdown + локальный MCP с поиском | Хорош для всей истории, но через терминал. Проект заброшен |
| [darrellwhitelaw/chatgpt-to-claude](https://github.com/darrellwhitelaw/chatgpt-to-claude) «Move to Claude» | 3 / 2026-03-02 | Приложение для Mac: ZIP → Markdown + MCP | Удобно, но только Apple Silicon и без памяти |
| [kidhack/neuraljack](https://github.com/kidhack/neuraljack) | 2 / 2026-03-18 | Приложение для Mac: ZIP → «Memory Core» для вставки | Вставка руками |
| [1ch1n/mychatarchive](https://github.com/1ch1n/mychatarchive) | 66 / 2026-08-05 | Архив с семантическим поиском через MCP | Архив, а не переезд |
| [letta-ai/skills · importing-chatgpt-memory](https://github.com/letta-ai/skills/tree/main/letta/importing-chatgpt-memory) | 152 / 2026-10-01 | Скилл для Letta: вопросы на старте, превью перед записью | Хорошая подача, но платформа не Claude |
| [crazynomad/free-my-memory](https://github.com/crazynomad/free-my-memory) | 3 / 2026-05-21 | Ручная инструкция с официальным промптом | Совет: включить в ChatGPT все тумблеры памяти и модель Thinking, тогда экспорт в 3+ раза больше (замер автора) |
| [michelve/import-to-claude](https://github.com/michelve/import-to-claude) | 0 | Ручная инструкция | — |
| chatgpt-to-claude-mcp (PyPI), gpt-history-mcp, codex-chats-mcp | — | MCP-серверы по экспорту или локальной базе десктопного ChatGPT | Нишевые, частично на неофициальных API |
| Расширения и сервисы: chatgpt-exporter (userscript), AI Chat Exporter, MemoryPlugin, MemoryLake, Plurality | — | Массовый экспорт или облачная «память» | Риск приватности |

В awesome-списках (awesome-claude-skills, awesome-agent-skills, awesome-claude-code, awesome-mcp-servers) по теме пусто.

## Наша позиция

Наш скилл — единственный, кто сам, через Claude in Chrome, кладёт результат во встроенный импортёр Claude, без неофициальных API и без хранения экспорта. Слабое место: полнота. Переносится только то, что ChatGPT отдаёт на промпт.

## Бэклог улучшений (по убыванию пользы)

1. Перед промптом включить в ChatGPT все тумблеры памяти и выбрать модель Thinking. Тумблеры менять только с согласия человека.
2. Задать промпт 2–3 раза с разных сторон (работа, проекты, стиль, личное) и вставлять каждую часть в импортёр.
3. Сверка: прочитать список Saved memories в настройках ChatGPT и сравнить с экспортом.
4. Custom instructions: прочитать в ChatGPT и предложить перенести в Claude → Settings → Profile (только после явного «да»).
5. Необязательный шаг «вся история»: помочь запросить официальный экспорт, затем Project с RAG или Claude Code для выжимки.
6. Короткий вопрос на старте: «какие темы не тащим?».
7. Подать скилл в awesome-claude-skills и awesome-agent-skills.

## Чего не делаем никогда

Неофициальный `/backend-api` ChatGPT, запись во внутренний API claude.ai, чтение кук, хранение экспорта в файлах, ввод паролей.
