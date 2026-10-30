// Rust toolchain dependents (cli-rs clone + cargo installs).
// rustup itself lives in cli/ (needed before yazi); this runs after cli/main.
local repo = import 'repo.jsonnet';
local cli = import 'cli.jsonnet';

repo + cli
