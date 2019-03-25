GHDL=ghdl
GHDLOPTS=# -P../lib/vhdl
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

all: run

run: pgcd.vhd tb.vhd
	$(GHDL) -a $(GHDLOPTS) pgcd.vhd
	$(GHDL) -a $(GHDLOPTS) tb.vhd
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=450ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

html: pgcd.vhd tb.vhd
	$(GHDL) --xref-html pgcd.vhd tb.vhd

clean:
	\rm -f work*.cf *.o tb
	\rm -f tb.vcd

realclean: clean
	\rm -f *~
	\rm -rf html
