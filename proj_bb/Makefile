
THIS=tib_a

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

clean:
	@rm -f tib_a.inc
	@rm -f tib_a.lst
	@rm -f tib_a.p
	@rm -f tib_a.p.dump
	@rm -f tib_a.hex
	@rm -f tib_a.bin
	@rm -f tib_a.bin.dump
	@rm -f tib_a.i

# END.
