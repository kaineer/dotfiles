// CLI tools and shell setup (order matters: profile/bin before dependents).
local bash = import 'bash.jsonnet';
local profile = import 'profile.jsonnet';
local scripts = import 'scripts.jsonnet';
local git = import 'git.jsonnet';
local text = import 'text.jsonnet';
local ytdl = import 'ytdl.jsonnet';
local tmux = import 'tmux.jsonnet';
local starship = import 'starship.jsonnet';
local lf = import 'lf.jsonnet';
local rustup = import 'rustup.jsonnet';
local yazi = import 'yazi.jsonnet';
local fzf = import 'fzf.jsonnet';
local doppler = import 'doppler.jsonnet';
local neovim = import 'neovim.jsonnet';
local node = import 'node.jsonnet';

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
+ yazi
+ fzf
+ doppler
+ neovim
+ node
