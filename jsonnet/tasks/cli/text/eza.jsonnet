local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local eza_version = '0.20.11';
local eza_arch = 'x86_64-unknown-linux-musl';
local eza_repo = 'https://github.com/eza-community/eza';
local eza_bin = ctx.home + '/bin/eza';

[
  GHR.Check(eza_bin, 'eza_binary', name='Check if eza is installed'),
  GHR.Install('eza_binary', {
    eza_version: eza_version,
    eza_arch: eza_arch,
    eza_repo: eza_repo,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: eza_repo + '/releases/download/v' + eza_version
             + '/eza_' + eza_arch + '.tar.gz',
        copy_src: '{{ghr_tmp_dir}}/eza',
        copy_dest: '{{ghr_install_dir}}/eza',
        extract_dir: '',
      },
    ],
  }, 'Install eza release'),
  F.Link(
    ctx.files + '/eza/profile',
    ctx.home + '/.config/profile.d/eza',
    name='Set link to eza profile',
  ),
]
