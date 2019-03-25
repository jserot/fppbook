# LOCAL PATHS
RFSMC=rfsmc
DOT=dot
DOTVIEWER=open -a Graphviz
VCDVIEWER=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin
TXTVIEWER=open

DOT_OPTS=-dot_actions_nl -dot_fsm_models
SIM_OPTS=

TX_SRCS=tx.fsm tb_tx.fsm
RX_SRCS=rx.fsm tb_rx.fsm
RXTX_SRCS=tx.fsm rx.fsm tb_rxtx.fsm

all: rxtx.dot rxtx.sim

dot: rxtx.dot
sim: rxtx.sim

# TX

tx.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_tx $(DOT_OPTS) $(TX_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

tx.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_tx -vcd "./sim/tb_tx.vcd" $(TX_SRCS)
	$(VCDVIEWER) -f ./sim/tb_tx.vcd -a ./sim/tb_tx.gtkw > /tmp/gtkwave.log 2>&1; echo $$?

# RX

rx.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_rx $(DOT_OPTS) $(RX_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

rx.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_rx -vcd "./sim/tb_rx.vcd" $(RX_SRCS)
	$(VCDVIEWER) -f ./sim/tb_rx.vcd -a ./sim/tb_rx.gtkw > /tmp/gtkwave.log 2>&1; echo $$?


# RXTX

rxtx.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_rxtx $(DOT_OPTS) $(RXTX_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

rxtx.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_rxtx -vcd "./sim/tb_rxtx.vcd" $(RXTX_SRCS)
	$(VCDVIEWER) -f ./sim/tb_rxtx.vcd -a ./sim/tb_rxtx.gtkw > /tmp/gtkwave.log 2>&1; echo $$?


clean:
	\rm -f dot/*
	\rm -f sim/*.vcd
	\rm -f *_deps.dot
	\rm -f *.output *.vcd

realclean: clean
	\rm -f *~
