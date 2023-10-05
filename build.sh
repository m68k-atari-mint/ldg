#!/bin/bash -eux
# -e: Exit immediately if a command exits with a non-zero status.
# -u: Treat unset variables as an error when substituting.
# -x: Display expanded script commands.

# use as build.sh <dest dir> (i.e. the files will be installed to <dest dir>/<sys-root>/usr)

export PREFIX="$($TOOL_PREFIX-gcc -print-sysroot)/usr"

cd src/devel

make -f gcc.mak CC=${TOOL_PREFIX}-gcc AR=${TOOL_PREFIX}-ar
make -f gccm68020-60.mak CC=${TOOL_PREFIX}-gcc AR=${TOOL_PREFIX}-ar
make -f gccm5475.mak CC=${TOOL_PREFIX}-gcc AR=${TOOL_PREFIX}-ar

mkdir -p "${1}${PREFIX}/lib"
cp -ra ../../lib/gcc/* "${1}${PREFIX}/lib"
cp -ra ../../include "${1}${PREFIX}"
