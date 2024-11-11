#!/usr/bin/zsh

IP=$(ifconfig | grep wlo1 -A1 | grep --color=never inet | sed -e's/  */ /g' | cut -f3 -d" ")

FIRST_BITE=$(echo $IP | cut -f1 -d".")

IP_COLOR='colour202'

if [[ "$FIRST_BITE" == "192" ]]; then
  IP_COLOR='colour64'
elif [[ "$IP" == "" ]]; then
  IP="127.0.0.1"
  IP_COLOR='colour15'
fi

echo -n "#[bg=$IP_COLOR,fg=colour232] $IP #[default]"

IP_COLOR=
IP=

FIRST_BITE=
