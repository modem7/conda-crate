#!/usr/bin/env bash

set -e

echo "### Initialising Grayskull build..."

exec docker run --rm --name grayskull -v "$(pwd)":/data 'condaforge/mambaforge-pypy3' /bin/bash -c "/data/buildenv.sh"

exit 0
