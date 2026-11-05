local DconfTask = import 'dconf-task.jsonnet';
local Pkg = import 'package-task.jsonnet';

local keyboardTitle = 'Set keyboard ';
local keyboardPath = '/org/gnome/libgnomekbd/keyboard/';

local Kbd(suffix, data) = DconfTask(
  keyboardTitle + suffix,
  keyboardPath + suffix,
  data,
);

[
  Pkg('Install dconf requirements', 'python3-psutil'),
  Kbd('options', "['lv3\tlv3:switch', 'compat\tmisc:typo', 'grp\tgrp:caps_toggle']"),
  Kbd('layouts', "['us', 'ru']"),
]
