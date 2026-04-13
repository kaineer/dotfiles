local PackageTask = import "package-task.jsonnet";
local DconfTask = import "dconf-task.jsonnet";

local GnomeTask(username) = [
  PackageTask("Install dconf requirements", "python3-psutil"),
  DconfTask(username, "Set keyboard options",
    "/org/gnome/libgnomekbd/keyboard/options",
    "['lv3\tlv3:switch', 'compat\tmisc:typo', 'grp\tgrp:caps_toggle']"
  ),
  DconfTask(username, "Set keyboard layouts",
    "/org/gnome/libgnomekbd/keyboard/layouts",
    "['us', 'ru']"
  ),
];

GnomeTask("kaineer")
