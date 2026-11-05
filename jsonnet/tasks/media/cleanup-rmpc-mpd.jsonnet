local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local xdgRuntime = "/run/user/{{ lookup('pipe', 'id -u " + ctx.user.name + "') }}";

// One-shot leftovers from the rmpc/mpd experiment.
[
  {
    name: 'Stop and disable user mpd (rmpc experiment cleanup)',
    become_user: ctx.user.name,
    environment: {
      XDG_RUNTIME_DIR: xdgRuntime,
    },
    systemd: {
      name: 'mpd.service',
      scope: 'user',
      state: 'stopped',
      enabled: false,
    },
    failed_when: false,
  },
  F.Absent(
    ctx.home + '/bin/rmpc',
    name='Remove ~/bin/rmpc',
  ),
  F.Absent(
    ctx.home + '/.config/mpd',
    name='Remove ~/.config/mpd',
  ),
]
