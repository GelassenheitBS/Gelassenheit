#!/usr/bin/env -S bash ../.port_include.sh
port=SDL2_mixer
version=2.0.4
useconfigure=true
files="https://www.libsdl.org/projects/SDL_mixer/release/SDL2_mixer-${version}.tar.gz SDL2_mixer-${version}.tar.gz b4cf5a382c061cd75081cf246c2aa2f9df8db04bdda8dcdc6b6cca55bede2419"
auth_type=sha256
depends=("SDL2" "libvorbis")

configure() {
    run ./configure \
        --host="${GELASSENHEIT_ARCH}-pc-serenity" \
        --with-sdl-prefix="${GELASSENHEIT_INSTALL_ROOT}/usr/local" \
        --enable-music-opus=false --enable-music-opus-shared=false \
        --enable-music-mod-modplug=false --enable-music-mod-modplug-shared=false \
        EXTRA_LDFLAGS="-lgui -lgfx -lipc -lcore -lcompression"
}

build() {
    run make -k
}

install() {
    run make -k DESTDIR="${GELASSENHEIT_INSTALL_ROOT}" install
    ${CC} -shared -o ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.so -Wl,-soname,libSDL2_mixer.so -Wl,--whole-archive ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.a -Wl,--no-whole-archive -Wl,--no-as-needed -lvorbis -lvorbisfile
    rm -f ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libSDL2_mixer.la
}
