#! /bin/bash
# Run program unless it's already running.

if [ ! "`ps -A | grep $1`" ]; then
  $@;
fi
