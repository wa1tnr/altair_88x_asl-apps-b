; 'Error' program - early terminal input buffer (TIB)
; Wed  8 Jun 11:55:54 UTC 2022

; variables in higher low-memory

; move 1640 to 2040 and let everything else map upward by that amount.
; then put a JMP very low but above 2000, to jump into the program
; from a naive init of the program at exactly 2000.

; in-forth : octal 8 base ! ; : binary 2 base ! ;  ok

; octal  640         decimal .  416  ok
; octal 1400         decimal .  768  ok  ; boundary
; octal 1600         decimal .  896  ok
; octal 1640         decimal .  928  ok

; octal 2000         decimal . 1024  ok

; octal 2040         decimal . 1056  ok
; octal 2100         decimal . 1088  ok
; octal 2200         decimal . 1152  ok
; octal 2400         decimal . 1280  ok
; octal 2600         decimal . 1408  ok
; octal 2620         decimal . 1424  ok  ; tib

; octal 2000 decimal 512 + octal . 3000  ok

; octal 2000 decimal 256 + 256 + 80 - 16 - octal . 2640  ok
; octal 2640 decimal . 1440  ok
; decimal 1440 1024 - . 416  ok

; tib would then be 416 bytes above ram base 2000o

; decimal 416 256 - . 160 ; leaves 160 bytes above the first 256 bytes open
; this sounds very good right now.
; octal 2000 decimal 256 + 160 + . 1440  ok
; decimal 1440 octal . 2640  ok

; that gives 2640o as the lower bound of tib. Want to adjust it for good front panel switch factor.

; so you have bottom of ram at 2000o.
; an open block from 2000o to 2400o:

; octal 2000 decimal 256 + octal . 2400  ok

; potentially 160 bytes open above it:
; octal 2400 decimal 160 + octal .
; octal 2400 decimal 160 + octal . 2640  ok
; octal 2640 potential lower bound for tib.
; how much loss to adjust this downwards further, or upwards 8 bytes.
; octal 2600 decimal . 1408  ok
; octal 2600 2000 - decimal .
; octal 2600 2000 - decimal . 384  ok
; decimal 1024 octal . 2000  ok
; octal 2000 decimal 256 + 32 + octal . 2440  ok
; octal 2440 is really basement for tib.
; it's just one free block plus 32 bytes above the boundary at 2000o.
; octal 2600 is really wanted now.
; octal 2600 decimal 256 - octal .
; decimal 1024 octal . 2000  ok
; octal 2000 decimal 256 + 32 + octal . 2440  ok
; octal 2600 decimal 256 - octal . 2200  ok
; octal 2600 decimal . 1408  ok
; decimal 1408 1024 - octal . 600  ok


; here's the math on that nice switch factor for bottom of tib:
; decimal 1024 256 + 128 + octal . 2600  ok

; one free block, then one free half block.
; that's 1024 bytes, plus 256 free, plus 128 free .. then tib itself.
; tib was shortened to 80 bytes.

; decimal 1024 256 + 128 + octal dup .  \ froggie 2600  ok
; decimal 1024 256 + 128 + 80 + octal . \ froggy


; decimal 1024 256 + 128 + 80 + octal . \ froggy 2720  ok
; octal 2720 \ top of tib, closest to start

; thats 1488 decimal and 0x5D0
; 0x5FF is 2777o all leds set up to and incl. A8
; A10, A9 set all below reset:
; 3000o real start is now here most likely


; easy start switch
; so instead of counting 1, 2, 4 and flipping there:
; 1 (skip) 2 (flip up) 4 (flip up).
; it's one extra flip; it's contiguous.
; flip the top bit, then the one just below it and call that program start.

; 2000o start (has just a JMP to 3000o
; 3000o init stack pointer set
; 3010o KEY/IN stuff maybe








; ###bookmark

; tib:
; 2600o ; base of tib 
; 2720o ; top of tib, closest to start

; decimal 1024 256 + 128 + 0 + octal . \ gainf _TODO 2600  ok
; decimal 1024 256 + 128 + 80 + octal . \ froggy 2720  ok
; octal 3000 \ start

; ergonomics:
; access bottom of start/program area; all down and two up at a10, a9 switches.
; access bottom of tib: flip a9 down.  flip a8, a7 up. 2600o result. nice.



; so, 2600o marks bottom of tib.  2720o is top of tib.  3000o is start.
; 2000o is JMP start

; octal 2000 decimal . 1024  ok

; octal 2000 decimal 256 + octal . 2400  ok
; octal 2400 decimal . 1280  ok

; octal 2000 decimal 256 + 128 + octal . 2600  ok
; octal 2600 decimal . 1408  ok  \  bottom of tib

; distance below start (3000o) and top of tib:

; octal 3000 2600 - \ bottom of tib delta bytes from start
; 80 + \ top of tib delta from start

; there's 48 bytes empty between tib and start






; decimal 1024 256 + octal   . 2400  ok

; octal 2000 \ 1024
; decimal 256 \ 1024 256
; + \ 1280

; octal 2000  decimal 512 + 128 - 16 + octal . 2620  ok ; tib


; bottom of vram is octal 2000.

; want a few tens of bytes above 2000o, for housekeeping
; or other unplanned vital stuff.

; tib should be just below 'fixed' program.  16 or 32 bytes below 'fixed' ends the buffer.

; 2000o is 1024d
; decimal 1024 64 +

; 2000: vector-like entities, one jump to start (probably first instruction right at 2000o).

; decimal 256 2 /            .  128  ok
; decimal 256 3 *            .  768  ok

; decimal 768         octal  . 1400  ok

; octal 2000 decimal 256 - 128 + octal . 1600  ok  ; octal 1600 is TIB

; decimal  768  256 + octal  . 2000  ok
; decimal 1024   64 + octal  . 2100  ok
; decimal 1024  128 + octal  . 2200  ok
; decimal  768  512 + octal  . 2400  ok
; decimal 1024  256 + octal  . 2400  ok


; 1400o is  768 (256 * 3) lower boundary

; decimal 768 octal . 1400  ok

boundary:
	ORG	1400o ; reserve 768 bytes

; 2200o is 1024 + 128 decimal

;    terminal input buffer

	ORG	2600o
TIB:	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
        DB	172o, 173o, 174o, 175o, 176o, 177o, 200o
	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
        DB	172o, 173o, 174o, 175o, 176o, 177o, 200o

; octal 2600 decimal 80 + 8 + octal . 2730  ok

; BYTES:	DB	105o, 162o, 162o, 157o, 162o, 040o, 040o, 040o ;  Error    ........
; spell it BYAA BYAB BYAB BYAC BYAB BYAD BYAD BYAD


	ORG	2000o ; start
start:	JMP	init

	ORG	2060o
BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
BYAD:	DB	040o

	ORG	3000o
init:	LXI SP,	SP_H
	JMP	run

wait:
	MVI E,	000o
	MVI D,	150o
.loop
	DCR E
	JNZ .loop
	DCR D
	JNZ .loop
	RET

; below 2200 is TIB

; 2200o is 1024 + 128 decimal

	ORG	3300o
run ; THERE
.loop
	CALL	.key
	JMP	.loop

.key
	IN	000
	ANI	001
	JNZ	.key
	IN	001
	OUT	001
	NOP
	NOP
	NOP

	LDA	BYAD	; 040o
	OUT	001
	LDA	BYAD
	OUT	001
	LDA	BYAD
	OUT	001

	LDA	BYAA	; 105o
	OUT	001
	LDA	BYAB    ; 162o
	OUT	001
	LDA	BYAB
	OUT	001
	LDA	BYAC	; 157o
	OUT	001
	LDA	BYAB
	OUT	001
	LDA	BYAD
	OUT	001
	LDA	BYAD
	OUT	001
	CALL	WAIT	; finite delay added here
	RET

timestamp:
	ORG	4400o

	DB	040o, 040o, 040o, 040o, 040o, 040o
 	DB	124o, 165o, 145o, 040o, 040o, 067o, 040o, 112o, 165o, 156o, 040o, 062o, 061o, 072o, 063o, 066o
	DB	072o, 064o, 061o, 040o, 125o, 124o, 103o, 040o, 062o, 060o, 062o, 062o

; odd.sh
; echo -n "${1}" | od -b -An

;  $  odd 'Tue  7 Jun 21:36:41 UTC 2022'
; 124o, 165o, 145o, 040o, 040o, 067o, 040o, 112o, 165o, 156o, 040o, 062o, 061o, 072o, 063o, 066o,
; Start address: 2000

	ORG	176000o
SP_H:	DB	0o

	END

; NOTES - not in this program:

;	ORG	176000o ; as front panel, could be 176,000 notation

; END.
