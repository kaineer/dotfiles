# config/

Данные для `vars.json` (и списки, которые таски читают на этапе jsonnet).

| Файл / каталог | Содержание |
|---|---|
| `vars.jsonnet` | Точка сборки: user, пакеты, workstations, scripts, logs |
| [`packages/`](packages/) | Списки apt/package имён |
| `workstations.jsonnet` | Хосты, на которых крутится desktop/GUI |
| `bash-scripts.jsonnet` | Имена bash-скриптов → линк в `~/bin` |
| `rust-scripts.jsonnet` | Крейты из `~/git/config/cli-rs` → `cargo install` |
| `logs.jsonnet` | Короткие имена (`error`, `warn`, …) → symlink на `log` |

JPATH: `-J jsonnet/config`. Менять списки здесь, а не дублировать в tasks.
