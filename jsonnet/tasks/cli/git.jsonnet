local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local Pkg = import 'package-task.jsonnet';

local delta_version = '0.18.2';
local delta_architecture = 'x86_64-unknown-linux-gnu';
local delta_repository = 'https://github.com/dandavison/delta';
local delta_bin = ctx.home + '/bin/delta';

[
  F.Dir(
    ctx.home + '/.config/git',
    name='Create git config directory',
    recurse=true,
  ),
  F.Link(
    ctx.files + '/git/gitconfig',
    ctx.home + '/.config/git/config',
    name='Copy git config',
    mode='644',
  ),
  F.Link(
    ctx.files + '/git/gitignore',
    ctx.home + '/.config/git/ignore',
    name='Copy git global ignore',
    mode='644',
  ),
  F.Link(
    ctx.files + '/git/profile',
    ctx.home + '/.config/profile.d/git',
    name='Set profile link',
  ),
  Pkg('Install github executable', 'gh'),
  {
    name: 'Check if delta viewer installed',
    stat: {
      path: delta_bin,
    },
    register: 'delta_binary',
  },
  {
    name: 'Install delta diff viewer',
    when: 'not delta_binary.stat.exists',
    include_role: {
      name: 'ansible-role-github-release',
    },
    vars: {
      owner: ctx.user.name,
      delta_version: delta_version,
      delta_architecture: delta_architecture,
      delta_repository: delta_repository,
      ghr_install_dir: ctx.home + '/bin',
      ghr_releases: [
        {
          url: delta_repository + '/releases/download/' + delta_version
               + '/delta-' + delta_version + '-' + delta_architecture + '.tar.gz',
          extract_dir: '{{ ghr_tmp_dir }}/delta',
          copy_src: '{{ ghr_tmp_dir }}/tmp/delta/delta-' + delta_version
                    + '-' + delta_architecture + '/delta',
          copy_dest: '{{ ghr_install_dir }}/delta',
        },
      ],
    },
  },
]
