DISPIMG     = open -a Preview     # for displaying images
CONVERT     = convert
GTKWAVE     = PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin  # for visualizing .ghw trace files
GHDL=ghdl

MAIN = main

GHDL_ELAB_OPTS = -fno-color-diagnostics 

all: run1 run2

top: top.elab

top.elab:
	$(GHDL) -a $(GHDL_ELAB_OPTS) img.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) msfl.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) conv33_op.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) shift33.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) conv33.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) top.vhd

elab:
	$(GHDL) -a $(GHDL_ELAB_OPTS) pgm_read.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) pgm_write.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) img.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) msfl.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) conv33_op.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) shift33.vhd
	$(GHDL) -a $(GHDL_ELAB_OPTS) conv33.vhd

run1: elab 
	$(GHDL) -a $(GHDL_ELAB_OPTS) tb1.vhd
	$(GHDL) -e $(GHDL_ELAB_OPTS) tb1
	$(GHDL) -r $(GHDL_ELAB_OPTS) tb1 --stop-time=360ns --wave=tb1.ghw

run2: elab 
	$(GHDL) -a $(GHDL_ELAB_OPTS) tb2.vhd
	$(GHDL) -e $(GHDL_ELAB_OPTS) tb2
	$(GHDL) -r $(GHDL_ELAB_OPTS) tb2 --stop-time=210000ns --wave=tb2.ghw

viewtrace1: tb1.ghw
	$(GTKWAVE) -f tb1.ghw -a tb1.sav

viewtrace2: tb2.ghw
	$(GTKWAVE) -f tb2.ghw -a tb2.sav

viewres2:
	$(CONVERT) lena128.pgm /tmp/lena128.tif && $(DISPIMG) /tmp/lena128.tif
	$(CONVERT) res.pgm /tmp/result.tif && $(DISPIMG) /tmp/result.tif

clean:
	\rm -f *.o 
	\rm -f *.vcd 
	\rm -f tb1 tb2

realclean: clean
	\rm -f *.cf *.ghw *.vcd
	\rm -f res*.pgm
	\rm -f *~
	\rm -f comp-ac
