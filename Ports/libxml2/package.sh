#!/usr/bin/env -S bash ../.port_include.sh
port=libxml2
useconfigure="true"
version="2.9.12"
files="ftp://xmlsoft.org/libxml2/libxml2-${version}.tar.gz libxml2-${version}.tar.gz c8d6681e38c56f172892c85ddc0852e1fd4b53b4209e7f4ebf17f7e2eae71d92"
auth_type=sha256
depends=("libiconv" "xz")
configopts=("--prefix=${GELASSENHEIT_INSTALL_ROOT}/usr/local" "--without-python")

install() {
    # Leave out DESTDIR - otherwise the prefix breaks
    run make install

    # Link shared library
    run ${GELASSENHEIT_ARCH}-pc-serenity-gcc -shared -o ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libxml2.so -Wl,-soname,libxml2.so -Wl,--whole-archive ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libxml2.a -Wl,--no-whole-archive -llzma
    rm -f ${GELASSENHEIT_INSTALL_ROOT}/usr/local/lib/libxml2.la
}
