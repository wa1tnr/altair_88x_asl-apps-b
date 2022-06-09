; figf_dd.asm
; 09 June 2022
; quick experiments sourcing FIG Forth 1.1 per the PDF

; Thu  9 Jun 12:30:48 UTC 2022

FIGREL	EQU	1
FIGREV	EQU	1
USRVER	EQU	0

ABL	EQU	20h
ACR	EQU	0Dh
ADOT	EQU	02eh
BELL	EQU	07h

boundary:
	ORG	1400o ; reserve 768 bytes
	DB	1o
	DB	BELL
	DB	BELL
	DB	BELL
	DB	BELL
	DB	BELL
	DB	BELL
	DB	BELL ; multiple instances 'worked'**
	DB	ABL
	DB	ADOT

; **'worked':
; Start address: 300
; 0300: 01 07 07 07 07 07 07 07  20 2E 00 00 00 00 00 00   ........  .......


; FORTH REGISTERS

; FORTH 8080
; IP	BC
; W	DE
; SP	SP
;	HL ; no forth

; NAME is address
; (NAME) is contents of address
; ((NAME)) is indirect contents of address

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

 ; 'FIG Forth 1.1 - edits made on Thu  9 Jun 12:30:48 UTC 2022'

 ; $  odd  'FIG Forth 1.1 - edits made on Thu  9 Jun 12:30:48 UTC 2022'

	DB	106o, 111o, 107o, 040o, 106o, 157o, 162o, 164o
	DB	150o, 040o, 061o, 056o, 061o, 040o, 055o, 040o
	DB	145o, 144o, 151o, 164o, 163o, 040o, 155o, 141o
	DB	144o, 145o, 040o, 157o, 156o, 040o, 124o, 150o
	DB	165o, 040o, 040o, 071o, 040o, 112o, 165o, 156o
	DB	040o, 061o, 062o, 072o, 063o, 060o, 072o, 064o
	DB	070o, 040o, 125o, 124o, 103o, 040o, 062o, 060o
	DB	062o, 062o



























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
