#!/bin/bash
git clone https://github.com/emscripten-core/emsdk.git
cd emsdk || exit 1
./emsdk install latest
./emsdk activate latest