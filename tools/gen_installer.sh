#!/bin/sh

FILE=$2
rm $FILE
zip $FILE installer.sh README \
  bin/**/*.*
