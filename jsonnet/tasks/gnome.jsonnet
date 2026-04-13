// tasks/gnome.yml

local DconfTask = import 'dconf-task.jsonnet';
local PackageTask = import 'package-task.jsonnet';

local keyboardTitle = 'Set keyboard ';
local keyboardPath = '/org/gnome/libgnomekbd/keyboard/';

local KeyboardDconfTask(username, suffix, data) = DconfTask(
  username,
  keyboardTitle + suffix,
  keyboardPath + suffix,
  data
);

local GnomeTask(username) = [
  PackageTask('Install dconf requirements', 'python3-psutil'),
  KeyboardDconfTask(username, 'options', "['lv3\tlv3:switch', 'compat\tmisc:typo', 'grp\tgrp:caps_toggle']"),
  KeyboardDconfTask(username, 'layouts', "['us', 'ru']"),
];

GnomeTask('kaineer')
