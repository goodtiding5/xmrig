#!/bin/sh

if ! [ -f /usr/local/etc/config.json ]; then
    echo "Missing config file /usr/local/etc/config.json, QUIT!"
    exit 1;
fi

exec xmrig --config=/usr/local/etc/config.json
