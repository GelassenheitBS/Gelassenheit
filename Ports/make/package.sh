#!/usr/bin/env -S bash ../.port_include.sh
port=make
version=4.3
useconfigure=true
files="https://ftpmirror.gnu.org/gnu/make/make-${version}.tar.gz make-${version}.tar.gz
https://ftpmirror.gnu.org/gnu/make/make-${version}.tar.gz.sig make-${version}.tar.gz.sig
https://ftpmirror.gnu.org/gnu/gnu-keyring.gpg gnu-keyring.gpg"
auth_type="sig"
auth_opts=("--keyring" "./gnu-keyring.gpg" "make-${version}.tar.gz.sig")
configopts=("--target=${GELASSENHEIT_ARCH}-pc-serenity" "--with-sysroot=/" "--without-guile")
