#!/usr/bin/env -S bash ../.port_include.sh
port=libgcrypt
version=1.9.2
useconfigure=true
configopts=("--with-libgpg-error-prefix=${GELASSENHEIT_INSTALL_ROOT}/usr/local")
depends=("libgpg-error")
files="https://gnupg.org/ftp/gcrypt/libgcrypt/libgcrypt-${version}.tar.bz2 libgcrypt-${version}.tar.bz2 b2c10d091513b271e47177274607b1ffba3d95b188bbfa8797f948aec9053c5a"
auth_type=sha256

pre_configure() {
    export ac_cv_lib_pthread_pthread_create=no
}

configure() {
    run ./configure --host="${GELASSENHEIT_ARCH}-pc-serenity" --build="$($workdir/build-aux/config.guess)" "${configopts[@]}"
}

install() {
    run make DESTDIR=${GELASSENHEIT_INSTALL_ROOT} "${installopts[@]}" install
    ${CC} -shared -o ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libgcrypt.so -Wl,-soname,libgcrypt.so -Wl,--whole-archive ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libgcrypt.a -Wl,--no-whole-archive -lgpg-error
    rm -f ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libgcrypt.la
}
