#! /usr/bin/bash

if pgrep kitty > /dev/null; then
    kill -SIGUSR1 $(pgrep kitty) 2>/dev/null
fi