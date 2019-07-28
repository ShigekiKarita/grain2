DPPROOT := build/grain/dpp
CL := /usr/include/CL/cl.h
CUSRC := cublas.d cudnn.d cuda_driver.d nvrtc.d cuda_runtime_api.d
CLSRC := cl.d cl_enum.d

.PHONY: all clean cuda cl

all: cuda cl

clean:
	rm -rf $(DPPROOT) *.d

cuda: $(addprefix $(DPPROOT)/,$(CUSRC))

cl: $(addprefix $(DPPROOT)/,$(CLSRC))

# $(DPPROOT)/cl.d: cl.dpp
# 	mkdir -p $(DPPROOT)
# 	d++ --preprocess-only $<
# 	sed -i "s/c_long8/long2/g" cl.d
# 	sed -i "s/c_ulong8/ulong2/g" cl.d
# 	echo "module grain.dpp.$(basename $<);" > $@
# 	cat cl.d >> $@
# 	rm cl.d

$(DPPROOT)/cl_enum.d:
	mkdir -p $(DPPROOT)
	echo "module grain.dpp.cl_enum;" > $@
	grep "#define CL_" $(CL) | awk -f preprocess.awk >> $@

$(DPPROOT)/%.d: %.dpp
	mkdir -p $(DPPROOT)
	echo "module grain.dpp.$(basename $<);" > tmp.$(<)
	cat $< >> tmp.$(<)
	d++ --preprocess-only tmp.$(<)
	mv tmp.$(basename $<).d $@
	rm tmp.$(<)
