// Ordered concatenation of migrated task modules.
// Add new modules here as they move from ansible/tasks/*.yml → jsonnet.
local bash = import 'cli/bash.jsonnet';
local profile = import 'cli/profile.jsonnet';
local scripts = import 'cli/scripts.jsonnet';
local git = import 'cli/git.jsonnet';
local tmux = import 'cli/tmux.jsonnet';
local gnome = import 'gnome.jsonnet';

bash + profile + scripts + git + tmux + gnome
