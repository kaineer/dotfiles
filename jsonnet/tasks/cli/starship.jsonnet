local ctx = import 'ctx.jsonnet';
local F = import 'file-task.jsonnet';
local GHR = import 'github-release.jsonnet';

local starship_version = '1.26.0';
local starship_arch = 'i686-unknown-linux-musl';
local starship_repository = 'https://github.com/starship/starship';
local starship_bin = ctx.home + '/bin/starship';

[
  F.Dir(
    ctx.home + '/bin',
    name='Mkdir for bin scripts',
    recurse=true,
  ),
  GHR.Check(starship_bin, 'starship_binary', name='Check if starship is installed'),
  GHR.Install('starship_binary', {
    starship_version: starship_version,
    starship_repository: starship_repository,
    starship_arch: starship_arch,
    ghr_install_dir: ctx.home + '/bin',
    ghr_releases: [
      {
        url: starship_repository + '/releases/download/v' + starship_version
             + '/starship-' + starship_arch + '.tar.gz',
        owner: ctx.user.name,
        copy_src: '{{ ghr_tmp_dir }}/starship',
        copy_dest: '{{ ghr_install_dir }}/starship',
        extract_dir: '',
      },
    ],
  }, 'Install starship as github release'),
  F.Link(
    ctx.files + '/starship/starship.toml',
    ctx.home + '/.config/starship.toml',
    name='Link starship config',
  ),
  F.Link(
    ctx.files + '/starship/profile.sh',
    ctx.home + '/.config/profile.d/starship',
    name='Copy starship profile',
  ),
  F.Link(
    ctx.files + '/starship/icon',
    ctx.home + '/bin/icon',
    name='Copy icon script',
  ),
]
