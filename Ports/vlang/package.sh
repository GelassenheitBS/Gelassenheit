#!/usr/bin/env -S bash ../.port_include.sh
port=v
auth_type=sha256
version=weekly.2021.31
files="https://codeload.github.com/vlang/v/tar.gz/refs/tags/$version v-$version.tar.gz b0daf0a2e2cb6d463710952f4d2e8705c17d02a9270355b20861ff3fd5f72563"

build() {
    (
    cd "$workdir"
    make CC=gcc all # local build
    ./v -prod -cc "$CC" -o v2 cmd/v
    )
}

install() {
    # v requires having rw access to the srcdir to rebuild on demand
    # so we just copy that into the default user's home for now.
    # proper system-wide dist builds will be added in vlang later
    mkdir -p "${GELASSENHEIT_INSTALL_ROOT}/home/anon/vlang"
    cp -rf "$workdir"/* "${GELASSENHEIT_INSTALL_ROOT}/home/anon/vlang"
    ln -fs "${GELASSENHEIT_INSTALL_ROOT}/home/anon/vlang/v2" "${GELASSENHEIT_INSTALL_ROOT}/usr/local/bin/v"
}
