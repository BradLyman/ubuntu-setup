#!/bin/bash

mkdir -p bin

SOURCE=`find ./src -name '*.java'`
TESTS=`find ./tst -name '*.java'`
trap 'kill -TERM $PID' TERM INT
javac -d bin $SOURCE $TESTS&
PID=$!
wait $PID
trap - TERM INT
wait $PID

exec java brlyman.TurboRunner $*
