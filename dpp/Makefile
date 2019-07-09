CUDA_ROOT := /usr/local/cuda
CUDNN_ROOT := /usr/local/cuda
DPPROOT := build/grain/dpp
DPPSRC := cublas.d cudnn.d cuda_driver.d nvrtc.d cuda_runtime_api.d cl.d

.PHONY: all clean

all: $(addprefix $(DPPROOT)/,$(DPPSRC))

clean:
	rm -rf $(DPPROOT) *.d

$(DPPROOT)/%.d: %.dpp
	mkdir -p $(DPPROOT)
	echo "module grain.dpp.$(basename $<);" > tmp.$(<)
	cat $< >> tmp.$(<)
	d++ --include-path $(CUDA_ROOT)/include --include-path $(CUDNN_ROOT)/include --preprocess-only tmp.$(<)
	mv tmp.$(basename $<).d $@
	rm tmp.$(<)
