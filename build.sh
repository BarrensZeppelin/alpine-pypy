#!/usr/bin/env bash
set -euo pipefail
(cd 3.11/* && docker build -t alp-pypy .)
docker run --rm -v "$(pwd)/build:/tmp" alp-pypy:latest
