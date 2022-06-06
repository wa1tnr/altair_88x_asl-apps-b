
THIS=tib_a

all:	clean hexfile binfile

$(THIS).p:
	./asl -a -cpu 8080 -L -listradix 8 $(THIS).asm

hexfile:	$(THIS).p
	./p2hex	$(THIS).p
	od -b -An $(THIS).hex > $(THIS).hex.dump

binfile:	$(THIS).p
	./p2bin $(THIS).p $(THIS).bin
	od -b -An $(THIS).bin > $(THIS).bin.dump

clean:
	@rm -f tib_a.inc
	@rm -f tib_a.lst
	@rm -f tib_a.p
	@rm -f tib_a.hex
	@rm -f tib_a.hex.dump
	@rm -f tib_a.bin
	@rm -f tib_a.bin.dump

# END.
