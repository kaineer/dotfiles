// Download an upstream install.sh, run it as the user, remove the script.
// Existence checks stay outside: pass the register name from a prior `stat`.
local ctx = import 'ctx.jsonnet';

{
  // name: short label (also used in /tmp/<name>-install.sh)
  // binary: ansible register from the outer presence check (e.g. "herdr_bin")
  // url: install script URL
  // environment: extra env merged onto { HOME: ctx.home }
  // argv: extra args after the script path (empty: run the script alone)
  Install(name, binary, url, environment={}, argv=[])::
    local script = '/tmp/' + name + '-install.sh';
    local env = { HOME: ctx.home } + environment;
    local run =
      if std.length(argv) == 0 then
        { command: script }
      else
        { command: { argv: [script] + argv } };
    {
      name: 'Install ' + name,
      when: 'not ' + binary + '.stat.exists',
      block: [
        {
          name: 'Download ' + name + ' install script',
          get_url: {
            url: url,
            dest: script,
            mode: '0755',
          },
        },
        {
          name: 'Run ' + name + ' install script',
          become_user: ctx.user.name,
          environment: env,
        } + run,
        {
          name: 'Remove ' + name + ' install script',
          file: {
            path: script,
            state: 'absent',
          },
        },
      ],
    },
}
