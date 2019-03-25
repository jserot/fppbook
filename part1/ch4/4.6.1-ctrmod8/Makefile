GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

all: run

run: ctrmod8.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) ctrmod8.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

clean:
	\rm -f work*.cf
	\rm -f *.o ./tb
	\rm -f tb.vcd

realclean: clean
	\rm -f *~
