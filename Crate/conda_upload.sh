#!/usr/bin/env bash

set -e

# Set system variables
echo "### Setting system variables..."
SECONDS="0"

# Set user variables
echo "### Setting user variables..."
CONDAENV="grayskull" \
PYTHONENV="3.10" \
PYPIPKG="crate" \
CONDAUSER="modem7"
ANACONDA_API_TOKEN="xxxxx"

# Upload to Anaconda
anaconda upload --user $CONDAUSER noarch/*

echo ""
echo "### Uploaded package"
echo ""
date -ud "@$SECONDS" "+Time taken to run script: %H:%M:%S"

exit 0