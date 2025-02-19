#!/usr/bin/env -S bash ../.port_include.sh
port=SDL2_image
useconfigure=true
version=2.0.5
depends=("SDL2" "libpng" "libjpeg" "libtiff")
files="https://www.libsdl.org/projects/SDL_image/release/SDL2_image-${version}.tar.gz SDL_image-${version}.tar.gz bdd5f6e026682f7d7e1be0b6051b209da2f402a2dd8bd1c4bd9c25ad263108d0"
auth_type=sha256

configure() {
    run ./configure \
        --host="${GELASSENHEIT_ARCH}-pc-serenity" \
        --with-sdl-prefix="${GELASSENHEIT_INSTALL_ROOT}/usr/local" \
        --enable-webp=false --enable-webp-shared=false     \
        LDFLAGS="-lgui -lgfx -lipc -lcore -lm"
}

build() {
    run make -k
}

install() {
    run make -k DESTDIR="${GELASSENHEIT_INSTALL_ROOT}" install
    ${CC} -shared -o ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_image.so -Wl,-soname,libSDL2_image.so -Wl,--whole-archive ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_image.a -Wl,--no-whole-archive -lpng -ljpeg -ltiff
    rm -f ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_image.la
}
