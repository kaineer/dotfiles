// Ordered concatenation of migrated task modules.
local bash = import 'cli/bash.jsonnet';
local profile = import 'cli/profile.jsonnet';
local scripts = import 'cli/scripts.jsonnet';
local git = import 'cli/git.jsonnet';
local text = import 'cli/text.jsonnet';
local ytdl = import 'cli/ytdl.jsonnet';
local tmux = import 'cli/tmux.jsonnet';
local starship = import 'cli/starship.jsonnet';
local lf = import 'cli/lf.jsonnet';
local rustup = import 'cli/rustup.jsonnet';
local rustRepo = import 'rust/repo.jsonnet';
local rustCli = import 'rust/cli.jsonnet';
local yazi = import 'cli/yazi.jsonnet';
local fzf = import 'cli/fzf.jsonnet';
local doppler = import 'cli/doppler.jsonnet';
local neovim = import 'cli/neovim.jsonnet';
local node = import 'cli/node.jsonnet';
local media = import 'media/main.jsonnet';
local desktop = import 'desktop/main.jsonnet';

bash
+ profile
+ scripts
+ git
+ text
+ ytdl
+ tmux
+ starship
+ lf
+ rustup
+ rustRepo
+ rustCli
+ yazi
+ fzf
+ doppler
+ neovim
+ node
+ media
+ desktop


