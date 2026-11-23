# tasks/rust/

Свои Rust-утилиты из репозитория `cli-rs`. Идут **после** `cli/` (нужен rustup).

| Файл | Что делает |
|---|---|
| `repo.jsonnet` | клон/pull `~/git/config/cli-rs` |
| `cli.jsonnet` | `cargo install --path` для имён из `config/rust-scripts.jsonnet`; чистка конфликтующих symlink’ов в `~/bin` |

Список бинарников менять в `config/rust-scripts.jsonnet`, не здесь.
