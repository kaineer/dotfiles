// Import
// TODO: move up dir to packages.jsonnet
local gui = import "gui.jsonnet";
// local awesome = import "awesome.jsonnet";
local system = import "system.jsonnet";
local obsolete = import "obsolete.jsonnet";

// Packages config
gui + system + obsolete
