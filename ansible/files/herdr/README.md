# Herdr personal config

Файлы из этой папки `ax update` линкует в `~/.config/herdr-app/`
(`jsonnet/tasks/cli/herdr.jsonnet`). Штатные моды Herdr (`agents`, `files`,
`pane`, …) ставит само приложение; здесь — Nord-оверлей и сторонние моды.

Активный layout: **`main-nord`**.

## Что ставится

### Линкуются из ansible

| Путь | Назначение |
|---|---|
| `settings.json` | Nord, FiraCode, telemetry off, звуки |
| `sounds/` | done/blocked mp3 (пути в settings относительно `~/.config/herdr-app`) |
| `keys.json` | `ctrl-space …`, Alt+hjkl, on-screen, gitview, сплиты |
| `programs.json` | `cursor` → `cursor-agent` (+ match `agent`) |
| `themes/nord.json` | палитра |
| `layouts/main-nord.json` | окно: spaces-nord, agents, tabs-nord, Files/gitview |
| `mods/spaces-nord` | сайдбар spaces |
| `mods/tabs-nord` | табы + память панели по space |
| `mods/files-toggle` | `ctrl-space o f` — Files |
| `mods/changes-toggle` | `ctrl-space o g` — Changes/gitview |
| `mods/cursor-status` | статус Cursor Agent → Agents |
| `mods/on-screen` | terminal right-click / `ctrl-shift-o` (symlink на весь каталог: у мода есть `import "./…"`) |

`vim-nav` не используется (навигация в `keys.json` + neovim); каталог
удаляется при прогоне.

### Скрипты при `ax update`

- `scripts/install-cursor-status-hooks.sh` — `node …/status.mjs install`
  (хуки в `~/.cursor/hooks.json`; нужен `node`).
- `scripts/install-gitview.sh` — **только если нет**
  `mods/gitview/bin/herdr-gitview` (`stat` + `when` в jsonnet; повторные
  `ax update` скрипт не вызывают). Клонирует
  [herdr-gitview](https://github.com/ChmaraX/herdr-gitview), собирает
  бинарь (`cargo`) и ставит моды. Когда Herdr запущен — upstream
  `herdr-app/install.sh`; иначе — копирование без `app-setup` (слот
  Changes→`gitview` и клавиши уже в ansible).

Слот панели Changes в layout указывает на **`gitview`**. Клавиши:

| Клавиша | Действие |
|---|---|
| `ctrl-alt-g` | gitview во вкладке |
| `ctrl-alt-shift-g` | панель Changes/gitview |
| `ctrl-shift-o` | on-screen |
| `ctrl-space o f` / `o g` | Files / Changes |

`on-screen`: только Neovim (`letters.nvim: "v"`), без VS Code/Zed.

## Зависимости

- `herdr-app` / `hc` (ставится тем же jsonnet, если нет)
- `node` — хуки cursor-status
- `git` + `cargo` — первая установка gitview
- `nvim`, `agent`/`cursor-agent` — бинды и статус агентов
- FiraCode Nerd Font Mono — `settings.font`

`herdr-nvim` не ставится.

## Проверка после прогона

```sh
herdr-app do layout.switch '{"name":"main-nord"}'
herdr-app check ~/.config/herdr-app/mods/on-screen
herdr-app check ~/.config/herdr-app/mods/cursor-status
herdr-app check ~/.config/herdr-app/mods/gitview   # после install-gitview
herdr-app status
node ~/.config/herdr-app/mods/cursor-status/status.mjs doctor
```

Подробности сетапа на машине также в `~/.config/herdr-app/CONFIG.md`
(черновик; канон — этот README).
