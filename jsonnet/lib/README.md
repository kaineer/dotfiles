# lib/

Общие хелперы для задач. Сами по себе ничего не ставят — их импортируют файлы из `tasks/`.

| Файл | Что даёт |
|---|---|
| `ctx.jsonnet` | `home`, `user`, `files`, `playbookDir` из extVar |
| `split.jsonnet` | `System` / `User` / `Merge` — раскладка задач по двум play |
| `file-task.jsonnet` | `Dir`, `Link`, `DirLink` (замена directory→symlink), `Absent` |
| `package-task.jsonnet` | Короткий `package:` таск |
| `dconf-task.jsonnet` | Запись ключа dconf (user-play) |
| `github-release.jsonnet` | `Check` + `Install` через роль `ansible-role-github-release` |
| `download-install.jsonnet` | Скачать upstream `install.sh` и выполнить |
| `appimage-task.jsonnet` | `~/bin/appimages` + download + symlink в `~/bin/<name>` |

JPATH: `-J jsonnet/lib` (см. `build.sh`).
