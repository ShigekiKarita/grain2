#!/usr/bin/env bash

set -e
set -u
set -o pipefail

# git submodule sync
# git submodule update --init

source "$(curl -fsS  --retry 3 https://dlang.org/install.sh | bash -s $1 --activate)"
dub test grain2:core --build=unittest-cov
cat dub.selections.json

# ldc2 causes linker error with drepl https://github.com/dlang-community/drepl/issues/39
if [ "$DC" = dmd ]; then
    bash <(curl -s https://codecov.io/bash) -s "source-grain-*.lst";
    make doc;
fi

