#!/usr/bin/env bash

set -e

if [[ -z $PID && -z $BINARY ]]; then
    echo "Either PID or BINARY must be defined."
    exit 1
fi

trap stop SIGTERM SIGINT

stop() {
    echo "Stop watches."
    kill $WAIT_PID
}

while true; do
    inotifywait -e delete,delete_self $FILE &
    WAIT_PID=$!
    wait $WAIT_PID

    if [ ! -z $BINARY ]; then
        PID=$(pidof $BINARY)
    fi

    if [ -z $PID ]; then
        echo "No process pid found, skipping reload."
    else
        echo "Send SIGHUB signal to PID $PID."
        kill -HUP $PID
    fi
done
