# EOG: плагин jk-nav

Навигация по галерее в стиле vim и выход по `Q`.

Файлы ставятся в `~/.local/share/eog/plugins/` (ansible: `tasks/eog.yml`),
плагин включается через dconf:

```
/org/gnome/eog/plugins/active-plugins = ['fullscreen', 'jk-nav']
```

## Зачем плагин

В современных eog нет пользовательских хоткеев: `~/.config/eog/accels` игнорируется.
Бинды задаются только через API приложения, например из Python-плагина:

```python
app = Eog.Application.get_instance()
app.set_accels_for_action("win.go-next", ["J", ...])
```

## Полезные actions

| Action            | Назначение                         |
|-------------------|------------------------------------|
| `win.go-next`     | следующая картинка                 |
| `win.go-previous` | предыдущая                         |
| `win.go-first`    | первая                             |
| `win.go-last`     | последняя                          |
| `win.close-all`   | закрыть все окна                   |
| `app.quit`        | выйти из приложения                |

`Escape` в fullscreen только снимает fullscreen, не закрывает eog.
Чтобы `Q` выходил целиком — вешать `app.quit` (или `win.close-all`).

Дефолтные `Home`/`End` для first/last остаются у eog; на клавиатурах без этих
клавиш достаточно своих биндов, дублировать Home/End не обязательно.

## Что работает на практике (проверено)

Текущий набор в `jk-nav.py`:

```text
J           win.go-next
K           win.go-previous
G           win.go-first
<Shift>G    win.go-last
Q           app.quit
```

### Регистр букв

- Нижний регистр (`j`, `k`) для next/previous **работал**.
- Нижний `q` / `g` — **нет**; верхний `Q` / `G` — **да**.
- Надёжный вариант для этого окружения (GTK + раскладка + eog) —
  биндить **uppercase** (`J`, `K`, `Q`, `G`).

Пара `g` + `<Shift>g` (lowercase + Shift) **не** заработала.
Пара `G` + `<Shift>G` — заработала.

`0` / `dollar` (`$`) для first/last тоже работают: это разные keysym’ы,
а не «одна буква ± Shift».

### Последовательности клавиш

Vim-style последовательности (`gg`, `dd`) через `set_accels_for_action`
**нельзя**: только одна клавиша или комбинация с модификаторами
(`<Ctrl>…`, `<Shift>…`). Последовательности — только своим обработчиком
`key-press` в плагине.

### Несколько акселераторов на один action

Список ключей на один action в принципе поддерживается
(`set_accels_for_action` принимает list of str). Если «массив не сработал»,
часто виноваты сами имена клавиш (`G` vs `<Shift>g`, `$` vs `dollar`),
а не формат списка.

## Пакеты

Нужны `eog`, `eog-plugins`, `python3-gi` (см. `ansible/vars/debian.yml`).
Loader в `.plugin`: `python3`.
