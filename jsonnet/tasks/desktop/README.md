# tasks/desktop/

GUI-задачи. Весь блок только если `ansible_nodename in gui_workstations`
(список — `config/workstations.jsonnet`).

## System

| Файл | Что ставит |
|---|---|
| `packages.jsonnet` | `gui_packages` |
| `brave.jsonnet` | Brave (apt repo) |
| `gnome.jsonnet` (часть) | `python3-psutil` для dconf |

## User

| Файл | Что делает |
|---|---|
| `wezterm.jsonnet` | AppImage → `~/bin/wezterm` + конфиг *(кандидат на отказ в пользу herdr)* |
| `rofi.jsonnet` | конфиг rofi |
| `gnome.jsonnet` | раскладка/опции клавиатуры (dconf) |
| `pinta.jsonnet` | AppImage → `~/bin/pinta` + settings |
| `eog.jsonnet` | плагин jk-nav + dconf |
| `obsidian.jsonnet` | AppImage → `~/bin/obsidian` + icon/desktop |
| `telegram.jsonnet` | Telegram Desktop tarball + `~/bin` link |
| `zathura.jsonnet` | конфиг zathura |
| `zed.jsonnet` | zed install.sh + settings/keymap/nordic theme |
| `fonts.jsonnet` | Fira Nerd Font в user fonts + cache |

AppImage-паттерн: `lib/appimage-task.jsonnet` (`~/bin/appimages/` + symlink).
