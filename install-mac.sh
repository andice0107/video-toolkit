#!/usr/bin/env bash
set -e
command -v brew >/dev/null || { echo "請先安裝 Homebrew: https://brew.sh"; exit 1; }
command -v blender >/dev/null || brew install --cask blender@lts
command -v ffmpeg  >/dev/null || brew install ffmpeg
command -v node    >/dev/null || brew install node
blender -b --version | head -1
ffmpeg -version | head -1
node -v
