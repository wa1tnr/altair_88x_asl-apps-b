; 'Error' program - early terminal input buffer (TIB)
; Mon  6 Jun 23:57:59 UTC 2022

; Start address: 2000

	ORG	2000o

START:	LXI SP,	SP_H

LOOP:
	CALL	KEY
	JMP	LOOP

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

; variables in higher low-memory

	ORG	1640o
TIB:	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
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

; END.
