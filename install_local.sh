#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"

cp $DIR/theme/* /usr/local/emhttp/plugins/dynamix/styles/
echo "Done!"