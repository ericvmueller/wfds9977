#!/bin/bash
dir=`pwd`
target=${dir##*/}

pick() {
  for c in "$@"; do
    command -v "$c" >/dev/null 2>&1 && { echo "$c"; return 0; }
  done
  return 1
}

MAKE_EXTRA=
case "$target" in
  impi_intel*)
    FCOMPL=$(pick mpiifx mpiifort) || { echo "Error: neither mpiifx nor mpiifort found"; exit 1; }
    CCOMPL=$(pick icx icc gcc) || { echo "Error: neither icx nor icc found"; exit 1; }
    MAKE_EXTRA="FCOMPL=$FCOMPL CCOMPL=$CCOMPL"
    echo "Using FCOMPL=$FCOMPL CCOMPL=$CCOMPL"
    ;;
  intel_linux*|intel_osx*)
    FCOMPL=$(pick ifx ifort) || { echo "Error: neither ifx nor ifort found"; exit 1; }
    CCOMPL=$(pick icx icc gcc) || { echo "Error: neither icx nor icc found"; exit 1; }
    MAKE_EXTRA="FCOMPL=$FCOMPL CCOMPL=$CCOMPL"
    echo "Using FCOMPL=$FCOMPL CCOMPL=$CCOMPL"
    ;;
esac

echo Building $target
make -j4 VPATH="../../SourceFiles" -f ../makefile $MAKE_EXTRA $target
