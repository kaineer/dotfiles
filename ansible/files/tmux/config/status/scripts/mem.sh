#!/usr/bin/zsh

MEM=$(free -h | awk '/Mem/{print $4}')

echo -n "#[bg=colour20,fg=colour15] $MEM #[default]"
