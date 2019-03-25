GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

SRCS_ADD1=addbcd1.vhd tb1.vhd
SRCS_ADD4=addbcd1.vhd addbcd4.vhd tb4.vhd
SRCS_ADDG=addbcd1.vhd addbcd_g.vhd tb_g.vhd

all: run1 run4 rung

run1: $(SRCS_ADD1)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_ADD1)
	$(GHDL) -e $(GHDLOPTS) tb1
	$(GHDL) -r $(GHDLOPTS) tb1 --vcd=tb1.vcd

view1: tb1.vcd
	$(GTKWAVE) -f tb1.vcd -a tb1.sav

run4: $(SRCS_ADD4)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_ADD4)
	$(GHDL) -e $(GHDLOPTS) tb4
	$(GHDL) -r $(GHDLOPTS) tb4 --vcd=tb4.vcd

view4: tb4.vcd
	$(GTKWAVE) -f tb4.vcd -a tb4.sav

rung: $(SRCS_ADDG)
	$(GHDL) -a $(GHDLOPTS) $(SRCS_ADDG)
	$(GHDL) -e $(GHDLOPTS) tb_g
	$(GHDL) -r $(GHDLOPTS) tb_g --vcd=tb_g.vcd

viewg: tb_g.vcd
	$(GTKWAVE) -f tb_g.vcd -a tb_g.sav

clean:
	\rm -f work*.cf
	\rm -f *.o ./tb1 ./tb4 ./tb_g
	\rm -f tb1.vcd tb4.vcd tb_g.vcd

realclean: clean
	\rm -f *~
