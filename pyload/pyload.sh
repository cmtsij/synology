#!/bin/sh

PWD=$(dirname $0)
cd "$PWD"

CONFIGDIR=~/.pyload
EXEC=$PWD/src/pyload/pyLoadCore.py


echo [$EXEC --configdir=$CONFIGDIR $*]
$EXEC --configdir=$CONFIGDIR $*
