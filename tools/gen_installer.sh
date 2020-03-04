#!/bin/sh

# args:
# 1: zrythm version
# 2: installer zip filename

FILE=$2
rm $FILE
zip $FILE installer.sh README \
  bin/**/*.* bin/**/**/* bin/**/**/**/*
