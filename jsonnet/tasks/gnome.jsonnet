// tasks/gnome.yml

local DconfTask = import 'dconf-task.jsonnet';
local Pkg = import 'package-task.jsonnet';

local keyboardTitle = 'Set keyboard ';
local keyboardPath = '/org/gnome/libgnomekbd/keyboard/';

local KeyboardDconfTask(username, suffix, data) = DconfTask(
  username,
  keyboardTitle + suffix,
  keyboardPath + suffix,
  data
);

local Kbd = KeyboardDconfTask;

local GnomeTask(username) = [
  Pkg('Install dconf requirements', 'python3-psutil'),
  Kbd(username, 'options', "['lv3\tlv3:switch', 'compat\tmisc:typo', 'grp\tgrp:caps_toggle']"),
  Kbd(username, 'layouts', "['us', 'ru']"),
];

GnomeTask('kaineer')
