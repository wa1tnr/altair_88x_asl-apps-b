; 'Error' program - early terminal input buffer (TIB)
; Sat 18 Jun 19:02:58 UTC 2022

; TESTED: 175010o EXAMINE, RUN hit the high trap
;

	ORG	100H	; 400o 256
	JMP	CLD	; VECTOR TO COLD START

	ORG	1540o
; 0x0360
BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
; 0x0363
BYAD:	DB	040o


; variables in higher low-memory - stale comment

	ORG	1640o

TIB:
	DB	161o, 162o, 163o, 164o,   165o, 166o, 167o, 170o
	DB	171o, 172o, 173o, 174o,   175o, 176o, 177o, 200o

	DB	161o, 162o, 163o, 164o,   165o, 166o, 167o, 170o
	DB	171o, 172o, 173o, 174o,   175o, 176o, 177o, 200o

	DB	161o, 162o, 163o, 164o,   165o, 166o, 167o, 170o
	DB	171o, 172o, 173o, 174o,   175o, 176o, 177o, 200o

	DB	161o, 162o, 163o, 164o,   165o, 166o, 167o, 170o
	DB	171o, 172o, 173o, 174o,   175o, 176o, 177o, 200o

	DB	161o, 162o, 163o, 164o,   165o, 166o, 167o, 170o
	DB	171o, 172o, 173o, 174o,   175o, 176o, 177o, 200o


	ORG	4000o
SP_H:	DB	0o


; Start address: 2000

	ORG	2000o

; CLD:	LXI SP,  000o

; 0x0400
CLD:	LXI SP,	176000o

; 0x0403
START:	JMP run

; 0x0406
ESCAPE  DB	27

; 0x0407
SQBKT	DB	133o

NBR0	DB	060o

NBR1	DB	061o

NBR2	DB	062o

NBR3	DB	063o

NBR4	DB	064o

NBR5	DB	065o

NBR6	DB	066o

NBR7	DB	067o

; 0x0410
NBR8	DB	070o

NBR9	DB	071o
LTRA	DB	101o
LTRJ	DB	112o

; 0x0414
WAIT:	MVI E,	000o ; 007 for debug brevity
	MVI D,	150o

;	MVI D,	001o
;	MVI D,	150o

; 0x0418
REENT:	DCR E
	JNZ REENT
; 0x041c
	DCR D
	JNZ REENT
; 0x0420
	RET

; RET is placing PC to 000000o so that's a problem.

; it's not reaching zero in the error - the instruction says
; jump non-zero to cycle back, so it's just never hitting zero.

; 0x0421
LDELY:	CALL	WAIT	; finite delay added here
; 0x0424
	CALL	WAIT
; 0x0427
	CALL	WAIT
; 0x042A
; disregardxxx JMP	CANADA

; 0x042A
	NOP	; KEEP all three NOP to preserve addresses in this document
	NOP	; the JMP CANADA thing when commented out needs these NOPs
	NOP	; as its replacement bytes. ;)
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT

;	CALL	WAIT

	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
; 0x0481
CANADA:	RET

; 0x0482
CLRS:	LDA	ESCAPE ; PC   = 0482 = [3A 06 04] = LDA 0406
; 0x0485
	OUT	001
; 0x0487
	LDA	SQBKT

	OUT	001
	LDA	NBR2
	OUT	001
	LDA	LTRJ
	OUT	001
; 0x0496
	RET

; 0x0497
CUUP:	LDA	ESCAPE ; ESC [ 1 3 A ESCAPE SQBKT NBR1 NBR5 LTRA
; 0x049a
	OUT	001

	LDA	SQBKT
	OUT	001

	LDA	NBR2
	OUT	001

	LDA	NBR8
	OUT	001

	LDA	LTRA
; 0x04AE
	OUT	001
; 0x04B0
	RET

; 0x04B1
TRMSET:	CALL	LDELY
; 0x04B4
	CALL	CLRS
; 0x04B7
	CALL	CUUP
; 0x04BA
	RET


; 0x04BB
KEY:	IN	000
; 0x04BD
	ANI	001
; 0x04BF
	JNZ	KEY

; 0x04C2
FOUND:	IN	001
; 0x04C4
	OUT	001
; 0x04C6
	RET

; 0x04C7
CNVSN:	NOP

; 0x04C8
.loop	CALL	KEY
	JMP	.loop

; 0x04CE
run:	CALL	TRMSET
; 0x04D1
	JMP	CNVSN

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
; 0x0509
	RET

; odd.sh
; echo -n "${1}" | od -b -An

	DB	040o, 040o, 040o, 040o, 040o, 040o
; $ odd 'Sat 18 Jun 13:10:26 UTC 2022 after many edits and ROMming sessions and git HEAD stuff'
; $ odd 'Sat 18 Jun 16:50:03 UTC 2022 found PC 000000Q bug so reorganized software quite a bit'
; $ odd 'Sat 18 Jun 19:03:23 UTC 2022 SP 0xFC00 aa'
	DB	040o, 040o, 040o, 040o, 040o, 040o
	db	123o, 141o, 164o, 040o, 061o, 070o, 040o, 112o
	db	165o, 156o, 040o, 061o, 071o, 072o, 060o, 063o
	db	072o, 062o, 063o, 040o, 125o, 124o, 103o, 040o
	db	062o, 060o, 062o, 062o, 040o, 123o, 120o, 040o
	db	060o, 170o, 106o, 103o, 060o, 060o, 040o, 141o
	db	141o

	DB	040o, 040o, 040o, 040o, 040o, 040o
; $  odd 'Sat 18 Jun 20:56:22 UTC 2022 SOURCE is annotated with addresses in hex.'
	DB	040o, 040o, 040o, 040o, 040o, 040o

	db	123o, 141o, 164o, 040o, 061o, 070o, 040o, 112o
	db	165o, 156o, 040o, 062o, 060o, 072o, 065o, 066o
	db	072o, 062o, 062o, 040o, 125o, 124o, 103o, 040o
	db	062o, 060o, 062o, 062o, 040o, 123o, 117o, 125o
	db	122o, 103o, 105o, 040o, 151o, 163o, 040o, 141o
	db	156o, 156o, 157o, 164o, 141o, 164o, 145o, 144o
	db	040o, 167o, 151o, 164o, 150o, 040o, 141o, 144o
	db	144o, 162o, 145o, 163o, 163o, 145o, 163o, 040o
	db	151o, 156o, 040o, 150o, 145o, 170o, 056o


; error trap
	ORG	5000o ; act as soon as possible

        NOP
        NOP
        NOP
        NOP

trapped:
	JMP	err_hi

waiting:
	MVI E,	000o
	MVI D,	150o
reentry:
	DCR E
	JNZ reentry
	DCR D
	JNZ reentry
	RET

err_hi:
	NOP
	NOP
hold:
	NOP
	NOP

	LDA	BYHD	; 040o
	OUT	001

	LDA	BYHD
	OUT	001

	LDA	BYHA	; 105o 'E'
	OUT	001

	LDA	BYHB    ; 162o 'r'
	OUT	001

	LDA	BYHB
	OUT	001

	LDA	BYHC	; 157o 'o'
	OUT	001

	LDA	BYHB    ; 'Error' to here
	OUT	001

	LDA	BYHD
	OUT	001


	LDA	BYHE	; '-'
	OUT	001

	LDA	BYHD
	OUT	001

	LDA	BYHF	; 'H'
	OUT	001

	LDA	BYHG	; 'I'
	OUT	001

	LDA	BYHH	; 'G'
	OUT	001

	LDA	BYHF	; 'H'
	OUT	001

	LDA	BYHD    ; ' '
	OUT	001

	LDA	BYHI    ; 'T'
	OUT	001

	LDA	BYHJ    ; 'R'
	OUT	001

	LDA	BYHK    ; 'A'
	OUT	001

	LDA	BYHL    ; 'P'
	OUT	001

	LDA	BYHD    ; ' '
	OUT	001

	LDA	BYHD    ; ' '
	OUT	001

	NOP
	NOP
	NOP
	NOP

	CALL	waiting ; finite delay added here
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	CALL	waiting
	JMP	hold
	NOP
	NOP
	NOP
	NOP

BYHA:	DB	105o ; 'E'
BYHB:	DB	162o ; 'r'
BYHC:	DB	157o ; 'o'
BYHD:	DB	040o ; ' '
BYHE:	DB	055o ; '-'
BYHF:	DB	110o ; 'H'
BYHG:	DB	111o ; 'I'
BYHH:	DB	107o ; 'G'
BYHI:	DB	124o ; 'T'
BYHJ:	DB	122o ; 'R'
BYHK:	DB	101o ; 'A'
BYHL:   DB	120o ; 'P'
	END


; $  odd '  Error - HIGH TRAP  '
; 040 040 105 162 162 157 162 040 055 040 110 111 107 110 040 124
; 122 101 120 040 040


; END.
