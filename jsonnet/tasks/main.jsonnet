// Top-level task assembly: one main.jsonnet per area.
local cli = import 'cli/main.jsonnet';
local rust = import 'rust/main.jsonnet';
local media = import 'media/main.jsonnet';
local desktop = import 'desktop/main.jsonnet';

cli + rust + media + desktop
