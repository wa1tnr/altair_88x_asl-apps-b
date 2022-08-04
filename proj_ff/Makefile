# ASL assembler Makefile
# Altair-Duino 8800b
# Intel 8080 Assembly Language programming

# Sat 11 Jun 03:46:35 UTC 2022

# change this line to your current project's root name for the .asm file

THIS=tib_ff

all:	clean hexfile binfile

# ./asl -a -cpu 8080 -L -listradix 8 $(THIS).asm

$(THIS).p:	./asl $(THIS).asm
	@./asl -P -a -cpu 8080 -L -listradix 8 $(THIS).asm
	@od -b -An $(THIS).p > $(THIS).p.dump

hexfile:	$(THIS).p ./p2hex
	@./p2hex	-q $(THIS).p

binfile:	$(THIS).p ./p2bin
	@./p2bin -q $(THIS).p $(THIS).bin
	@od -b -An $(THIS).bin > $(THIS).bin.dump

gdiff:	$(THIS).asm
	@git diff ./$(THIS).asm

edit:	$(THIS).asm
	@rvim -n ./$(THIS).asm


# update build environment to bring in ASL

# UNTESTED on 11 June 2022 03:45 UTC:

env:
	@rm -f _asl _p2bin _p2hex
	@cp -p ../0-Distrib.d/asl-base/_asl ./asl
	@cp -p ../0-Distrib.d/asl-base/_p2bin  ./p2bin
	@cp -p ../0-Distrib.d/asl-base/_p2hex  ./p2hex

compiler:
	@make env

asl:	compiler

gitrestore:
	@git restore -- _asl _p2bin _p2hex

clean:	gitrestore
	@rm -f $(THIS).inc
	@rm -f $(THIS).lst

	@rm -f $(THIS).p
	@rm -f $(THIS).p.dump
	@rm -f $(THIS).hex
	@rm -f $(THIS).bin
	@rm -f $(THIS).bin.dump
	@rm -f $(THIS).i

# END.
