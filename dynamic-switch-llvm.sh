#!/bin/sh

SRC_ROOT=$HOME/working/llvm
OBJ_ROOT=$HOME/working/install-llvm

export SRC_ROOT
export OBJ_ROOT

CPATH=$OBJ_ROOT/include:${CPATH}
export CPATH

PATH=$OBJ_ROOT/include:$OBJ_ROOT/lib:$OBJ_ROOT/bin:${PATH}
export PATH

LD_LIBRARY_PATH=$OBJ_ROOT/lib:${LD_LIBRARY_PATH}
if [ -d "/usr/lib/nvidia-cuda-toolkit/libdevice" ] ; then
	LD_LIBRARY_PATH=/usr/lib/nvidia-cuda-toolkit/libdevice:${LD_LIBRARY_PATH}
fi
export LD_LIBRARY_PATH

LIBRARY_PATH=$OBJ_ROOT/lib:${LIBRARY_PATH}
if [ -d "/usr/lib/nvidia-cuda-toolkit/libdevice" ] ; then
    LIBRARY_PATH=/usr/lib/nvidia-cuda-toolkit/libdevice:${LIBRARY_PATH}
fi
export LIBRARY_PATH
