#!/bin/bash

set -e

echo "🚀 Starting setup..."

# Check if the CUDA version is passed as an argument
if [ -z "$1" ]; then
  echo "CUDA version is required. Example usage: docker run <image> cu118"
  exit 1
fi

CUDA_VERSION=$1

echo "🔧 Installing system tools..."
pip install --no-cache-dir python-multipart pydantic fastapi uvicorn faster-whisper
# Install the specified PyTorch version with the appropriate CUDA version
echo "Installing PyTorch with CUDA version: $CUDA_VERSION"

# For CUDA 12.4, install without the --index-url flag
if [ "$CUDA_VERSION" = "cu124" ]; then
  pip install torch torchvision torchaudio
else
  pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/$CUDA_VERSION
fi

# Shift arguments so the remaining args can be passed to uvicorn
shift

# Run the application
exec uvicorn main:app --host 0.0.0.0 --port 5005 "$@"
