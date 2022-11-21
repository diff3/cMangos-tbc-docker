#!/bin/sh


cmake .. -DCMAKE_INSTALL_PREFIX=/opt/server -DBUILD_EXTRACTORS=ON -DPCH=1 -DDEBUG=0 -DBUILD_PLAYERBOT=ON
make clean
make -j 8
make install
