; keyboard echo w/boilerplate

; Sun 26 Jun 16:40:01 UTC 2022

	ORG	2000o
START:	JMP	CLD

IDEN:
; $  odd ' jbncwkRR'
	db	040o, 040o, 040o, 040o,   040o, 155o, 162o, 142o
	db	151o, 154o, 154o, 040o,   153o, 040o, 040o, 040

BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
BYAD:	DB	040o

TIB:

; message

; $  odd 'Wed 29 Jun 20:44:34 UTC 2022 '
	db	127o, 145o, 144o, 040o,   062o, 071o, 040o, 112o
	db	165o, 156o, 040o, 062o,   060o, 072o, 064o, 064o
	db	072o, 063o, 064o, 040o,   125o, 124o, 103o, 040o
	db	062o, 060o, 062o, 062o,   040o


; $  odd 'r01-bb- '
;                 r     0     1     -       b     b
	db	162o, 060o, 061o, 055o,   142o, 142o, 055o, 040o
	db	013o, 015o, 013o, 015o ; experiment

; $  odd 'now displaying TIB contents on boot after CLRS!'
	db	156o, 157o, 167o
	db	040o, 144o, 151o, 163o,   160o, 154o, 141o, 171o
	db	151o, 156o, 147o, 040o,   124o, 111o, 102o, 040o
	db	143o, 157o, 156o, 164o,   145o, 156o, 164o, 163o
	db	040o, 157o, 156o, 040o,   142o, 157o, 157o, 164o
	db	040o, 141o, 146o, 164o,   145o, 162o, 040o, 103o
	db	114o, 122o, 123o, 041o,   040o, 040o, 040o, 040o
	db	013o, 015o, 013o, 015o ; experiment

; $  odd ' Has tomxp411 commit 869274a 22 Jun 15:28:58 2022 -0700 DigiKey sourced Due board '

; note: adwaterandstir supplied Due has now been modified Tue 28 Jun - reflashed with firmware.
; so there are no 'reference' copies of the Due, now.  Both are modified firmware. ;)

	db	040o, 110o, 141o, 163o,   040o, 164o, 157o, 155o
	db	170o, 160o, 064o, 061o,   061o, 040o, 143o, 157o
	db	155o, 155o, 151o, 164o,   040o, 070o, 066o, 071o
	db	062o, 067o, 064o, 141o,   040o, 062o, 062o, 040o
	db	112o, 165o, 156o, 040o,   061o, 065o, 072o, 062o
	db	070o, 072o, 065o, 070o,   040o, 062o, 060o, 062o
	db	062o, 040o, 055o, 060o,   067o, 060o, 060o, 040o
	db	104o, 151o, 147o, 151o,   113o, 145o, 171o, 040o
	db	163o, 157o, 165o, 162o,   143o, 145o, 144o, 040o
	db	104o, 165o, 145o, 040o,   142o, 157o, 141o, 162o
	db	144o, 040o
	db	013o, 015o, 013o, 015o ; experiment


CLD:	LXI SP,	STACK+400Q ; 200Q was working previously
	JMP run

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

; delay
WAIT:	MVI E,	000o
	MVI D,	150o
REENT:	DCR E
	JNZ REENT
	DCR D
	JNZ REENT
	RET

LDELY:	CALL	WAIT
	CALL	WAIT
	CALL	WAIT
	NOP
	NOP
	NOP
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

CLRS:	LDA	ESCAPE ; PC   = 0482 = [3A 06 04] = LDA 0406
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



; ###bookmark

RKEY:
	NOP
	JMP	CONTU

QKEYB:	IN	0H
	ANI	001
	JNZ	RKEY
CONTU:
	IN	1H ; clear
	NOP
	NOP
	INR E
	INR E
	INR E

; ###bookmark

; MVI	A, 0

SKEY:
	MVI	A, 171o
	IN	10H
	ANI	375o ; 374 also - 375 is for '2' and 374 is for '3'
; CMA	; invert?
	JNZ	SKEY

GETONE:
;	IN	 11H
	MVI	A, 167o

GOTONE:
	OUT	 1H
	IN	11H ; clear
	MVI	A, 0
	JMP	SKEY


CNVSN:	NOP

.loop	CALL	SKEY ; BIG CHANGE
	JMP	.loop

run:
	JMP	CNVSN

MDELY:	CALL	WAIT	; finite delay added here
	CALL	WAIT
	CALL	WAIT

	RET


MESSG:	CALL	MDELY

; ###bookmark

.push_regs:
	PUSH B
	PUSH D
	PUSH H

.string_addrs
	LXI H,	TIB ; address of string base

.counter:
	; string length is near 125o - manually determined
	; 255o close on the count
	; MVI E,	265o ; lo  ; length of string to display
	MVI E,	266o ; lo  ; length of string to display
	MVI D,	000o ; hi

; type the string to the console
.putch:
	DCR E
	MOV A, M ; copy the memory contents pointed to by HL into A
	OUT	001
	INX	H
	JNZ .putch

.pop_regs:
        POP	H
        POP	D
        POP	B

.end_MESSG:
	RET


; ---------   error trap   ----------
; nothing calls this; it's meant for situations where
; NOP was followed past a boundary, to notify operator
; that an invalid execution path has begun.

; error trap
; small memory buffer - have not researched what this is or does. ;)
; meant to simply populate the memory map with a clean set of NOPS

	ds	100o

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


; ------------------  stack  --------------
STACK: 
	DB	0
	END

; END.
