// Top-level task assembly: one main.jsonnet per area → {system, user}.
local S = import 'split.jsonnet';
local cli = import 'cli/main.jsonnet';
local rust = import 'rust/main.jsonnet';
local media = import 'media/main.jsonnet';
local desktop = import 'desktop/main.jsonnet';

S.Merge([cli, rust, media, desktop])
