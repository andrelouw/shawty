#!/bin/sh

DIR="${BASH_SOURCE%/*}"

if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which mint which swiftlint> /dev/null; then
  mint run swiftlint lint  --config $DIR/../.swiftlint.yml
else
  echo "warning: Swiftlint not installed with Mint, Linting won't work. Install using 'make bootstrap'. "
fi
