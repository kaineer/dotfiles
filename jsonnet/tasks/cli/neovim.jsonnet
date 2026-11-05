local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local nvim_version = '0.12.0';
local nvim_arch = 'linux-x86_64';
local nvim_repository = 'https://github.com/neovim/neovim';
local nvim_bin = ctx.home + '/bin/nvim';

[
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
  GHR.Check(nvim_bin, 'nvim_binary', name='Check if neovim installed'),
  GHR.Install('nvim_binary', {
    nvim_version: nvim_version,
    nvim_arch: nvim_arch,
    nvim_repository: nvim_repository,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: nvim_repository + '/releases/download/v' + nvim_version
             + '/nvim-' + nvim_arch + '.appimage',
        copy_src: '{{ ghr_tmp_dir }}/nvim-' + nvim_arch + '.appimage',
        copy_dest: '{{ ghr_install_dir}}/nvim',
      },
    ],
  }, 'Install neovim as github release'),
  F.Link(
    ctx.files + '/nvim/config/',
    ctx.home + '/.config/nvim',
    name='Set neovim config link',
  ),
  F.Link(
    ctx.files + '/nvim/profile',
    ctx.home + '/.config/profile.d/nvim',
    name='Set neovim profile and aliases',
  ),
  F.Link(
    ctx.files + '/nvim/snippets/',
    ctx.home + '/.config/snippets',
    name='Set neovim snippets link',
  ),
]
