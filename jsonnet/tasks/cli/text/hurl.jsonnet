local ctx = import 'ctx.jsonnet';
local GHR = import 'github-release.jsonnet';

local hurl_version = '6.0.0';
local hurl_arch = 'x86_64-unknown-linux-gnu';
local hurl_repo = 'https://github.com/Orange-OpenSource/hurl';
local hurl_dirname = 'hurl-' + hurl_version + '-' + hurl_arch;
local hurl_bin = ctx.home + '/bin/hurl';

[
  GHR.Check(hurl_bin, 'hurl_binary', name='Check if hurl is installed'),
  GHR.Install('hurl_binary', {
    hurl_version: hurl_version,
    hurl_arch: hurl_arch,
    hurl_repo: hurl_repo,
    hurl_dirname: hurl_dirname,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: hurl_repo + '/releases/download/' + hurl_version
             + '/' + hurl_dirname + '.tar.gz',
        extract_dir: '',
        copy_src: '{{ghr_tmp_dir}}/' + hurl_dirname + '/bin/hurl',
        copy_dest: '{{ ghr_install_dir }}/hurl',
      },
    ],
  }, 'Install hurl release'),
]
