#!/bin/bash

# CUIDADO: nao modifique os parametros abaixo
NX=800
NZ=400
FREQ=100
CONFIG=CONFIG_IN_TEST1
SIM_TIME=400

# TODO modifique a compilacao do programa abaixo se precisar
g++ -Wall -fopenmp -fopenmp-simd -O3 -D_NX=$NX -D_NZ=$NZ -D_SIM_TIME=$SIM_TIME -D_OUT_FREQ=$FREQ -D_IN_CONFIG=$CONFIG -o miniCFD_omp miniCFD_omp.cpp 
g++ -Wall -D_NX=$NX -D_NZ=$NZ -D_SIM_TIME=$SIM_TIME -D_OUT_FREQ=$FREQ -D_IN_CONFIG=$CONFIG -o miniCFD miniCFD_serial.cpp 
#pgc++ -O4 -Minfo=all -ta=tesla -mp -acc -D_NX=$NX -D_NZ=$NZ -D_SIM_TIME=$SIM_TIME -D_OUT_FREQ=$FREQ -D_IN_CONFIG=$CONFIG -o miniCFD_acc miniCFD_acc.cpp
pgc++ -O4 -Minfo -Mipa=inline:reshape -fpic -Mcache_align -fast -acc -ta=tesla:cc70,fastmath -Wall -D_NX=$NX -D_NZ=$NZ -D_SIM_TIME=$SIM_TIME -D_OUT_FREQ=$FREQ -D_IN_CONFIG=$CONFIG -o oacc miniCFD_oacc.cpp
