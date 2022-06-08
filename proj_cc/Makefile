
THIS=tib_cc

all:	clean hexfile binfile

# ./asl -a -cpu 8080 -L -listradix 8 $(THIS).asm

$(THIS).p:
	@./asl -P -a -cpu 8080 -L -listradix 8 $(THIS).asm
	@od -b -An $(THIS).p > $(THIS).p.dump

hexfile:	$(THIS).p
	@./p2hex	-q $(THIS).p

binfile:	$(THIS).p
	@./p2bin -q $(THIS).p $(THIS).bin
	@od -b -An $(THIS).bin > $(THIS).bin.dump

edit:	$(THIS).asm
	@rvim -n ./$(THIS).asm

clean:
	@rm -f $(THIS).inc
	@rm -f $(THIS).lst

	@rm -f $(THIS).p
	@rm -f $(THIS).p.dump
	@rm -f $(THIS).hex
	@rm -f $(THIS).bin
	@rm -f $(THIS).bin.dump
	@rm -f $(THIS).i

# END.
