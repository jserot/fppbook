GHDL=ghdl
GHDLOPTS=-fno-color-diagnostics -P./lib
GTKWAVE=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin

RTL_SRCS=data_types.vhd \
	./rtl/tx.vhd ./rtl/rx.vhd \
	uart.vhd input.vhd output.vhd tb.vhd
POPC_SRCS=data_types.vhd \
	./popc/tx_po.vhd ./popc/tx_pc.vhd ./popc/tx.vhd \
	./popc/rx_po.vhd ./popc/rx_pc.vhd ./popc/rx.vhd \
	uart.vhd input.vhd output.vhd tb.vhd

.PHONY:
.PHONY: rtl popc lib

rtl: $(RTL_SRCS)
	$(GHDL) -a $(GHDLOPTS) $(RTL_SRCS)
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=1800ns --vcd=tb.vcd

lib:
	(cd lib; make)

popc: lib $(POPOC_SRCS)
	$(GHDL) -a $(GHDLOPTS) $(POPC_SRCS)
	$(GHDL) -e $(GHDLOPTS) tb
	$(GHDL) -r $(GHDLOPTS) tb --stop-time=1800ns --vcd=tb.vcd

view: tb.vcd
	$(GTKWAVE) -f tb.vcd -a tb.sav

clean:
	\rm -f work*.cf *.o tb
	\rm -f tb.vcd
	(cd lib; make clean)

realclean: clean
	\rm -f *~
	\rm -rf html
	(cd lib; make realclean)
