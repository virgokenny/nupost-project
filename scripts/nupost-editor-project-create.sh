#!/bin/sh

if [ -z $1 ]; then
   echo "missing arguments"
   echo "usage: *.sh Project-Name"
   exit
fi

PROJECT_NAME=$1

MY_PROJECT_DIR="/home/debian/Public/${PROJECT_NAME}"
NUPOST_EDITOR_DIR="/home/debian/Public/nupost-browser/private/repo/${PROJECT_NAME}"

if [ -f $NUPOST_EDITOR_DIR ]; then
   echo "File exist"
   exit
fi

ln -s $MY_PROJECT_DIR $NUPOST_EDITOR_DIR

cd $MY_PROJECT_DIR
find . -name "*.rst" -exec chown www-data {} \;

