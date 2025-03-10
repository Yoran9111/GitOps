#!/bin/bash

# Example Build Script for NixOS Configuration

# Check if we are on the correct branch (optional, you can skip this if not needed)
BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
if [[ "$BRANCH_NAME" != "main" ]]; then
  echo "Not on the main branch, skipping build."
  exit 0
fi

# Set up NIX_PATH and ensure the system channels are updated
echo "Updating Nix channels..."
sudo nix-channel --update

# Build the NixOS system configuration (this may be adjusted depending on your needs)
echo "Building NixOS configuration..."
sudo nixos-rebuild switch

# If you are generating other artifacts (e.g., Docker images, compiled binaries, etc.)
# You can place those build steps here
# For example:
# echo "Building Docker image..."
# docker build -t my-image .

# Any other steps to prepare the system
# e.g., testing, linting, etc.
# echo "Running tests..."
# ./run_tests.sh

# You can also archive artifacts if needed
# For example:
# mkdir -p build/
# cp /path/to/compiled/artifact build/

# This script should end without any errors for the build to be successful
