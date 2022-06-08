; 'Error' program - early terminal input buffer (TIB)
; Wed  8 Jun 13:57:21 UTC 2022

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

	; ORG	3300o
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

;  git $  odd 'Wed  8 Jun 15:18:45 UTC 2022'
	DB	040o, 040o, 040o, 040o, 040o, 040o
	DB	127o, 145o, 144o, 040o, 040o, 070o, 040o, 112o, 165o, 156o, 040o, 061o, 065o, 072o, 061o, 070o
	DB	072o, 064o, 065o, 040o, 125o, 124o, 103o, 040o, 062o, 060o, 062o, 062o

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

	ORG	176000o
SP_H:	DB	0o

	END

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

SP_Hx:
	ORG	176000o
; END.
