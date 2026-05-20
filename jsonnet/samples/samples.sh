#!/usr/bin/env bash

echo -e "# 1. Using environment variables\n"
cd env-variables && build.sh && cd - &>/dev/null
