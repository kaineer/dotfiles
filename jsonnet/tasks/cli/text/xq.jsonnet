local ctx = import 'ctx.jsonnet';
local GHR = import 'github-release.jsonnet';

local xq_version = '1.3.0';
local xq_arch = 'linux_amd64';
local xq_repo = 'https://github.com/sibprogrammer/xq';
local xq_bin = ctx.home + '/bin/xq';

[
  GHR.Check(xq_bin, 'xq_binary', name='Check if xq is installed'),
  GHR.Install('xq_binary', {
    xq_version: xq_version,
    xq_arch: xq_arch,
    xq_repo: xq_repo,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: xq_repo + '/releases/download/v' + xq_version
             + '/xq_' + xq_version + '_' + xq_arch + '.tar.gz',
        copy_src: '{{ghr_tmp_dir}}/xq',
        copy_dest: '{{ghr_install_dir}}/xq',
        extract_dir: '',
      },
    ],
  }, 'Install xq release'),
]
