#!/bin/bash

usage() {
  echo "\$ $0 restart         # restart x server"
}

restart_x_server() {
  DM=$(cat /etc/X11/default-display-manager)
  DN=$(basename ${DM})

  case "$(basename $DN)" in
    "lightdm")
      sudo systemctl restart lightdm
      ;;
    "GDM"|"gdm")
      sudo systemctl restart gdm
      ;;
    "KDM"|"kdm")
      sudo systemctl restart kdm
      ;;
    "MDM"|"mdm")
      sudo systemctl restart mdm
      ;;
    *)
      echo " [INFO ] Could not restart your display manager"
      ;;
  esac
}

case "$1" in
  "restart")
    restart_x_server
    ;;
  *)
    usage
    ;;
esac
