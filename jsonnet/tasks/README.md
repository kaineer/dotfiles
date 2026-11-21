# tasks/

Ansible-задачи. Точка входа — `main.jsonnet` → `{ system, user }`.

Порядок сборки в `main.jsonnet`: **cli → rust → media → desktop**.

| Каталог | Что покрывает |
|---|---|
| [`cli/`](cli/) | Shell, CLI-утилиты, herdr/neopane, nvim, пакеты system |
| [`rust/`](rust/) | Клон `cli-rs` + `cargo install` своих утилит |
| [`media/`](media/) | Терминальные медиа (mocp) и cleanup старого mpd/rmpc |
| [`desktop/`](desktop/) | GUI только на `gui_workstations` |

Новую область: подкаталог + `main.jsonnet` + импорт в `tasks/main.jsonnet`.
