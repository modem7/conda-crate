#!/usr/bin/env bash

set -e

# Set system variables
echo "### Setting system variables..."
export PUID=$(id -u)
export PGID=$(id -g)

echo "### Initialising Grayskull build..."

exec docker run --rm --name grayskull -e PUID -e PGID -v "$(pwd)":/data -w /data 'condaforge/mambaforge-pypy3' /bin/bash -c "/data/buildgrayskull.sh"

exit 0
