#!/bin/sh

if [ -z $1 ]; then
   echo "missing arguments"
   echo "usage: nupost-quickstart.sh Project-Name"
   exit
fi

PROJECT_NAME=$1

NUPOST_TEMP_DIR="/home/debian/Public/nupost_template"
MY_PROJECT_DIR="/home/debian/Public/${PROJECT_NAME}"

AUTHOR_NAME=$(cd $MY_PROJECT_DIR; git config --list | grep user.name= | sed "s/user.name=//g")

if [ -z $AUTHOR_NAME ]; then
  echo "No Author Name"
  AUTHOR_NAME='NUUO'
fi

DATE=$(date -R)

echo ".. ${PROJECT_NAME} documentation master file, created by "
echo "   nupost-quickstart on $DATE ."

NUPOST_PRO_NAME='nupost_project'
NUPOST_PRO_NAME_DASH='nupost\\\\_project'
NUPOST_AUR_NAME='nupost_author'
NUPOST_AUR_NAME_DASH='nupost\\\\_author'

echo ${MY_PROJECT_DIR}
echo ${AUTHOR_NAME}

#rm -rv ${MY_PROJECT_DIR}/.conf.py

cp -f ${NUPOST_TEMP_DIR}/conf.py ${MY_PROJECT_DIR}/conf.py
cp -f ${NUPOST_TEMP_DIR}/Makefile ${MY_PROJECT_DIR}/Makefile
cp -rf ${NUPOST_TEMP_DIR}/_build ${MY_PROJECT_DIR}/
cp -rf ${NUPOST_TEMP_DIR}/_templates ${MY_PROJECT_DIR}/
cp -rf ${NUPOST_TEMP_DIR}/_static ${MY_PROJECT_DIR}/
cp -rf ${NUPOST_TEMP_DIR}/_styles ${MY_PROJECT_DIR}/
cp -rf ${NUPOST_TEMP_DIR}/.gitignore ${MY_PROJECT_DIR}/

cd ${MY_PROJECT_DIR}

pwd

sed -i "s/${NUPOST_PRO_NAME}/${PROJECT_NAME}/g" conf.py
sed -i "s/${NUPOST_PRO_NAME_DASH}/${PROJECT_NAME}/g" conf.py
sed -i "s/${NUPOST_AUR_NAME}/${AUTHOR_NAME}/g" conf.py
sed -i "s/${NUPOST_AUR_NAME_DASH}/${AUTHOR_NAME}/g" conf.py

sed -i "s/${NUPOST_PRO_NAME}/${PROJECT_NAME}/g" Makefile
sed -i "s/${NUPOST_PRO_NAME}/${PROJECT_NAME}/g" _build/doctrees/environment.pickle
sed -i "s/${NUPOST_PRO_NAME}/${PROJECT_NAME}/g" _build/doctrees/index.doctree

NUPOST_INDEX_RST="$MY_PROJECT_DIR/index.rst"

if [ -f $NUPOST_INDEX_RST ]; then
  exit
fi

DATE=$(date -R)

echo ".. ${PROJECT_NAME} documentation master file, created by " > $NUPOST_INDEX_RST
echo "   nupost-quickstart on $DATE ." >> $NUPOST_INDEX_RST
echo "" >> $NUPOST_INDEX_RST
echo "Welcome to ${PROJECT_NAME}'s documentation!" >> $NUPOST_INDEX_RST
echo "===========================================" >> $NUPOST_INDEX_RST
echo "" >> $NUPOST_INDEX_RST
echo "Contents:" >> $NUPOST_INDEX_RST
echo "" >> $NUPOST_INDEX_RST
echo ".. toctree::" >> $NUPOST_INDEX_RST
echo "   :maxdepth: 2" >> $NUPOST_INDEX_RST
echo "" >> $NUPOST_INDEX_RST

chown www-data $NUPOST_INDEX_RST
