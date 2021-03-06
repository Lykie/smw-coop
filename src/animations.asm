Animations:
LDA $151C,x
BNE activetimer
LDA $1504,x			;timer just ran out. check if should warp
PHP
LDA #$00
PLP
BPL .nowarp
LDY $14E0,x
LDA $19B8,y
LDY $95
STA $19B8,y
LDA #$05
STA $71				;warp
STZ $89
STZ $88
LDA #$20
STA $151C,x
LDA $1504,x
AND #$7F
.nowarp
STA $1504,x
STZ $9D
FreezeMotion:
LDA $1504,x
CMP #$05
BCS +
LDA $0F6A
PHA
ORA #$10
STA $0F6A
JSR SUB_GFX
PLA
STA $0F6A
BRA $03
+
JSR SUB_GFX
JSR DRAW_BUBBLE		;Freeze!
RTS

FreezeAndLock:
LDA #$05
STA $9D
BRA FreezeMotion

FreezeLockNoshow:
LDA #$05
STA $9D
JSR DRAW_BUBBLE
RTS

activetimer:
DEC
STA $151C,x
LDA $1504,x
AND #$7F
DEC
ASL
TAY
REP #$20
LDA.w AniPtrs,y
STA $00
SEP #$20
JMP ($0000)

AniPtrs:
dw PipesWalk
dw PipesWalk
dw PipesGo
dw PipesGo
dw FreezeMotion
dw HurtLuigiAni
if !THREEPLAYER
dw GrowLuigiAni
else
dw HurtLuigiAni
endif
dw FreezeAndLock
dw PipeShot
dw FreezeLockNoshow


SixteenBitOne:
dw $FFFF,$0001

PipesWalk:
LDA #$23
TRB $0DB9
LDA $1504,x
AND #$7F
DEC
ASL
TAY
LDA $13
BIT #$01
BEQ .skipposing
LDA $14E0,x
XBA
LDA $E4,x
REP #$20
CLC
ADC.w SixteenBitOne,y
SEP #$20
STA $E4,x
XBA
STA $14E0,x
.skipposing
LDA $151C,x
BIT #$03
BNE +
LDA $1510,x
INC
CMP #$03
BCC .lowset
LDA #$00
.lowset
STA $1510,x
+
LDA $0F6A
PHA
ORA #$10
STA $0F6A
LDA $1504,x
AND #$7F
DEC
STA $157C,x
JSR SUB_GFX
JSR DRAW_BUBBLE
PLA
STA $0F6A
RTS

PipesGo:
LDA #$10
STA $AA,x
LDA #$23
TRB $0DB9
LDA $1504,x
AND #$7F
SEC
SBC #$03
ASL
TAY
LDA $14D4,x
XBA
LDA $D8,x
REP #$20
CLC
ADC.w SixteenBitOne,y
SEP #$20
STA $D8,x
XBA
STA $14D4,x
if !THREEPLAYER
LDA #$0A
else
LDA #$0F
endif
STA $1510,x
LDA $0F6A
PHA
ORA #$10
STA $0F6A
JSR SUB_GFX
JSR DRAW_BUBBLE
PLA
STA $0F6A
RTS

HurtLuigiAni:
LDA #$2F
STA $9D
LDA $151C,x
BIT #$03
BNE .statusquo
BIT #$07
BNE .setsize
if !THREEPLAYER
LDA #$2E
else
LDA #$3D
endif
STA $1510,x
BRA .statusquo
.setsize
CMP #$10
BCC .small
if !THREEPLAYER
LDA #$02
else
LDA #$46
endif
STA $1510,x
BRA .statusquo
.small
STZ $1510,x
.statusquo
JSR SUB_GFX
JSR DRAW_BUBBLE
RTS

if !THREEPLAYER
GrowLuigiAni:
LDA $151C,x
BIT #$03
BNE .statusquo
BIT #$07
BEQ .setsize
LDA #$2E
STA $1510,x
BRA .statusquo
.setsize
CMP #$15
BCS .small
LDA #$02
STA $1510,x
BRA .statusquo
.small
STZ $1510,x
.statusquo
JSR SUB_GFX
JSR DRAW_BUBBLE
RTS
endif

PipeShot:
LDA #$11
STA $0F6A
STZ $1504,x
JSR SUB_GFX
JSR DRAW_BUBBLE
JSL $01801A	;update positions by speed
JSL $018022	;without gravity, that is
LDA #$09
STA $1504,x
LDA #$01
STA $0F6A
RTS
