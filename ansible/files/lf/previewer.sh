#!/bin/bash

preview_code() {
  if [[ "$(which bat)" == "" ]]; then
    cat $1 | head -n $2
  else
    bat $1 -p -f -r ":$2"
  fi
}

preview_video() {
  if [[ "$(which mediainfo)" == "" ]]; then
    echo -e "Some video file.\n\nInstall «mediainfo» to see more"
  else
    mediainfo "$1" | head -n $2
  fi
}

preview_image() {
  /bin/img2txt "$1" | head -n $2
  # if [[ "$(which img2txt)" != "" ]]; then
  #   img2txt "$1" | head -n $2
  # elif [[ "$(which mediainfo)" != "" ]]; then
  #   mediainfo "$1" | head -n $2
  # else
  #   echo -e "Some video file.\n\nInstall «mediainfo» to see more"
  # fi
}

preview_binary() {
  echo -e "Scary binary file.\n\nIts type is «$FILETYPE»"
}

FILENAME="$1"
TERMINAL_HEIGHT="$2"

if [ -f "$1" ]; then
  FILETYPE=$(eval "file --mime-type ${FILENAME// /\\\ } -b")
  case $FILETYPE in
  text/* | application/json)
    preview_code "$FILENAME" $TERMINAL_HEIGHT
    ;;
  image/*)
    preview_image "$FILENAME" $TERMINAL_HEIGHT
    ;;
  video/*)
    preview_video "$FILENAME" $TERMINAL_HEIGHT
    ;;
  *)
    preview_binary "$FILENAME" $TERMINAL_HEIGHT
    ;;
  esac
else
  exa -l $*
fi
