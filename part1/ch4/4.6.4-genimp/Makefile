GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

run-all: genimp.vhd genimp_g.vhd top.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) genimp.vhd genimp_g.vhd 
	$(GHDL) -a $(GHDLOPTS) top.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=200ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

clean:
	\rm -f work*.cf
	\rm -f *.o ./tb
	\rm -f tb.vcd
	\rm -f genimp-all.vhd

realclean: clean
	\rm -f *~
