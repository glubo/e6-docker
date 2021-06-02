#!/bin/bash
set -e

if [[ "$1" == 'minecraft' ]]; then
    if [[ "$EULA" == "TRUE" ]]; then
        echo 'eula=true'>eula.txt
    fi;
    echo "Starting minecraft"

    echo "n\nn" | exec bash start-automated-server.sh
fi

echo "Executing $@"
exec "$@"
