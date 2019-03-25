GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

SRCS=counter.vhd shreg.vhd comp.vhd reg.vhd mux.vhd msi.vhd

all: lib

lib: $(SRCS)
	$(GHDL) -a --work=msi --workdir=. $(GHDLOPTS) $(SRCS)

clean:
	\rm -f *.cf *.o

realclean: clean
	\rm -f *~
