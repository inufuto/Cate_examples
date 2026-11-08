include "GameKing.inc"
include "ZeroPage.inc"

ExecSound equ $0F80

Cmd_PlayA equ $4A
Cmd_PlayB equ $4B
Cmd_StopAll equ $4E

dseg
SoundScriptA:
	defb 0
	defb 0
SoundScriptB:
	defb 0
	defb 0

cseg
InitSound: public InitSound
    lda #4 | sta ($80)
    lda #$44 | jsr ExecSound
StopAll:
    lda #Cmd_StopAll | jsr ExecSound
rts

PlayA:
    lda #$ff | sta SoundScriptA+1
	lda #low SoundScriptA  | sta ($80)
	ldy #1
	lda #high SoundScriptA | sta ($80),y
	iny
	lda #0 | sta ($80),y		; BGM: 0 = Infinite loop
    ; The BIOS marks channel A as playing before it has loaded its work variables
    ; ($A7/$A8 are shared with the decoder), so an interrupt in between breaks the start.
    php | sei
    lda #Cmd_PlayA | jsr ExecSound
    plp
rts

PlayB:
    lda #$ff | sta SoundScriptB+1
	lda #low SoundScriptB  | sta ($80)
	ldy #1
	lda #high SoundScriptB | sta ($80),y
	iny
	lda #1 | sta ($80),y		; Sound effect: play once (0 = Infinite loop)
    lda #Cmd_PlayB | jsr ExecSound
rts

PlayBWait:
    jsr PlayB
    do
        lda $9b
        and #$08
    while ne | wend
rts

; void Sound_Fire();
cseg
Sound_Fire_: public Sound_Fire_
    lda $9b
    and #$08
    if eq
        lda #0 | sta SoundScriptB
        jsr PlayB
    endif
rts

; void Sound_SmallBang();
cseg
Sound_SmallBang_: public Sound_SmallBang_
    lda #1 | sta SoundScriptB
jmp PlayB

; void Sound_LargeBang();
cseg
Sound_LargeBang_: public Sound_LargeBang_
    lda #2 | sta SoundScriptB
jmp PlayB

; void Sound_Up();
cseg
Sound_Up_: public Sound_Up_
    lda #3 | sta SoundScriptB
jmp PlayB

; void Sound_Start();
cseg
Sound_Start_: public Sound_Start_
    lda #4 | sta SoundScriptB
jmp PlayBWait

; void Sound_GameOver();
cseg
Sound_GameOver_: public Sound_GameOver_
    lda #5 | sta SoundScriptB
jmp PlayBWait


; void StartBGM();
StartBGM_: public StartBGM_
    lda #6 | sta SoundScriptA
jmp PlayA

; void StopBGM();
cseg
StopBGM_: public StopBGM_
jmp StopAll
