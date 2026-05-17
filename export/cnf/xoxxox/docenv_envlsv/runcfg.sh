#!/bin/bash

cntprj="${1}"

cd ${cntprj} && \
cmake -B build -G Ninja -DCMAKE_BUILD_TYPE=Release -DGGML_BLAS=ON -DGGML_BLAS_VENDOR=OpenBLAS && \
cmake --build build --config Release --target llama-server -j1 && \
ln -s ${cntprj}/build/bin/llama-server /usr/local/bin/llama-server
