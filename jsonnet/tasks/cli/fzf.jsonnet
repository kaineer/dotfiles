local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local fzf_version = '0.54.3';
local fzf_architecture = 'linux_amd64';
local fzf_repository = 'https://github.com/junegunn/fzf';
local fzf_bin = ctx.home + '/bin/fzf';

[
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
  GHR.Check(fzf_bin, 'fzf_binary', name='Check if fzf is installed'),
  GHR.Install('fzf_binary', {
    fzf_version: fzf_version,
    fzf_repository: fzf_repository,
    fzf_architecture: fzf_architecture,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: fzf_repository + '/releases/download/v' + fzf_version
             + '/fzf-' + fzf_version + '-' + fzf_architecture + '.tar.gz',
        copy_src: '{{ ghr_tmp_dir }}/fzf',
        copy_dest: '{{ ghr_install_dir}}/fzf',
        extract_dir: '',
      },
    ],
  }, 'Install fzf as github release'),
  F.Dir(
    ctx.home + '/.config/fzf',
    name='Create config dir',
    recurse=true,
  ),
  F.Link(
    ctx.files + '/fzf/fzf.completion',
    ctx.home + '/.config/fzf/fzf.completion',
    name='Link completion script',
  ),
]
