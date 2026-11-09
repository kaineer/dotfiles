local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';

local gui = 'ansible_nodename in gui_workstations';
local ytdl_bin = ctx.home + '/bin/releases/ytdl';
local ytdl_version = '2026.07.04';
local ytdl_repo = 'https://github.com/yt-dlp/yt-dlp';

[
  F.Dir(
    ctx.home + '/bin/releases',
    name='Mkdir for releases',
    recurse=true,
    when=gui,
  ),
  {
    name: 'Check if ytdl already installed',
    stat: { path: ytdl_bin },
    register: 'ytdl_binary',
  },
  {
    name: 'Install ytdl release',
    when: gui + ' and not ytdl_binary.stat.exists',
    include_role: { name: 'ansible-role-github-release' },
    vars: {
      owner: ctx.user.name,
      ytdl_repo: ytdl_repo,
      ytdl_version: ytdl_version,
      ghr_install_dir: ctx.home + '/bin/releases',
      ghr_releases: [
        {
          url: ytdl_repo + '/releases/download/' + ytdl_version + '/yt-dlp_linux',
          owner: ctx.user.name,
          copy_src: '{{ghr_tmp_dir}}/yt-dlp_linux',
          copy_dest: '{{ghr_install_dir}}/ytdl',
        },
      ],
    },
  },
  F.Link(
    ytdl_bin,
    ctx.home + '/bin/ytdl',
    name='Link from bin to bin/release',
    when=gui,
  ),
]
