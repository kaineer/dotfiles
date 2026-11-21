# jsonnet

Исходники Ansible-задач и переменных. `build.sh` компилирует их в:

- `ansible/tasks-system.json` — пакеты, apt, `/usr` / `/etc` (`become`)
- `ansible/tasks-user.json` — всё под `$HOME` (от текущего пользователя)
- `ansible/vars.json` — переменные playbook

Запуск: `ax update` (system + home) или `ax home` (только home).

## Каталоги

| Каталог | Назначение |
|---|---|
| [`lib/`](lib/) | Переиспользуемые хелперы (link, appimage, split, …) |
| [`config/`](config/) | Списки пакетов, скриптов, хостов → `vars.json` |
| [`tasks/`](tasks/) | Сами задачи установки/линковки |

Вспомогательное: `analyze.py` — отчёт used/unused jsonnet и повторяющихся блоков.
