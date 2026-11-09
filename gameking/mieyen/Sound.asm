include "GameKing.inc"
include "ZeroPage.inc"

ExecSound equ $0F80

Cmd_Rate equ $44
Cmd_PlayA equ $4A
Cmd_PlayB equ $4B
Cmd_Stop equ $4C
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
    lda #Cmd_Rate | jsr ExecSound
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
WaitB:
    do
        lda $9b
        and #$08
    while ne | wend
rts

PlayBForce:
    lda $9b
    and #$08
    if ne
        lda #2 | sta ($80)
        lda #Cmd_Stop | jsr ExecSound
    endif
jmp PlayB

; void Sound_Loose();
cseg
Sound_Loose_: public Sound_Loose_
    lda #0 | sta SoundScriptB
jmp PlayBWait

; void Sound_Hit();
cseg
Sound_Hit_: public Sound_Hit_
    lda #1 | sta SoundScriptB
jmp PlayBForce

; void Sound_Stole();
cseg
Sound_Stole_: public Sound_Stole_
    lda #2 | sta SoundScriptB
jmp PlayB

; void Sound_Fire();
cseg
Sound_Fire_: public Sound_Fire_
    lda #3 | sta SoundScriptB
jmp PlayBForce

; void Sound_Bonus();
cseg
Sound_Bonus_: public Sound_Bonus_
    lda #4 | sta SoundScriptB
jmp PlayBWait

; void Sound_Start();
cseg
Sound_Start_: public Sound_Start_
    lda #5 | sta SoundScriptB
jmp PlayBWait

; void Sound_Clear();
cseg
Sound_Clear_: public Sound_Clear_
    lda #6 | sta SoundScriptB
jmp PlayBWait

; void Sound_GameOver();
cseg
Sound_GameOver_: public Sound_GameOver_
    lda #7 | sta SoundScriptB
jmp PlayBWait


; void StartBGM();
StartBGM_: public StartBGM_
    lda #8 | sta SoundScriptA
jmp PlayA

; void StopBGM();
cseg
StopBGM_: public StopBGM_
    jsr WaitB
jmp StopAll
