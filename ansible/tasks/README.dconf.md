## Load sample

```
- name: Load dconf file
  dconf:
    key: "/org/gnome/desktop/background"
    value: "file:///path/to/your/dconf/file"
    state: load
```
