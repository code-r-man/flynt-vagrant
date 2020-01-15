#!/bin/bash

# SETTINGS
# Archive name
ARCHIVE_TEMP=".temp_download.zip"

# Package original name
STACK_NAME=vccw

# Get project name
PROJECT_NAME=$(basename `pwd`)
readonly PROJECT_NAME
PROJECT_NAME_CAP="$(echo "$PROJECT_NAME" | sed 's/.*/\u&/')"
PROJECT_NAME_SPACED=${PROJECT_NAME_CAP/"-"/" "}

# TEMP
rm -rf $PROJECT_NAME

# PROJECT URL
PROJECT_URL="$PROJECT_NAME.wordpress"
readonly PROJECT_URL

#MAIN
# Download boilerplate archive
wget https://github.com/vccw-team/vccw/releases/download/3.21.1/vccw-3.21.1.zip -O $ARCHIVE_TEMP &&

# Unzip the archive and clean it
unzip -o $ARCHIVE_TEMP && rm $ARCHIVE_TEMP &&

# Rename root project
echo "mv $STACK_NAME $PROJECT_NAME" &&
mv $STACK_NAME $PROJECT_NAME &&

# Move to created folder
echo "cd $PROJECT_NAME" &&
cd $PROJECT_NAME &&

# Copy settings files
echo "cp provision/default.yml site.yml" &&
cp provision/default.yml site.yml

# Replace values in a file
sed -i "s/vccw.test/$PROJECT_URL/g" site.yml &&
sed -i "s/Hello VCCW./$PROJECT_NAME_SPACED/g" site.yml &&
sed -i "s/Welcome to the VCCW/$PROJECT_NAME_SPACED/g" site.yml &&
echo ===========================================================================
echo Done.

