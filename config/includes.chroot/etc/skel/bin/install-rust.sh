#!/usr/bin/env bash

set -x

curl https://sh.rustup.rs -sSf | sh -s -- --default-toolchain nightly -y
rustup component add rust-src
rustup component add rustfmt-preview
rustup component add clippy-preview
