#!/usr/bin/with-contenv bash

# if the web root is empty, activate sample index page
if [[ "$(ls -A /src)" ]]; then
    echo "============> Using existing web content"
else
    echo "============> Generating sample index page"
    cp /defaults/index.html /src
    chown -R ash:ash /src
fi
