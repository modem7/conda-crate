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
MAINTAINER="modem7"

# Create trap for SIGINT
trap 'kill -TERM $PID' TERM INT
# Create environment
echo "### Creating environment..."
mamba create -v --name $CONDAENV -y anaconda-client conda-build conda-verify numpy boa grayskull python=$PYTHONENV &
PID=$!
wait $PID
trap - TERM INT
wait $PID
EXIT_STATUS=$?

# Initialise Shell
echo "### Initialising shell..."
mamba init bash

# Reload Shell
echo "### Reloading shell..."
source ~/.bashrc

# Activate environment and install additional packages
echo "### Activating environment..."
source activate $CONDAENV
echo ""

# Generating Grayskull package
echo "### Generating Grayskull package..."
cd /data && grayskull pypi --maintainers $MAINTAINER --strict-conda-forge $PYPIPKG && cd $PYPIPKG

# Building Grayskull package
echo "### Building Grayskull package..."
conda mambabuild --python $PYTHONENV --output-folder . .

echo ""
echo "### Built Grayskull package..."
echo "### Use upload script to upload to Anaconda..."
echo ""
date -ud "@$SECONDS" "+Time taken to run script: %H:%M:%S"

exit 0