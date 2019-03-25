GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

all: run

run: dctrmod4.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) dctrmod4.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=200ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

clean:
	\rm -f work*.cf *.o tb
	\rm -f tb.vcd

realclean: clean
	\rm -f *~
