# scripts

Описание шелл-скриптов с баннером (Tangerine Cat) и полем `What:`.

## `:on`

- **Назначение:** analog of ":only" for tmux

## `:q`

- **Назначение:** analog of ":q" for tmux

## `aid`

- **Назначение:** download ai files
- **Использование:**
  ```
  $ aid         # process clipboard once
  $ aid ls      # list available processors
  $ aid w[atch] # process clipboard on each change
  $ aid <name>  # edit processor script
  $ aid --help  # show this text
  ```

## `ansi`

- **Назначение:** utility for ANSI escape sequences

## `ax`

- **Назначение:** ansible dotfiles launcher

## `b`

- **Назначение:** Browse url from stdin or first parameter
- **Использование:**
  ```
  $ echo https://google.com | b   # open google.com
  $ b https://google.com          # same thing
  ```

## `be`

- **Назначение:** edit script from "$HOME/bin"

## `browse`

- **Назначение:** open browser using $1 as url

## `chooser`

- **Назначение:** choose from list with fzf from terminal, but with rofi -dmenu from gui

## `gateway`

- **Назначение:** Change gateway ip/last octet
- **Использование:**
  ```
  gateway <новый IP или число от 1 до 254>

  Примеры:
    gateway 192.168.1.1    # установить новый шлюз 192.168.1.1
    gateway 100            # заменить последний байт текущего шлюза на 100
  ```

## `gd`

- **Назначение:** proj replacement
- **Использование:**
  ```
  $ gd .                      # add current dir to list
  $ gd add nemo               # add current dir with command
  $ gd <name fragment>        # find dir and open with command
  $ gd e[dit]                 # edit directories file
  $ gd f                      # output config file
  $ gd                        # display full list and select with fzf
  $ gd h[elp]                 # show this text
  ```

## `gi`

- **Назначение:** initialize git remository; add remote into github; push into remote

## `launch`

- **Назначение:** launcher

## `nc`

- **Назначение:** Select color from nord palette and copy to clipboard

## `note`

- **Назначение:** Note taking script

## `opendir`

- **Назначение:** open dir with $EDITOR from terminal, but with nemo from gui

## `pe`

- **Назначение:** Project environment script
- **Использование:**
  ```
  $ pe h[elp] -- show this test
  $ pe reinit -- init project environment again
  $ pe init -- create bin dir etc
  $ pe ls -- list created scripts
  $ pe e[dit] -- edit .envrc
  $ pe footprint|fp -- store .envrc for current user@host
  $ pe [scriptname] -- create/edit a script
  ```

## `pm`

- **Назначение:** runs npm/pnpm/yarn
- **Использование:**
  ```
  $ pm init              # create package.json
  $ pm h[elp]            # show this help
  $ pm ri|reinstall      # remove node_modules, $PM install
  $ pm use npm|pnpm|yarn # choose package manager
  $ pm ver[sion]         # select version and put into .node-version
  $ pm clean             # remove dist and node_modules dirs
  $ pm ls                # list package managers
  $ pm r[egistry] ...    # registry commands
  $ pm r ls              # list available registries
  $ pm r <registry url>  # set registry
  $ pm r select          # list registries, select and set
  $ pm r                 # print current registry url
  $ pm [anything]        # $PM [anything]
  ```

## `switch_layout`

- **Назначение:** switch layout

## `the`

- **Назначение:** Run some commands by domain name
- **Использование:**
  ```
  $ the path        # all parts of current executables path
  $ the net         # address of current available network
  $ the net restart # restart network services
  $ the ssh         # list all ssh hosts, check availability
  $ the uname       # uname active parts
  $ the arch        # architecture for binaries
  $ the kill        # kill selected process
  $ the port <num>  # who is using port
  $ the port <num> kill  # kill the port user process
  ```

## `tx`

- **Назначение:** text filters and mappers

## `urlo`

- **Назначение:** make url by tag and search term

## `var`

- **Назначение:** variables to use in another scripts
- **Использование:**
  ```
  $ var name        # Variable value to stdout
  $ var name value  # Store value for variable
  $ var -d | --delete | rm
                    # Remove value for variable
  $ var -i name     # Store clipboard to variable
  $ var -l | ls     # List variables with values

  ENV vars:
  » VAR_ROOT ($HOME/var by default) - where to keep variables
  ```

## `x`

- **Назначение:** runner

## `yn`

- **Назначение:** yes/no script. runs $@ for 'yes' answer

## `zed-copy-lines`

- **Назначение:** Copy lines from zed editor into clipboard
