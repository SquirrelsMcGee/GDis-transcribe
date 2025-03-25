#!/bin/bash

set -e

# Check if the CUDA version is passed as an argument
if [ -z "$1" ]; then
  echo "CUDA version is required. Example usage: docker run <image> 11.7"
  exit 1
fi

CUDA_VERSION=$1

echo "Installing core requirements"
pip install fastapi==0.115.5
pip install faster_whisper==1.0.3
pip install uvicorn==0.32.0

# Install the specified PyTorch version with the appropriate CUDA version
echo "Installing PyTorch with CUDA version: $CUDA_VERSION"
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/$CUDA_VERSION

# Shift arguments so the remaining args can be passed to uvicorn
shift

# Run the application
exec uvicorn main:app --host 0.0.0.0 --port 5005 "$@"
