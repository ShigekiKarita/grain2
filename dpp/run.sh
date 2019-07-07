dst=../source/grain/cuda/dpp
mkdir -p $dst
for f in cublas.d cudnn.d driver.d; do
    d++ --include-path /home/karita/work/tools/cudnn-v7.1.3-cuda9.1/cuda/include --include-path /usr/local/cuda/include --keep-d-files ${f}pp main.d
    cp $f ${dst}/${f}i
done
