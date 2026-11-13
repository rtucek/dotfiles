#!/usr/bin/env bash

set -Eeuo pipefail

find secrets -name '*.yaml' -type f -print0 | xargs -0 -l sops updatekeys --yes
find secrets -name '*.yaml' -type f -print0 | xargs -0 -l sops rotate --in-place
