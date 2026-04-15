#!/usr/bin/env bash

jsonnet \
  --ext-str USER \
  --ext-str "HOSTNAME=$(hostname)" \
  config.jsonnet
