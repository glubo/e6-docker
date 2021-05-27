#!/bin/bash
set -e

if [[ "$1" == 'minecraft' ]]; then
    echo "Starting minecraft"

     echo "n\nn" | exec bash start-automated-server.sh
fi

echo "Executing $@"
exec "$@"
