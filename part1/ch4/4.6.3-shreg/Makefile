GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics 
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

all: run

run: shreg.vhd shreg_v.vhd shreg_gen.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) shreg.vhd
	$(GHDL) -a $(GHDLOPTS) shreg_v.vhd
	$(GHDL) -a $(GHDLOPTS) shreg_gen.vhd
	$(GHDL) -a $(GHDLOPTS) shreg_v_gen.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r tb --stop-time=120ns --wave=tb.ghw

view: tb.ghw
	$(GTKWAVE) -f tb.ghw -a tb.sav

clean:
	\rm -f work*.cf
	\rm -f *.o ./tb
	\rm -f tb*.vcd tb*.ghw

realclean: clean
	\rm -f *~
