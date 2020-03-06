#!/usr/bin/env bash

cd /tmp
wget https://github.com/cmer/unraid-sanity/archive/master.zip
unzip master
cp /tmp/unraid-sanity-master/Sanity* /boot/config/plugins/theme.engine/themes/
rm -fr unraid-sanity-master
rm master.zip
echo "Sanity Theme installed!"

