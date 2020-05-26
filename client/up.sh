#!/bin/bash -Eeu

readonly MY_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

export RUBYOPT='-W2'

rackup             \
  --env production \
  --port 5028      \
  --server puma    \
  --warn           \
    ${MY_DIR}/config.ru
