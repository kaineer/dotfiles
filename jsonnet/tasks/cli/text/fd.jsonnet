local ctx = import 'ctx.jsonnet';
local GHR = import 'github-release.jsonnet';

local fd_version = '10.1.0';
local fd_arch = 'i686-unknown-linux-musl';
local fd_repo = 'https://github.com/sharkdp/fd';
local fd_bin = ctx.home + '/bin/fd';

[
  GHR.Check(fd_bin, 'fd_binary', name='Check if fd is installed'),
  GHR.Install('fd_binary', {
    fd_version: fd_version,
    fd_arch: fd_arch,
    fd_repo: fd_repo,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: fd_repo + '/releases/download/v' + fd_version
             + '/fd-v' + fd_version + '-' + fd_arch + '.tar.gz',
        copy_src: '{{ghr_tmp_dir}}/fd-v' + fd_version + '-' + fd_arch + '/fd',
        copy_dest: '{{ghr_install_dir}}/fd',
        extract_dir: '',
      },
    ],
  }, 'Install fd release'),
]
