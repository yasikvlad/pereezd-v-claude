# Технические шаги в браузере (проверено вживую)

Всё ниже прогнано на реальном переезде через расширение Claude in Chrome. Инструменты
названы как в Claude Code (`mcp__claude-in-chrome__*`); в чате Claude у коннектора те же
действия: navigate, screenshot, find, click, javascript, get_page_text.

Совет по скорости: объединяй цепочки действий в `browser_batch`.

## 0. Вкладка

`tabs_context_mcp` с `createIfEmpty: true` → берёшь `tabId` пустой вкладки и работаешь в ней.

## 1. Вставить промпт в ChatGPT

Поле ввода ChatGPT — редактор ProseMirror. Селектор `#prompt-textarea` у многих уже
не работает, бери `.ProseMirror[contenteditable="true"]`.

```js
const prompt = `<ВЕСЬ ТЕКСТ ИЗ export-prompt.md>`;
const el = document.querySelector('.ProseMirror[contenteditable="true"]');
el.focus();
const dt = new DataTransfer();
dt.setData('text/plain', prompt);
el.dispatchEvent(new ClipboardEvent('paste', {clipboardData: dt, bubbles: true, cancelable: true}));
el.innerText.length   // > 1000 значит вставилось
```

Внутри шаблонной строки нет обратных кавычек, промпт можно вставлять как есть.

## 2. Отправить

Скриншот → кнопка со стрелкой справа от поля ввода → клик. Или `find` «send button».

## 3. Дождаться ответа

```js
for (let i = 0; i < 60; i++) {
  if (!document.querySelector('[data-testid="stop-button"]')) break;
  await new Promise(r => setTimeout(r, 3000));
}
const codes = [...document.querySelectorAll('main pre')];
const t = codes.length ? codes[codes.length - 1].innerText : '';
({ blocks: codes.length, len: t.length, head: t.slice(0, 200) })
```

Длинные строки из JS обрезаются инструментом примерно на 1000 символах, поэтому весь
экспорт через JS в свой контекст не тяни: он тебе и не нужен, он едет через буфер.
Хвост ответа (есть ли «more remain») смотри так:

```js
document.querySelector('main').innerText.slice(-900)
```

## 4. Скопировать экспорт в буфер

`find` → «Copy code button in code block header» (по-русски кнопка называется
«Копировать код»). Затем `scroll_to` по ref и `left_click` по ref. Только настоящий клик:
JS-ный `navigator.clipboard.writeText` без жеста пользователя падает.

## 5. Открыть импорт в Claude

`navigate` → `https://claude.ai/settings/capabilities?open_memory_import=true`, подождать
3–4 секунды, скриншот. Появится окно «Import memory to Claude» с двумя шагами; второе
поле — «Paste your memory details here».

## 6. Вставить и проверить

Клик в поле → `key` `cmd+v` (macOS) / `ctrl+v` (Windows, Linux). Проверка:

```js
const ta = [...document.querySelectorAll('textarea')]
  .find(t => (t.placeholder || '').toLowerCase().includes('memory'));
({ len: ta?.value.length, head: ta?.value.slice(0, 80) })
```

`len` должен совпасть с длиной экспорта из шага 3 (± пара символов).

## 7. Отправить в память

После вставки окно растягивается и кнопка «Add to memory» съезжает вниз. Ищи её
заново: `find` «Add to memory button» → клик по ref. Потом:

```js
let s = '';
for (let i = 0; i < 30; i++) {
  s = document.body.innerText;
  if (!s.includes('Import in progress')) break;
  await new Promise(r => setTimeout(r, 4000));
}
({ inProgress: s.includes('Import in progress') })
```

## 8. Проверить список памяти

Прокрутить панель Settings → Memory вниз (`scroll` по центру панели) и сделать
скриншоты. Новые и дополненные разделы помечены «Updated just now».

## 9. Звук без терминала

```js
const ctx = new (window.AudioContext || window.webkitAudioContext)();
[[660,0],[880,0.18],[1320,0.36]].forEach(([f,t]) => {
  const o = ctx.createOscillator(), g = ctx.createGain();
  o.frequency.value = f; o.connect(g); g.connect(ctx.destination);
  g.gain.setValueAtTime(0.25, ctx.currentTime + t);
  g.gain.exponentialRampToValueAtTime(0.001, ctx.currentTime + t + 0.3);
  o.start(ctx.currentTime + t); o.stop(ctx.currentTime + t + 0.32);
});
'played'
```

Если браузер заблокировал звук (политика автоплея), не страшно: просто напиши 🔔 в финале.
