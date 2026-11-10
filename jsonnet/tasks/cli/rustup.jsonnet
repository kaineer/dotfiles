local ctx = import 'ctx.jsonnet';
local DL = import 'download-install.jsonnet';

[
  {
    name: 'Check rustup presence',
    stat: {
      path: ctx.home + '/.cargo/bin/rustup',
    },
    register: 'rustup_bin',
  },
  DL.Install(
    'rustup',
    binary='rustup_bin',
    url='https://sh.rustup.rs',
    environment={
      CARGO_HOME: ctx.home + '/.cargo',
      RUSTUP_HOME: ctx.home + '/.rustup',
    },
    argv=['-y', '--no-modify-path', '--default-toolchain', 'stable'],
  ),
]
