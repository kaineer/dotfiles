# config/packages/

Списки имён пакетов для `package` / `apt` (подключаются из `vars.jsonnet`).

| Файл | Куда идёт | Play |
|---|---|---|
| `system.jsonnet` | `system_packages` — базовый набор на каждой машине | system |
| `gui.jsonnet` | `gui_packages` — только на `gui_workstations` | system (через desktop) |
| `obsolete.jsonnet` | `obsolete_packages` — снести (`apt state=absent`) | system |

Ставятся в `tasks/cli/packages.jsonnet` и `tasks/desktop/packages.jsonnet`.
