#!/usr/bin/bash

cd /tmp
curl -L -O https://github.com/cmer/unraid-sanity/archive/master.zip &> /dev/null
rm -fr /tmp/unraid-sanity-master
unzip -o master.zip
cp unraid-sanity-master/theme/* /usr/local/emhttp/plugins/dynamix/styles/
echo "Done!"