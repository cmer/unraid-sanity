#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
INSTALLED_VERSION=`grep -Po -m 1 '(?<=### Version )\d.\d.\d' /boot/changes.txt`
BASE_INSTALLED_VERSION=`grep -Po -m 1 '(?<=### Version )\d.\d' /boot/changes.txt`.x

if [ -d "$DIR/theme/$INSTALLED_VERSION" ]; then
  THEME_DIR="$DIR/theme/$INSTALLED_VERSION"
elif [ -d "$DIR/theme/$BASE_INSTALLED_VERSION" ]; then
  THEME_DIR="$DIR/theme/$BASE_INSTALLED_VERSION"
else
  echo "Could not find theme for current unRaid version ($INSTALLED_VERSION). Exiting."
  exit 1
fi

cp $THEME_DIR/* /usr/local/emhttp/plugins/dynamix/styles/
echo "Done!"