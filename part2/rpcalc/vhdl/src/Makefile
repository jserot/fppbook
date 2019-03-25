GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin
QUARTUS=PATH="/cygdrive/c/altera/15.1/quartus/bin64:$(PATH)" quartus

SRCS_CORE=data_types.vhd calc_core.vhd input_tok.vhd output_tok.vhd tb_core.vhd
SRCS_APP=data_types.vhd c2t.vhd t2c.vhd calc_core.vhd rx.vhd tx.vhd uart.vhd calc.vhd display.vhd top.vhd 
SRCS_SIM=data_types.vhd c2t.vhd t2c.vhd calc_core.vhd rx.vhd tx.vhd uart.vhd calc.vhd tb.vhd 

all: sim

core.run: $(SRCS_CORE)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_CORE)
	$(GHDL) -e $(GHDLOPTS) tb_core
	$(GHDL) -r tb_core --stop-time=350ns --wave=tb_core.ghw

core.view: tb_core.ghw
	$(GTKWAVE) -f tb_core.ghw -a tb_core.sav > /tmp/gtkwave.log 2>&1

sim: $(SRCS_SIM)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_SIM)
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r tb --stop-time=1200ns --wave=tb.ghw

view: tb.ghw
	$(GTKWAVE) -f tb.ghw -a tb.sav > /tmp/gtkwave.log 2>&1

check: $(SRCS_APP)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_APP)

clean:
	\rm -f work*.cf
	\rm -f tb *.o
	\rm -f tb.vcd

realclean: clean
	\rm -f *~ vjuart/*~
