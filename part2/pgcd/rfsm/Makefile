APP=pgcd
RFSMC=rfsmc
DOT_OPTS=-dot_fsm_models
SIM_OPTS=

.PHONY: dot sim clean clobber test

VCDVIEWER=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin
DOTVIEWER=open -a Graphviz
TXTVIEWER=open

.phony: dot sim vhdl clean clobber test

dot:
	$(RFSMC) -dot -target_dir ./dot $(DOT_OPTS) $(APP).fsm
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

all: dot sim

sim.run:
	$(RFSMC) $(SIM_OPTS) -sim -vcd "./sim/$(APP).vcd" $(APP).fsm

sim.view:
	$(VCDVIEWER) -f ./sim/$(APP).vcd -a ./sim/$(APP).gtkw > /tmp/gtkwave.log 2>&1; echo $$?

sim: sim.run sim.view

clean:
	\rm -f dot/*
	\rm -f sim/*.vcd
	\rm -f *_deps.dot
	\rm -f *.output *.vcd

realclean: clean
	\rm -f *~
