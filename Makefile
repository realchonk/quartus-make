
NAME = test
Q = /opt/quartus/quartus/bin/
CABLE = $(shell $(Q)/jtagconfig -n | head -n1 | grep -o '^[0-9]\+')

all: compile upload

compile:
	$(Q)/quartus_map --read_settings_files=on --write_settings_files=off $(NAME) -c $(NAME)
	$(Q)/quartus_fit --read_settings_files=on --write_settings_files=off $(NAME) -c $(NAME)
	$(Q)/quartus_asm --read_settings_files=on --write_settings_files=off $(NAME) -c $(NAME)
	$(Q)/quartus_sta $(NAME) -c $(NAME)

upload:
	$(Q)/quartus_pgm -c $(CABLE) $(NAME).cdf

clean:
	rm -rf db incremental_db output_files $(NAME).qws qar_info.json

.PHONY: all compile upload clean
