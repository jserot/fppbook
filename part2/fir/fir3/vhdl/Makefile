GHDL=ghdl
GHDLOPTS 	= -P../lib/vhdl
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

all: run

run: fir3.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) fir3.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=110ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

html: fir3.vhd tb.vhd
	$(GHDL) --xref-html fir3.vhd tb.vhd

clean:
	\rm -f work*.cf *.o tb
	\rm -f tb.vcd

realclean: clean
	\rm -f *~
	\rm -rf html
