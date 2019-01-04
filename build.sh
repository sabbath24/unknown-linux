#!/usr/bin/env bash

set -ex

CFG_DIST_CODE="UNKNOWN"
CFG_MIRROR="http://deb.debian.org/debian"
CFG_MIRROR_SECURITY="http://security.debian.org"

apt-get update && apt-get install --no-install-recommends --yes \
    cpio \
    live-build \

lb config \
    --architectures "amd64" \
    --archive-areas "main contrib non-free" \
    --binary-images "iso-hybrid" \
    --bootappend-live "boot=live components splash nottyautologin nonetworking" \
    --bootloaders "grub-efi" \
    --cache "false" \
    --checksums "sha512" \
    --debian-installer "false" \
    --debootstrap-options "--include=apt-transport-https,software-properties-common,gnupg" \
    --distribution "${CFG_DIST_CODE}" \
    --grub-splash "${CFG_DIST_CODE}" \
    --ignore-system-defaults \
    --image-name "unknown-linux-live" \
    --iso-application "${CFG_DIST_CODE}" \
    --iso-preparer "${CFG_DIST_CODE}" \
    --iso-publisher "${CFG_DIST_CODE}" \
    --iso-volume "${CFG_DIST_CODE}" \
    --linux-flavours "amd64" \
    --memtest "none" \
    --mirror-binary "${CFG_MIRROR}" \
    --mirror-binary-security "${CFG_MIRROR_SECURITY}" \
    --mirror-bootstrap "${CFG_MIRROR}" \
    --mirror-chroot-security "${CFG_MIRROR_SECURITY}" \
    --parent-archive-areas "main contrib non-free" \
    --parent-distribution "testing" \
    --parent-mirror-binary "${CFG_MIRROR}" \
    --parent-mirror-binary-security "${CFG_MIRROR_SECURITY}" \
    --parent-mirror-bootstrap "${CFG_MIRROR}" \
    --parent-mirror-chroot-security "${CFG_MIRROR_SECURITY}" \
    --verbose

lb build
