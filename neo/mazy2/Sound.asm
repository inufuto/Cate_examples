include "neo6502.inc"
include "ZeroPage.inc"

pMelody equ ZW0
channel equ ZB0

EffectChannel equ 0
BGMChannel equ EffectChannel+1
MaxQ equ 8

dseg
ChannelPtr:
    defw 0
ChannelStart:
    defw 0


cseg
InitSound: public InitSound
    stz ChannelPtr
    stz ChannelPtr+1
rts


cseg
MakeQ1:
    sta API_PARAMETERS+3
    stz API_PARAMETERS+4
    stz API_PARAMETERS+5 | stz API_PARAMETERS+6 | stz API_PARAMETERS+7
    iny
    lda (<pMelody),y
    if ne
        asl a | tax
        lda Cycles-2,x | sta API_PARAMETERS+1
        lda Cycles-2+1,x | sta API_PARAMETERS+2
    else
        sta API_PARAMETERS+1 | sta API_PARAMETERS+2
    endif
    iny
    lda <channel | sta API_PARAMETERS+0
    lda #API_FN_QUEUE_SOUND | sta API_FUNCTION
    lda #API_GROUP_SOUND | sta API_COMMAND
rts

MakeQ:
    sta <channel
    sty <pMelody | stx <pMelody+1
    ldy #0
    do
        lda (<pMelody),y
    while ne
        jsr MakeQ1
    wend
rts

Melody:
    pha
        lda #EffectChannel
        jsr MakeQ
    pla
rts

ReadStatus:
    lda <channel
    sta API_PARAMETERS+0
    lda #API_FN_SOUND_STATUS | sta API_FUNCTION
    lda #API_GROUP_SOUND | sta API_COMMAND
    jsr WaitMessage
    lda API_PARAMETERS+0
rts

MelodyWait:
    jsr Melody
    pha
        do
            jsr ReadStatus
        while ne | wend
    pla
rts


; void Sound_Beep();
beep_notes:
    defb 2,A4, 1,0, 0
Sound_Beep_: public Sound_Beep_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Get();
Sound_Get_: public Sound_Get_
    ldy #low beep_notes
    ldx #high beep_notes
jmp Melody


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody


; void Sound_Loose();
loose_notes:
    defb 2,C4, 1,0, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
	defb 12,C4,1,0, 12,G4,1,0, 12,E4,1,0, 12,G4,1,0
	defb 53,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
clear_notes:
	defb 12,C4,1,0, 12,E4,1,0, 12,G4,1,0, 12,D4,1,0
	defb 12,F4,1,0, 12,A4,1,0, 12,E4,1,0, 12,G4,1,0
	defb 12,B4,1,0, 39,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
over_notes:
	defb 12,C5,1,0, 12,G4,1,0, 12,E4,1,0, 12,C5,1,0
	defb 12,B4,1,0, 12,G4,1,0, 12,E4,1,0, 12,B4,1,0
	defb 26,A4,1,0, 26,B4,1,0
	defb 53,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
	defb 12,D4,1,0, 12,F4,1,0, 12,G4,1,0, 12,A4,1,0
	defb 12,A4,1,0, 12,A4,1,0, 12,A4,1,0, 12,A4,1,0
	defb 12,A4,1,0, 12,A4,1,0, 12,A4,1,0, 12,G4,1,0
	defb 12,G4,1,0, 12,G4,1,0, 12,G4,1,0, 12,G4,1,0
	defb 12,G4,1,0, 12,A4,1,0, 12,G4,1,0, 53,F4,1,0
	defb 53,G4,1,0
	defb 67,A4,1,0
	defb 12,D4,1,0, 12,F4,1,0, 12,G4,1,0, 12,A4,1,0
	defb 12,A4,1,0, 12,A4,1,0, 12,A4,1,0, 12,A4,1,0
	defb 12,A4,1,0, 12,A4,1,0, 12,A4,1,0, 12,G4,1,0
	defb 12,G4,1,0, 12,G4,1,0, 12,G4,1,0, 12,G4,1,0
	defb 12,G4,1,0, 12,A4,1,0, 12,G4,1,0, 53,F4,1,0
	defb 53,G4,1,0
	defb 67,F4,1,0
    defb $ff

; void StartBGM();
cseg
StartBGM_: public StartBGM_
    pha
        lda #low BGM_B | sta ChannelStart | sta ChannelPtr
        lda #high BGM_B | sta ChannelStart+1 | sta ChannelPtr+1
    pla
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    pha
        jsr InitSound
        lda #API_FN_RESET_SOUND | sta API_FUNCTION
        lda #API_GROUP_SOUND | sta API_COMMAND
    pla
rts


; void ContinueBGM();
cseg
ContinueBGM_: public ContinueBGM_
    lda #BGMChannel | sta <channel
    lda ChannelPtr
    ora ChannelPtr+1
    if ne
        do
            jsr ReadStatus
            cmp #MaxQ
        while cc
            lda ChannelPtr | sta <pMelody
            lda ChannelPtr+1 | sta <pMelody+1
            ldy #0 | lda (<pMelody),y
            cmp #$ff
            if eq
                lda ChannelStart | sta ChannelPtr | sta <pMelody
                lda ChannelStart+1 | sta ChannelPtr+1 | sta <pMelody+1
                lda (<pMelody),y
            endif
            jsr MakeQ1
            lda <pMelody | clc | adc #2 | sta ChannelPtr
            lda <pMelody+1 | adc #0 | sta ChannelPtr+1
        wend
    endif
rts



E2 equ 1
F2 equ 2
F2S equ 3
G2 equ 4
G2S equ 5
A2 equ 6
A2S equ 7
B2 equ 8
C3 equ 9
C3S equ 10
D3 equ 11
D3S equ 12
E3 equ 13
F3 equ 14
F3S equ 15
G3 equ 16
G3S equ 17
A3 equ 18
A3S equ 19
B3 equ 20
C4 equ 21
C4S equ 22
D4 equ 23
D4S equ 24
E4 equ 25
F4 equ 26
F4S equ 27
G4 equ 28
G4S equ 29
A4 equ 30
A4S equ 31
B4 equ 32
C5 equ 33
C5S equ 34
D5 equ 35
D5S equ 36
E5 equ 37
F5 equ 38
F5S equ 39
G5 equ 40

Cycles:
defw 82 ; E2
defw 87 ; F2
defw 92 ; F#2
defw 98 ; G2
defw 104 ; G#2
defw 110 ; A2
defw 117 ; A#2
defw 123 ; B2
defw 131 ; C3
defw 139 ; C#3
defw 147 ; D3
defw 156 ; D#3
defw 165 ; E3
defw 175 ; F3
defw 185 ; F#3
defw 196 ; G3
defw 208 ; G#3
defw 220 ; A3
defw 233 ; A#3
defw 247 ; B3
defw 262 ; C4
defw 277 ; C#4
defw 294 ; D4
defw 311 ; D#4
defw 330 ; E4
defw 349 ; F4
defw 370 ; F#4
defw 392 ; G4
defw 415 ; G#4
defw 440 ; A4
defw 466 ; A#4
defw 494 ; B4
defw 523 ; C5
defw 554 ; C#5
defw 587 ; D5
defw 622 ; D#5
defw 659 ; E5
defw 698 ; F5
defw 740 ; F#5
defw 784 ; G5
