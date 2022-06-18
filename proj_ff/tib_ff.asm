; 'Error' program - early terminal input buffer (TIB)
; Wed  8 Jun 20:09:01 UTC 2022

; TESTED: 175010o EXAMINE, RUN hit the high trap
;

	ORG	100H	; 400o 256
	JMP	CLD	; VECTOR TO COLD START

	ORG	1540o
BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
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
; CLD:	LXI SP, 4000o

CLD:	LXI SP,  000o

START:	JMP run

ESCAPE  DB	27
SQBKT	DB	133o
NBR0	DB	060o
NBR1	DB	061o
NBR2	DB	062o
NBR3	DB	063o
NBR4	DB	064o
NBR5	DB	065o
NBR6	DB	066o
NBR7	DB	067o
NBR8	DB	070o
NBR9	DB	071o
LTRA	DB	101o
LTRJ	DB	112o

WAIT:	MVI E,	000o
	MVI D,	004o
; MVI D,	150o

REENT:	DCR E
	JNZ REENT
	DCR D
	JNZ REENT
	RET

; RET is placing PC to 000000o so that's a problem.

; it's not reaching zero in the error - the instruction says
; jump non-zero to cycle back, so it's just never hitting zero.

LDELY:	CALL	WAIT	; finite delay added here
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
	RET

CLRS:	LDA	ESCAPE
	OUT	001
	LDA	SQBKT
	OUT	001
	LDA	NBR2
	OUT	001
	LDA	LTRJ
	OUT	001
	RET

CUUP:	LDA	ESCAPE ; ESC [ 1 3 A ESCAPE SQBKT NBR1 NBR5 LTRA
	OUT	001

	LDA	SQBKT
	OUT	001

	LDA	NBR2
	OUT	001

	LDA	NBR8
	OUT	001

	LDA	LTRA
	OUT	001
	RET


TRMSET:	CALL	LDELY
	CALL	CLRS
	CALL	CUUP
	RET


KEY:	IN	000
	ANI	001
	JNZ	KEY

FOUND:	IN	001
	OUT	001
	RET

CNVSN:	NOP
.loop	CALL	KEY
	JMP	.loop

run:	CALL	TRMSET
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
	RET

; odd.sh
; echo -n "${1}" | od -b -An

	DB	040o, 040o, 040o, 040o, 040o, 040o
; $ odd 'Sat 18 Jun 13:10:26 UTC 2022 after many edits and ROMming sessions and git HEAD stuff'
	db	123o, 141o, 164o, 040o, 061o, 070o, 040o, 112o
	db	165o, 156o, 040o, 061o, 063o, 072o, 061o, 060o
	db	072o, 062o, 066o, 040o, 125o, 124o, 103o, 040o
	db	062o, 060o, 062o, 062o, 040o, 141o, 146o, 164o
	db	145o, 162o, 040o, 155o, 141o, 156o, 171o, 040o
	db	145o, 144o, 151o, 164o, 163o, 040o, 141o, 156o
	db	144o, 040o, 122o, 117o, 115o, 155o, 151o, 156o
	db	147o, 040o, 163o, 145o, 163o, 163o, 151o, 157o
	db	156o, 163o, 040o, 141o, 156o, 144o, 040o, 147o
	db	151o, 164o, 040o, 110o, 105o, 101o, 104o, 040o
	db	163o, 164o, 165o, 146o, 146o, 040o, 040o, 040o
	db	040o, 040o, 040o, 040o, 040o, 040o

; $ odd 'Sat 18 Jun 16:50:03 UTC 2022 found PC 000000Q bug so reorganized software quite a bit'

	db	123o, 141o, 164o, 040o, 061o, 070o, 040o, 112o
	db	165o, 156o, 040o, 061o, 066o, 072o, 065o, 060o
	db	072o, 060o, 063o, 040o, 125o, 124o, 103o, 040o
	db	062o, 060o, 062o, 062o, 040o, 146o, 157o, 165o
	db	156o, 144o, 040o, 120o, 103o, 040o, 060o, 060o
	db	060o, 060o, 060o, 060o, 121o, 040o, 142o, 165o
	db	147o, 040o, 163o, 157o, 040o, 162o, 145o, 157o
	db	162o, 147o, 141o, 156o, 151o, 172o, 145o, 144o
	db	040o, 163o, 157o, 146o, 164o, 167o, 141o, 162o
	db	145o, 040o, 161o, 165o, 151o, 164o, 145o, 040o
	db	141o, 040o, 142o, 151o, 164o

; -- snip ! --

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
