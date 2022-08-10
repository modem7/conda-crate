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
MAINTAINER="modem7" \
BUILDDIR="/data/build_dir"

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

# Creating Directories if they don't exist
echo "### Creating directories..."
mkdir -p $BUILDDIR && cd $BUILDDIR

# Generating Grayskull package
echo "### Generating Grayskull package..."
grayskull pypi --maintainers $MAINTAINER --strict-conda-forge $PYPIPKG && cd $PYPIPKG

# Building Grayskull package
echo "### Building Grayskull package..."
PKGLOC=$(conda mambabuild --no-anaconda-upload --python $PYTHONENV --output --output-folder . . | tee /dev/console | grep \/data\/build_dir\/.*tar.bz2)

# Setting permissions for built package
chown -R $PUID:$PGID $BUILDDIR

echo ""
echo "### Built Grayskull package. Located in $PKGLOC..."
echo "### Use upload script to upload to Anaconda..."
echo ""
date -ud "@$SECONDS" "+Time taken to run script: %H:%M:%S"

exit 0