GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin
QUARTUS=PATH="/cygdrive/c/altera/15.1/quartus/bin64:$(PATH)" quartus

TOP_SRCS=counter.vhd freqdiv.vhd top.vhd
TB_SRCS=$(TOP_SRCS) tb.vhd

all: run

run: $(TB_SRCS)
	$(GHDL) -a $(GHDLOPTS) $(TB_SRCS)
	$(GHDL) -e tb
	$(GHDL) -r tb --stop-time=200ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav


quartus.elab:
	(cd quartus; $(QUARTUS)_map --read_settings_files=on --write_settings_files=off top -c top --analysis_and_elaboration)

quartus.synth:
	(cd quartus; $(QUARTUS)_map --read_settings_files=on --write_settings_files=off top -c top)

quartus: quartus.synth quartus.fit quartus.asm

quartus.fit:
	(cd quartus; $(QUARTUS)_fit --read_settings_files=off --write_settings_files=off top -c top)

quartus.asm:
	(cd quartus; $(QUARTUS)_asm --read_settings_files=off --write_settings_files=off top -c top)

quartus.pgm: ./quartus/output_files/top.sof
	(cd ./quartus/output_files; $(QUARTUS)_pgm -m jtag -c USB-Blaster[USB-0] -o "p;top.sof" )

clean:
	\rm -f work*.cf
	\rm -f tb *.o
	\rm -f tb.vcd

realclean: clean
	\rm -f *~
