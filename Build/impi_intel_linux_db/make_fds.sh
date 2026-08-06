#!/bin/bash
dir=`pwd`
target=${dir##*/}
echo Building $target
make -j4 VPATH="../../SourceFiles" -f ../makefile $target
