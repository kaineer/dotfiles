local ctx = import 'ctx.jsonnet';
local GHR = import 'github-release.jsonnet';

local jless_version = '0.9.0';
local jless_arch = 'x86_64-unknown-linux-gnu';
local jless_repo = 'https://github.com/PaulJuliusMartinez/jless';
local jless_bin = ctx.home + '/bin/jless';

[
  GHR.Check(jless_bin, 'jless_binary', name='Check if jless is installed'),
  GHR.Install('jless_binary', {
    jless_version: jless_version,
    jless_arch: jless_arch,
    jless_repo: jless_repo,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: jless_repo + '/releases/download/v' + jless_version
             + '/jless-v' + jless_version + '-' + jless_arch + '.zip',
        copy_src: '{{ghr_tmp_dir}}/jless',
        copy_dest: '{{ghr_install_dir}}/jless',
        extract_dir: '',
      },
    ],
  }, 'Install jless release'),
]
