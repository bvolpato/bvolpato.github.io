#!/bin/bash

# Default port
PORT=4000

usage() {
    cat <<'EOF'
Start bvolpato.github.io Jekyll site in Docker.

Cleans old Jekyll artifacts, builds local Docker image, then serves on selected port.

Usage:
  ./start-dev.sh [options]

Options:
  --port PORT     Host port for Jekyll server. Default: 4000.
  -h, --help      Show this help.

Available sessions:
  ./start-dev.sh  Build and serve Jekyll site in Docker.
EOF
}

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --port) PORT="$2"; shift ;;
        -h|--help) usage; exit 0 ;;
        *) echo "Unknown parameter passed: $1"; usage; exit 1 ;;
    esac
    shift
done

echo "Cleaning up old build artifacts..."
docker run --rm -v "$(pwd):/srv/jekyll" -w /srv/jekyll ruby:3.3-slim rm -rf _site .jekyll-cache .sass-cache

echo "Building Docker image..."
docker build -t jekyll-site .

echo "Starting server on http://localhost:$PORT"

# Check if running in a TTY
if [ -t 1 ]; then
    TTY_FLAG="-t"
else
    TTY_FLAG=""
fi

docker run --rm -i $TTY_FLAG -p "$PORT:4000" -v "$(pwd):/srv/jekyll" jekyll-site
