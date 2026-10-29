local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local lf_version = 'r42';
local lf_architecture = 'linux-amd64';
local lf_repository = 'https://github.com/gokcehan/lf';
local lf_bin = ctx.home + '/bin/lf';

[
  F.Dir(
    ctx.home + '/.config/lf',
    name='Mkdir for lf rc',
    recurse=true,
  ),
  F.Link(
    ctx.files + '/lf/rc',
    ctx.home + '/.config/lf/lfrc',
    name='Copy LF rc file',
    mode='644',
  ),
  F.Link(
    ctx.files + '/lf/icons.example',
    ctx.home + '/.config/lf/icons',
    name='Copy icons file',
    mode='644',
  ),
  F.Link(
    ctx.files + '/lf/colors.example',
    ctx.home + '/.config/lf/colors',
    name='Copy colors file',
    mode='644',
  ),
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
  F.Link(
    ctx.files + '/lf/previewer.sh',
    ctx.home + '/bin/lf-preview.sh',
    name='Copy LF previewer',
    mode='644',
  ),
  GHR.Check(lf_bin, 'lf_binary', name='Check if lf is installed'),
  GHR.Install('lf_binary', {
    lf_version: lf_version,
    lf_architecture: lf_architecture,
    lf_repository: lf_repository,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: lf_repository + '/releases/download/' + lf_version
             + '/lf-' + lf_architecture + '.tar.gz',
        copy_src: '{{ ghr_tmp_dir }}/lf',
        copy_dest: '{{ ghr_install_dir}}/lf',
        extract_dir: '',
      },
    ],
  }, 'Install lf as github release'),
]
