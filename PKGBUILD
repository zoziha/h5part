# Maintainer: ZUO Zhihua <zuo.zhihua@qq.com>

_realname=h5part
pkgbase=mingw-w64-${_realname}
pkgname="${MINGW_PACKAGE_PREFIX}-${_realname}"
pkgver=1.2.20230625
pkgrel=1
arch=('any')
mingw_arch=('mingw32' 'mingw64' 'ucrt64')
pkgdesc="The simple testing framework (mingw-w64)"
url="https://gitee.com/zoziha/h5part"
license=('spdx:MIT')
depends=("${MINGW_PACKAGE_PREFIX}-gcc-libs"
         $([[ ${MINGW_PACKAGE_PREFIX} == *-clang-* ]] || echo "${MINGW_PACKAGE_PREFIX}-gcc-libgfortran")
         "${MINGW_PACKAGE_PREFIX}-hdf5")
makedepends=("${MINGW_PACKAGE_PREFIX}-fc"
             "${MINGW_PACKAGE_PREFIX}-meson"
             "${MINGW_PACKAGE_PREFIX}-ninja"
             "${MINGW_PACKAGE_PREFIX}-hdf5")
source=(${_realname}-${pkgver}.zip::"${url}/repository/archive/main.zip")
sha256sums=('b1ec8ab944d51623f91408401f726dec07c1dc87c39141082973dc0fe8acc343')

build() {
    mkdir -p build-${MSYSTEM} && cd build-${MSYSTEM}

    MSYS2_ARG_CONV_EXCL="--prefix" \
      meson setup \
        --prefix="${MINGW_PREFIX}" \
        --buildtype=release \
        ../${_realname}-main

    meson compile
}

package() {
    cd "${srcdir}/build-${MSYSTEM}"

    DESTDIR="${pkgdir}" meson install
}
