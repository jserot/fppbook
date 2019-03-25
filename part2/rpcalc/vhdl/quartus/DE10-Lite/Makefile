QUARTUS=PATH="/cygdrive/c/altera/15.1/quartus/bin64:$(PATH)" quartus
PROJNAME=top
JTAG="USB-Blaster[USB-0]"

all: build

build: synth fit asm

elab:
	$(QUARTUS)_map --read_settings_files=on --write_settings_files=off $(PROJNAME) -c $(PROJNAME) --analysis_and_elaboration

synth:
	$(QUARTUS)_map --read_settings_files=on --write_settings_files=off $(PROJNAME) -c $(PROJNAME)

fit:
	$(QUARTUS)_fit --read_settings_files=off --write_settings_files=off $(PROJNAME) -c $(PROJNAME)

asm:
	$(QUARTUS)_asm --read_settings_files=off --write_settings_files=off $(PROJNAME) -c $(PROJNAME)

pgm: $(PROJNAME).sof
	$(QUARTUS)_pgm -m jtag -c $(JTAG) -o "p;$(PROJNAME).sof" 

clean:
	$(QUARTUS)_sh --clean $(PROJNAME)

realclean: clean
