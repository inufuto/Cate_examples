include "Atari7800.inc"
include "ZeroPage.inc"

Tempo equ 220/5
Tempo_denom equ 600/2/5
ChannelCount equ 3
EffectChannel equ 0
BackChannel equ 2
MaxValume equ 31

dseg
Channels: public Channels
Channel_NotesL:
    defs ChannelCount
Channel_NotesH:
    defs ChannelCount
Channel_Offset:
    defs ChannelCount
Channel_Len:
    defs ChannelCount
Channel_C:
    defs ChannelCount
Channel_F:
    defs ChannelCount
Channel_V:
    defs ChannelCount
Time:
    defb 0

zseg
pNotes:
    defw 0

cseg
InitSound: public InitSound
    ldx #0 | txa
    do
        sta Channel_NotesL,x
        sta Channel_NotesH,x
        sta Channel_V,x
        inx
        cpx #ChannelCount
    while ne | wend
    sta AUDV0 | sta AUDV1
    sta Time
rts


SoundHandler: public SoundHandler
    lda Time
    sec|sbc #Tempo
    sta Time
    if mi
        ldx #0
        do
            lda Channel_NotesL,x
            ora Channel_NotesH,x
            if ne
                dec Channel_Len,x
                if eq
                    lda Channel_NotesL,x | sta <pNotes
                    lda Channel_NotesH,x | sta <pNotes+1
                    continue:
                    ldy Channel_Offset,x | lda (<pNotes),y
                    if eq
                        ; end
                        sta Channel_NotesL,x
                        sta Channel_NotesH,x
                        offch:
                        sta Channel_V,x
                        cpx #EffectChannel
                        if eq
                            lda Channel_V+BackChannel
                            if ne
                                lsr a | sta AUDV0-1+BackChannel
                                lda Channel_C+BackChannel | sta AUDC0-1+BackChannel
                                lda Channel_F+BackChannel | sta AUDF0-1+BackChannel
                                jmp next
                            endif
                            lda #0 | sta AUDV0-1+BackChannel
                            jmp next
                        endif
                        lda #0 | sta AUDV0-1,x
                        jmp next
                    endif
                    cmp #$ff
                    if eq
                        ; repeat
                        lda #0 | sta Channel_Offset,x
                        jmp continue
                    endif
                    sta Channel_Len,x
                    iny
                    lda (<pNotes),y
                    iny
                    pha
                        tya | sta Channel_Offset,x
                    pla
                    cmp #0 ; rest
                    beq offch
                    sec|sbc #1
                    asl a
                    tay
                    lda Cycles,y | sta Channel_C,x
                    lda Cycles+1,y | sta Channel_F,x
                    lda #MaxValume | sta Channel_V,x
                    cpx #BackChannel
                    if eq
                        lda Channel_V+EffectChannel
                        bne EndWriteCycle
                    endif
                    cpx #EffectChannel
                    if eq
                        lda Channel_C,x | sta AUDC0-1+BackChannel
                        lda Channel_F,x | sta AUDF0-1+BackChannel
                        jmp EndWriteCycle
                    endif
                    lda Channel_C,x | sta AUDC0-1,x
                    lda Channel_F,x | sta AUDF0-1,x
                    EndWriteCycle:
                endif
                lda Channel_V,x
                if ne
                    sec|sbc #1
                    sta Channel_V,x
                    lsr a
                    cpx #EffectChannel
                    if eq
                        sta AUDV0-1+BackChannel
                        jmp next
                    endif
                    cpx #BackChannel
                    if eq
                        tay
                        lda Channel_V+EffectChannel
                        bne next
                        tya | sta AUDV0-1+BackChannel
                        jmp next
                    endif
                endif
                sta AUDV0-1,x
            endif
            next:
            inx
            cpx #ChannelCount
        while ne | wend
        lda Time
        clc|adc #Tempo_denom
        sta Time
    endif
rts

Melody:
    pha
        lda Channel_NotesL+EffectChannel
        ora Channel_NotesH+EffectChannel
        if eq
            jsr MelodyPrior
        endif
    pla
rts

MelodyPrior:
    pha
        sty Channel_NotesL+EffectChannel
        stx Channel_NotesH+EffectChannel
        lda #0 | sta Channel_Offset+EffectChannel
        lda #1 | sta Channel_Len+EffectChannel
    pla
rts

MelodyWait:
    jsr MelodyPrior
    pha
        do
            ; jsr PollVSync_
            lda Channel_NotesL+EffectChannel
            ora Channel_NotesH+EffectChannel
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
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
clear_notes:
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,A4
    defb N8,D4, N8,F4, N8,G4
    defb N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    defb N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,G4, N8,A4, N8,G4
    defb N2,F4, N2,G4, N2+N8,F4
    defb $ff

BGM_C:
    defb N4P,0
    defb N4P,F2, N4P,F2, N4,F2
    defb N4P,C3, N4P,C3, N4,C3
    defb N2,F2, N2,G2, N2+N8,A2, N4P,0
    defb N4P,A2, N4P,A2, N4,A2
    defb N4P,G2, N4P,G2, N4,G2
    defb N2,F2, N2,C3, N2+N8,F2
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        lda #low BGM_B | sta Channel_NotesL+1
        lda #high BGM_B | sta Channel_NotesH+1
        lda #0 | sta Channel_Offset+1
        lda #1 | sta Channel_Len+1
        
        lda #low BGM_C | sta Channel_NotesL+2
        lda #high BGM_C | sta Channel_NotesH+2
        lda #0 | sta Channel_Offset+2
        lda #1 | sta Channel_Len+2
    pla
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    pha
        ldx #0 | txa
        do
            sta Channel_NotesL,x
            sta Channel_NotesH,x
            sta Channel_V,x
            inx
            cpx #ChannelCount
        while ne | wend
        sta AUDV0 | sta AUDV1
    pla
rts


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

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
defb 1,24 ; E2
defb 1,23 ; F2
defb 1,22 ; F#2
defb 1,20 ; G2
defb 1,19 ; G#2
defb 1,18 ; A2
defb 1,17 ; A#2
defb 1,16 ; B2
defb 1,15 ; C3
defb 1,14 ; C#3
defb 1,14 ; D3
defb 1,13 ; D#3
defb 12,30 ; E3
defb 12,29 ; F3
defb 12,27 ; F#3
defb 12,26 ; G3
defb 12,24 ; G#3
defb 12,23 ; A3
defb 12,21 ; A#3
defb 12,20 ; B3
defb 12,19 ; C4
defb 12,18 ; C#4
defb 12,17 ; D4
defb 12,16 ; D#4
defb 12,15 ; E4
defb 12,14 ; F4
defb 12,14 ; F#4
defb 12,12 ; G4
defb 12,12 ; G#4
defb 12,11 ; A4
defb 12,11 ; A#4
defb 4,30 ; B4
defb 4,29 ; C5
defb 4,27 ; C#5
defb 4,26 ; D5
defb 4,24 ; D#5
defb 4,23 ; E5
defb 4,21 ; F5
defb 4,20 ; F#5
defb 4,19 ; G5
