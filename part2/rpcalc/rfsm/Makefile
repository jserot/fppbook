# LOCAL PATHS
RFSMC=rfsmc
LIBDIR=/Users/jserot/Dev/ml/rfsm/working/lib
DOT=dot
DOTVIEWER=open -a Graphviz
VCDVIEWER=PATH=/Applications/gtkwave.app/Contents/MacOS:$(PATH) gtkwave-bin
TXTVIEWER=open

DOT_OPTS=-dot_actions_nl -dot_fsm_models
SIM_OPTS=
VHDL_OPTS=-vhdl_time_unit "ns" -vhdl_numeric_std -stop_time 800 -vhdl_trace

CALC_CORE_SRCS=types.fsm calc_core.fsm input_tok.fsm output_tok.fsm tb_core.fsm
C2T2C_SRCS=types.fsm c2t.fsm t2c.fsm input_car.fsm output_car.fsm tb_c2t2c.fsm
CALC_SRCS=types.fsm calc_core.fsm c2t.fsm t2c.fsm input_car.fsm output_car.fsm tb_calc.fsm

all: calc.dot calc.sim

dot: calc.dot
sim: calc.sim

calc.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_calc $(DOT_OPTS) $(CALC_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

calc.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_calc -vcd "./sim/tb_calc.vcd" $(CALC_SRCS)
	$(VCDVIEWER) -f ./sim/tb_calc.vcd -a ./sim/tb_calc.gtkw > /tmp/gtkwave.log 2>&1; echo $$?


# CORE CALC

core.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_core $(DOT_OPTS) $(CALC_CORE_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

core.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_core -vcd "./sim/tb_core.vcd" $(CALC_CORE_SRCS)
	$(VCDVIEWER) -f ./sim/tb_core.vcd -a ./sim/tb_core.gtkw > /tmp/gtkwave.log 2>&1; echo $$?

core.vhdl: core.vhdl.code core.vhdl.sim

core.vhdl.code:
	$(RFSMC) -vhdl -target_dir ./vhdl -lib $(LIBDIR) $(VHDL_OPTS) $(CALC_CORE_SRCS)

core.vhdl.sim: core.vhdl.code
	if [ -d ./vhdl ]; then cd ./vhdl; make; make run; fi
	if [ -d ./vhdl ]; then cd ./vhdl; make view; fi

# C2T2C

c2t2c.dot:
	$(RFSMC) -dot -target_dir ./dot -main tb_c2t $(DOT_OPTS) $(C2T2C_SRCS)
	@$(eval files=`cat ./rfsm.output`)
	@for f in $(files); do \
		if [[ $$f = *.dot ]]; then \
			$(DOTVIEWER) $$f; \
		fi; \
	done

c2t2c.sim:
	$(RFSMC) -sim $(SIM_OPTS) -main tb_c2t -vcd "./sim/tb_c2t2c.vcd" $(C2T2C_SRCS)
	$(VCDVIEWER) -f ./sim/tb_c2t2c.vcd -a ./sim/tb_c2t2c.gtkw > /tmp/gtkwave.log 2>&1; echo $$?

c2t2c.vhdl: c2t2c.vhdl.code c2t2c.vhdl.sim

c2t2c.vhdl.code:
	$(RFSMC) -vhdl -target_dir ./vhdl -lib $(LIBDIR) $(VHDL_OPTS) $(C2T2C_SRCS)

c2t2c.vhdl.sim: c2t2c.vhdl.code
	if [ -d ./vhdl ]; then cd ./vhdl; make; make run; fi
	if [ -d ./vhdl ]; then cd ./vhdl; make view; fi

clean:
	\rm -f dot/*
	\rm -f vhdl/{work*.cf,*.o,tb,*.vcd}
	\rm -f sim/*.vcd
	\rm -f *_deps.dot
	\rm -f *.output *.vcd

realclean: clean
	\rm -f vhdl/{*.vhd,Makefile,*~}
	\rm -f *~
