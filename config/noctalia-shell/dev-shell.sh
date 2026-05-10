#!/usr/bin/env bash
pkill noctalia-shell
QS_CONFIG_PATH=/home/sagar/.dotfiles/config/noctalia-shell noctalia-shell > /tmp/noctalia-dev.log 2>&1 &
echo "Noctalia started from local source in dotfiles. Logs at /tmp/noctalia-dev.log"
