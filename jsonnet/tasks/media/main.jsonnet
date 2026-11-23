// Terminal / non-GUI media tools.
local S = import 'split.jsonnet';
local cleanup = import 'cleanup-rmpc-mpd.jsonnet';
local mocp = import 'mocp.jsonnet';

S.Merge([cleanup, mocp])
