include "Zeropage.inc"

Tempo equ 220/4
Tempo_denom equ 600/4
ChannelCount equ 3

Tone1LPort equ $ff0e
Tone2LPort equ $ff0f
Tone2HPort equ $ff10
VolumePort equ $ff11
Tone1HPort equ $ff12
VolumeValue equ $08
Volume1Bit equ $10
Volume2Bit equ $20

dseg
Channels: public Channels
Channel_CurrentL:
    defs ChannelCount
Channel_CurrentH:
    defs ChannelCount
Channel_StartL:
    defs ChannelCount
Channel_StartH:
    defs ChannelCount
Channel_ToneL:
    defs ChannelCount
Channel_ToneH:
    defs ChannelCount
Channel_Len:
    defs ChannelCount
Time:
    defb 0

zseg
pNotes:
    defw 0

cseg
TedTable: ; lo, hi, bit(#2)
    defb 14,18,$20
    defb 15,16,$10

InitSound: public InitSound
    ldx #0
    do
        lda #0
        sta Channel_CurrentL,x
        sta Channel_CurrentH,x
        sta Channel_ToneL,x
        sta Channel_ToneH,x
        inx
        cpx #ChannelCount
    while ne | wend
    sta Time
    
    lda #VolumeValue | sta VolumePort
rts


SoundHandler: public SoundHandler
    lda Time
    sec | sbc #Tempo
    sta Time
    if cc
        ldx #0
        do
            lda Channel_CurrentL,x
            ora Channel_CurrentH,x
            if ne
                dec Channel_Len,x
                if eq
                    continue:
                    lda Channel_CurrentL,x | sta <pNotes+0
                    lda Channel_CurrentH,x | sta <pNotes+1
                    ldy #0 | lda (<pNotes),y
                    if eq
                        ; end
                        sta Channel_CurrentL,x
                        sta Channel_CurrentH,x
                        offch:
                        sta Channel_ToneL,x
                        sta Channel_ToneH,x
                        cpx #0
                        if eq
                            lda Channel_ToneL+1
                            ora Channel_ToneH+1
                            if ne
                                sta Tone1LPort
                                lda Tone1HPort
                                and #$fc | ora Channel_ToneH+1
                                sta Tone1HPort
                                lda VolumePort | ora #Volume1Bit | sta VolumePort
                                jmp next
                            endif
                        endif
                        cpx #2
                        if ne
                            lda VolumePort | and #not Volume1Bit | sta VolumePort
                            jmp next
                        else
                            lda VolumePort | and #not Volume2Bit | sta VolumePort
                            jmp next
                        endif
                    endif
                    cmp #$ff
                    if eq
                        ; repeat
                        lda Channel_StartL,x | sta Channel_CurrentL,x
                        lda Channel_StartH,x | sta Channel_CurrentH,x
                        jmp continue
                    endif
                    sta Channel_Len,x
                    lda <pNotes | clc|adc #2 | sta Channel_CurrentL,x
                    lda <pNotes+1 | adc #0 | sta Channel_CurrentH,x
                    iny | lda (<pNotes),y
                    cmp #0
                    beq offch
                    sec|sbc #1
                    asl a
                    tay
                    lda Tones,y | sta Channel_ToneL,x
                    lda Tones+1,y | sta Channel_ToneH,x
                    cpx #1
                    if eq
                        lda Channel_ToneL+0
                        ora Channel_ToneH+0
                        beq onch2
                    endif
                    cpx #2
                    if eq
                        lda Channel_ToneL,x | sta Tone2LPort
                        lda Channel_ToneH,x | sta Tone2HPort
                        lda VolumePort | ora #Volume2Bit | sta VolumePort
                        jmp EndWriteTone
                    endif
                    onch2:
                    lda Channel_ToneL,x | sta Tone1LPort
                    lda Tone1HPort
                    and #$fc | ora Channel_ToneH,x
                    sta Tone1HPort
                    lda VolumePort | ora #Volume1Bit | sta VolumePort
                    EndWriteTone:
                endif
            endif
            next:
            inx
            cpx #ChannelCount
        while ne | wend
        lda Time
        clc | adc #Tempo_denom
        sta Time
    endif
rts

Melody:
    pha
        lda Channel_CurrentL+0
        ora Channel_CurrentH+0
        if eq
            jsr MelodyPrior
        endif
    pla
rts

MelodyPrior:
    pha
        sei
            sty Channel_CurrentL+0
            stx Channel_CurrentH+0
            lda #1 | sta Channel_Len+0
        cli
    pla
rts

MelodyWait:
    jsr MelodyPrior
    pha
        do
            lda Channel_CurrentL+0
            ora Channel_CurrentH+0
        while ne | wend
    pla
rts


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldy #low beep_notes
    ldx #high beep_notes
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
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
clear_notes:
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
	defb 5,D4,1,0, 5,F4,1,0, 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,A4,1,0, 5,D4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0, 5,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 23,F4,1,0, 23,G4,1,0
	defb 35,F4,1,0
    defb $ff
BGM_C:
	defb 18,0, 17,F3,1,0, 17,F3,1,0
	defb 11,F3,1,0, 17,C3,1,0, 17,C3,1,0
	defb 11,C3,1,0, 23,F3,1,0, 23,G3,1,0
	defb 35,A2,1,0, 18,0
	defb 17,A2,1,0, 17,A2,1,0, 11,A2,1,0
	defb 17,G3,1,0, 17,G3,1,0, 11,G3,1,0
	defb 23,F3,1,0, 23,C3,1,0
	defb 35,F3,1,0
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    sei
        lda #low BGM_B | sta Channel_CurrentL+1 | sta Channel_StartL+1
        lda #high BGM_B | sta Channel_CurrentH+1 | sta Channel_StartH+1
        lda #1 | sta Channel_Len+1

        lda #low BGM_C | sta Channel_CurrentL+2 | sta Channel_StartL+2
        lda #high BGM_C | sta Channel_CurrentH+2 | sta Channel_StartH+2
        lda #1 | sta Channel_Len+2
    cli
rts


; void StopBGM();
StopBGM_: public StopBGM_
    sei
        lda #0
        ldx #1
        do
            sta Channel_CurrentL,x
            sta Channel_CurrentH,x
            sta Channel_ToneL,x
            sta Channel_ToneH,x
            inx
            cpx #ChannelCount
        while ne | wend
        lda #VolumeValue | sta VolumePort
    cli
rts


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2


A2 equ 1
A2S equ 2
B2 equ 3
C3 equ 4
C3S equ 5
D3 equ 6
D3S equ 7
E3 equ 8
F3 equ 9
F3S equ 10
G3 equ 11
G3S equ 12
A3 equ 13
A3S equ 14
B3 equ 15
C4 equ 16
C4S equ 17
D4 equ 18
D4S equ 19
E4 equ 20
F4 equ 21
F4S equ 22
G4 equ 23
G4S equ 24
A4 equ 25
A4S equ 26
B4 equ 27
C5 equ 28
C5S equ 29
D5 equ 30
D5S equ 31
E5 equ 32
F5 equ 33
F5S equ 34
G5 equ 35

Tones:
defw 7 ; A2
defw 64 ; A#2
defw 118 ; B2
defw 169 ; C3
defw 217 ; C#3
defw 262 ; D3
defw 305 ; D#3
defw 345 ; E3
defw 383 ; F3
defw 419 ; F#3
defw 453 ; G3
defw 485 ; G#3
defw 516 ; A3
defw 544 ; A#3
defw 571 ; B3
defw 596 ; C4
defw 620 ; C#4
defw 643 ; D4
defw 664 ; D#4
defw 685 ; E4
defw 704 ; F4
defw 722 ; F#4
defw 739 ; G4
defw 755 ; G#4
defw 770 ; A4
defw 784 ; A#4
defw 798 ; B4
defw 810 ; C5
defw 822 ; C#5
defw 834 ; D5
defw 844 ; D#5
defw 854 ; E5
defw 864 ; F5
defw 873 ; F#5
defw 881 ; G5
