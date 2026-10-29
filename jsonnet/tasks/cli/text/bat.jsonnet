local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local bat_version = '0.24.0';
local bat_arch = 'i686-unknown-linux-musl';
local bat_repo = 'https://github.com/sharkdp/bat';
local bat_bin = ctx.home + '/bin/bat';

[
  GHR.Check(bat_bin, 'bat_binary', name='Check if bat is installed'),
  GHR.Install('bat_binary', {
    bat_version: bat_version,
    bat_arch: bat_arch,
    bat_repo: bat_repo,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: bat_repo + '/releases/download/v' + bat_version
             + '/bat-v' + bat_version + '-' + bat_arch + '.tar.gz',
        copy_src: '{{ghr_tmp_dir}}/bat-v' + bat_version + '-' + bat_arch + '/bat',
        copy_dest: '{{ghr_install_dir}}/bat',
        extract_dir: '',
      },
    ],
  }, 'Install bat release'),
  F.Link(
    ctx.files + '/bat/profile',
    ctx.home + '/.config/profile.d/bat',
    name='Link bat profile',
  ),
]
