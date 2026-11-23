# tasks/cli/

CLI и shell на всех машинах. Сборка: `main.jsonnet` (порядок важен: packages/`~/bin` раньше зависимостей).

## System (become)

| Файл | Что ставит |
|---|---|
| `packages.jsonnet` | `system_packages`, удаление `obsolete_packages` |
| `doppler.jsonnet` | Doppler CLI (apt repo) |
| `git.jsonnet` (часть) | пакет `gh` |
| `text/ripgrep.jsonnet` (часть) | пакет `ripgrep` |

## User (home)

| Файл | Что делает |
|---|---|
| `packages.jsonnet` | `~/bin` |
| `bash.jsonnet` | bashrc / bash-конфиг |
| `profile.jsonnet` | `~/.config/profile.d/*` |
| `scripts.jsonnet` | линки bash-скриптов и log-алиасов в `~/bin` |
| `git.jsonnet` | gitconfig + delta (GitHub release) |
| `text.jsonnet` + [`text/`](text/) | bat, eza, fd, hurl, jless, rg-конфиг, xq |
| `ytdl.jsonnet` | ytdl release в `~/bin` |
| `tmux.jsonnet` | конфиг tmux |
| `starship.jsonnet` | starship (GitHub release) + конфиг |
| `lf.jsonnet` | только удаление старого `~/bin/lf` (заменён yazi) |
| `rustup.jsonnet` | rustup через install.sh |
| `herdr.jsonnet` | herdr-app + Nord/mods symlink’и |
| `neopane.jsonnet` | neopane v0.2.2 (`~/.local/bin`, скрипт в `ansible/files/neopane/`) |
| `yazi.jsonnet` | yazi (cargo) + конфиг/плагины |
| `fzf.jsonnet` | fzf (GitHub release) + completion |
| `neovim.jsonnet` | nvim (GitHub release) + конфиг |
| `node.jsonnet` | fnm (роль ansible-fnm) |

Конфиги/файлы обычно лежат в `ansible/files/<name>/`.
