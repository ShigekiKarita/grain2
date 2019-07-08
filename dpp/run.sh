#!/usr/bin/env bash

dst=../source/grain/cuda/dpp
rm -rf $dst ./*.di ./*.o
mkdir -p $dst
echo "module grain.cuda.dpp;" > $dst/package.d

cuda_root=/usr/local/cuda
cudnn_root=/home/karita/work/tools/cudnn-v7.1.3-cuda9.1/cuda/include
modules="cublas cudnn driver nvrtc"

for f in $modules; do
    echo "processing ${f}.dpp"
    d++ --include-path $cudnn_root/include --include-path $cuda_root/include --keep-d-files "${f}.dpp" main.d
    mv "${f}.d" "${dst}/${f}.di"
    echo "public import grain.cuda.dpp.${f%.*};" >> $dst/package.d
done
rm ./*.o $modules
