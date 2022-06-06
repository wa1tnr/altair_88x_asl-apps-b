;	ORG	176000o ; as front panel, could be 176,000 notation

; 'Error' program - early terminal input buffer (TIB)
; Mon  6 Jun 23:32:19 UTC 2022

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

; spell it BYAA BYAB BYAB BYAC BYAB BYAD BYAD BYAD

; variables in higher low-memory

	ORG	1640o
TIB:	DB	163o, 164o, 165o, 166o, 167o, 170o, 171o
        DB	172o, 173o, 174o, 175o, 176o, 177o, 200o

	ORG	1700o
; BYTES:	DB	105o, 162o, 162o, 157o, 162o, 040o, 040o, 040o ;  Error    ........
; spell it BYAA BYAB BYAB BYAC BYAB BYAD BYAD BYAD
BYAA:	DB	105o
BYAB:	DB	162o
BYAC:	DB	157o
BYAD:	DB	040o

; variables in low memory

	ORG	40o

VAL1:	DB	25o
VAL2:	DB	310o
SUM:	DB	0o

	ORG	176000o
SP_H:	DB	0o

	END

; START:	LDA	VAL1

Start address: 2000

002004: LXI SP,176000

LOOP:
002007: CALL 002015
002012: JMP 002007

KEY:
002015: IN 000
002017: ANI 001
002021: JNZ 002015

002024: IN 001
002026: NOP
002027: NOP
002030: NOP
002031: LDA 002140
002034: OUT 001
002036: LDA 002141
002041: OUT 001
002043: LDA 002142
002046: OUT 001
002050: LDA 002143
002053: OUT 001
002055: LDA 002144
002060: OUT 001
002062: LDA 002145
002065: OUT 001
002067: LDA 002146
002072: OUT 001
002074: NOP
002075: NOP
002076: NOP
002077: CALL 002104
002102: NOP
002103: RET

002104: MVI E,000
002106: MVI D,150
002110: DCR E
002111: JNZ 002110
002114: DCR D
002115: JNZ 002110
002120: RET


002140: MOV B,L
002141: MOV M,D
002142: MOV M,D
002143: MOV L,A
002144: MOV M,D
002145: <040> [NOP]
002146: <040> [NOP]
002147: <040> [NOP]


002340: MOV D,H
002341: MOV L,B
002342: MOV M,L
002343: <040> [NOP]
002344: <040> [NOP]
002345: STA 045040
002350: MOV M,L
002351: MVR L,HL
002352: <040> [NOP]
002353: STA 035063
002356: STA 035064
002361: DCR M
002362: INR M
002363: <040> [NOP]
002364: MOV D,L
002365: MOV D,H
002366: MOV B,E
002367: <040> [NOP]
002370: STA 031060
002373: STA 000000



Start address: 2000
002000: 000 000 000 000 061 000 374 315  015 004 303 007 004 333 000 346   ....1... ........
002020: 001 302 015 004 333 001 000 000  000 072 140 004 323 001 072 141   ........ .:`...:a
002040: 004 323 001 072 142 004 323 001  072 143 004 323 001 072 144 004   ...:b... :c...:d.
002060: 323 001 072 145 004 323 001 072  146 004 323 001 000 000 000 315   ..:e...: f.......
002100: 104 004 000 311 036 000 026 150  035 302 110 004 025 302 110 004   D......h ..H...H.
002120: 311 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002140: 105 162 162 157 162 040 040 040  000 000 000 000 000 000 000 000   Error    ........
002160: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002200: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002220: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002240: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002260: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002300: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002320: 000 000 000 000 000 000 000 000  000 000 000 000 000 000 000 000   ........ ........
002340: 124 150 165 040 040 062 040 112  165 156 040 062 063 072 062 064   Thu  2 J un 23:24
002360: 072 065 064 040 125 124 103 040  062 060 062 062 000 000 000 000   :54 UTC  2022....

Start address: 2000
002000: NOP
002001: NOP
002002: NOP
002003: NOP
002004: LXI SP,176000
002007: CALL 002015
002012: JMP 002007
002015: IN 000
002017: ANI 001
002021: JNZ 002015
002024: IN 001
002026: NOP
002027: NOP
002030: NOP
002031: LDA 002140
002034: OUT 001
002036: LDA 002141
002041: OUT 001
002043: LDA 002142
002046: OUT 001
002050: LDA 002143
002053: OUT 001
002055: LDA 002144
002060: OUT 001
002062: LDA 002145
002065: OUT 001
002067: LDA 002146
002072: OUT 001
002074: NOP
002075: NOP
002076: NOP
002077: CALL 002104
002102: NOP
002103: RET

002104: MVI E,000
002106: MVI D,150
002110: DCR E
002111: JNZ 002110
002114: DCR D
002115: JNZ 002110
002120: RET


002140: MOV B,L
002141: MOV M,D
002142: MOV M,D
002143: MOV L,A
002144: MOV M,D
002145: <040> [NOP]
002146: <040> [NOP]
002147: <040> [NOP]


002340: MOV D,H
002341: MOV L,B
002342: MOV M,L
002343: <040> [NOP]
002344: <040> [NOP]
002345: STA 045040
002350: MOV M,L
002351: MVR L,HL
002352: <040> [NOP]
002353: STA 035063
002356: STA 035064
002361: DCR M
002362: INR M
002363: <040> [NOP]
002364: MOV D,L
002365: MOV D,H
002366: MOV B,E
002367: <040> [NOP]
002370: STA 031060
002373: STA 000000
