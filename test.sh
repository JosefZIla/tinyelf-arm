#!/bin/bash

#run the binary and get the output
RESULT=$(adb shell <<< 'tiny; echo $?; exit')

#get return code from the output
RESULT=$(echo $RESULT | sed 's/[^0-9]*\([0-9]\+\)[^0-9].*$/\1/')

if let "$RESULT==42"; then
  echo "Success - the binary produced correct exit code"
  exit 0
else
  echo "Fail - we were expecting exit code 42, but we got $RESULT."
  exit -1
fi
