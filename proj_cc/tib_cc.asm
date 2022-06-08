; 'Error' program - early terminal input buffer (TIB)
; Wed  8 Jun 13:57:21 UTC 2022

; TESTED: 175010o EXAMINE, RUN hit the high trap

boundary:
	ORG	1400o ; reserve 768 bytes
	DB	1o

; Start address: 2000

	ORG	2000o
START:	LXI SP,	SP_H
	JMP run
        NOP
        NOP
        NOP
        NOP
	LDA	017o
        NOP
        NOP
        NOP

run: ; THERE

.loop
	CALL	KEY
	JMP	.loop
KEY:
	IN	000
	ANI	001
	JNZ	KEY
	IN	001
	OUT	001
	NOP
	NOP
	NOP
	JMP	trapped ; test

	; LDA	BYTES
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

WAIT:
	MVI E,	000o
	MVI D,	150o
REENT:
	DCR E
	JNZ REENT
	DCR D
	JNZ REENT
	RET


; odd.sh
; echo -n "${1}" | od -b -An

	DB	040o, 040o, 040o, 040o, 040o, 040o

;  git $  odd 'Wed  8 Jun 16:19:49 UTC 2022'
	DB	127o, 145o, 144o, 040o, 040o, 070o, 040o, 112o, 165o, 156o, 040o, 061o, 066o, 072o, 061o, 071o
	DB	072o, 064o, 071o, 040o, 125o, 124o, 103o, 040o, 062o, 060o, 062o, 062o


; variables in higher low-memory - stale comment

	ORG	1640o
TIB:	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
        DB	172o, 173o, 174o, 175o, 176o, 177o, 200o
	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
        DB	172o, 173o, 174o, 175o, 176o, 177o, 200o

; BYTES:	DB	105o, 162o, 162o, 157o, 162o, 040o, 040o, 040o ;  Error    ........
; spell it BYAA BYAB BYAB BYAC BYAB BYAD BYAD BYAD

	ORG	1700o
BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
BYAD:	DB	040o

	ORG	175000o
; SP_H:	DB	317o
SP_H:	DB	0o

; error trap
	ORG	175400o ; act as soon as possible

        NOP
        NOP
        NOP
        NOP

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




; NOTES - not in this program:

;	ORG	176000o ; as front panel, could be 176,000 notation

; -- map --

boundaryxx:
	ORG	1400o ; reserve 768 bytes

TIBx:
	ORG	1640o

BYAAx: ; Error  string component bytes E r o and a space
	ORG	1700o

STARTx:
	ORG	2000o
runx:
	ORG	3300o ; not yet implemented and is excessive

SP_Hx: ; stack pointer
	ORG	176000o
	DB	0o

; END.
