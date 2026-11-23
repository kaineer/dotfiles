# tasks/cli/text/

Текстовые CLI-утилиты. Подключаются из `../text.jsonnet` (плюс общий `~/bin`).

| Файл | Установка | Конфиг / линки |
|---|---|---|
| `ripgrep.jsonnet` | apt `ripgrep` (system) + profile/config (user) | `ansible/files/ripgrep/` |
| `fd.jsonnet` | GitHub release → `~/bin/fd` | — |
| `jless.jsonnet` | GitHub release → `~/bin/jless` | — |
| `eza.jsonnet` | GitHub release → `~/bin/eza` + profile | `ansible/files/eza/` |
| `bat.jsonnet` | GitHub release → `~/bin/bat` + profile | `ansible/files/bat/` |
| `hurl.jsonnet` | GitHub release → `~/bin/hurl` | — |
| `xq.jsonnet` | GitHub release → `~/bin/xq` | — |

`lig.jsonnet` сейчас не подключён (закомментирован в `text.jsonnet`) — кандидат на удаление, если не нужен.
