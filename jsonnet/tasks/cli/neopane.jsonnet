// Install neopane next to herdr (Neovim panes → herdr / tmux / …).
// Binary: ~/.local/bin/neopane (+ npane). Script pins release v0.2.2
// (herdr support); cargo --git --tag is the fallback for relocation.
local ctx = import 'ctx.jsonnet';

local neopane_bin = ctx.home + '/.local/bin/neopane';
local user_path =
  ctx.home + '/.cargo/bin:'
  + ctx.home + '/.local/bin:'
  + ctx.home + '/bin:'
  + '{{ ansible_env.PATH }}';

[
  {
    name: 'Check neopane presence',
    stat: {
      path: neopane_bin,
    },
    register: 'neopane_bin',
  },
  {
    name: 'Install neopane when missing',
    when: 'not neopane_bin.stat.exists',
    environment: {
      HOME: ctx.home,
      PATH: user_path,
      NEOPANE_VERSION: 'v0.2.2',
      NEOPANE_INSTALL_DIR: ctx.home + '/.local/bin',
      CARGO_HOME: ctx.home + '/.cargo',
      RUSTUP_HOME: ctx.home + '/.rustup',
    },
    script: ctx.files + '/neopane/scripts/install.sh',
  },
]
