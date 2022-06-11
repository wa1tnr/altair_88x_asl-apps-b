; 'Error' program - early terminal input buffer (TIB)
; Wed  8 Jun 20:09:01 UTC 2022
; TESTED: 175010o EXAMINE, RUN hit the high trap
boundary:
	ORG	1400o ; reserve 768 bytes
	DB	1o
; BYTES:	DB	105o, 162o, 162o, 157o, 162o, 040o, 040o, 040o ;  Error    ........
; spell it BYAA BYAB BYAB BYAC BYAB BYAD BYAD BYAD
; ###bookmark
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
	; JMP	trapped ; test
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
; $  odd 'Wed  8 Jun 20:09:01 UTC 2022 immediately before 0.1.0-pre-alpha'
	DB	040o, 040o, 040o, 040o, 040o, 040o
	db	127o, 145o, 144o, 040o, 040o, 070o, 040o, 112o, 165o, 156o, 040o, 062o, 060o, 072o, 060o, 071o
	db	072o, 060o, 061o, 040o, 125o, 124o, 103o, 040o, 062o, 060o, 062o, 062o, 040o, 151o, 155o, 155o
	db	145o, 144o, 151o, 141o, 164o, 145o, 154o, 171o, 040o, 142o, 145o, 146o, 157o, 162o, 145o, 040o
	db	060o, 056o, 061o, 056o, 060o, 055o, 160o, 162o, 145o, 055o, 141o, 154o, 160o, 150o, 141o
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
