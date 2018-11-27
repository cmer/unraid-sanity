#!/usr/bin/env bash

cd /tmp
curl -L -O https://github.com/cmer/unraid-sanity/archive/master.zip &> /dev/null
rm -fr /tmp/unraid-sanity-master
unzip -o master.zip

./unraid-sanity-master/install_local.sh
