ViaAcrPort equ $E84B
OctavePort equ $E84A
CyclePort equ $E848
OffValue equ $c0
OnValue equ OffValue or $10

tempo equ 180/2
tempo_denom equ 600/4

Count equ 2

dseg
Channels: public Channels
Channel_StartL:
    defs Count
Channel_StartH:
    defs Count
Channel_Offset:
    defs Count
Channel_Octave:
    defs Count
Channel_Cycle:
    defs Count
Channel_Len:
    defs Count
Time:
    defb 0

zseg
pMelody:
    defw 0

cseg
InitSound: public InitSound
    sei
        lda #0
        sta time
        tax
        do
            sta Channel_StartL,x
            sta Channel_StartH,x
            sta Channel_Octave,x
            inx | cpx #Count
        while ne | wend
    cli
rts


SoundHandler: public SoundHandler
    lda Time
    sec | sbc #tempo
    sta Time
    if cc
        ldx #0 ; Channel
        do
            lda Channel_StartL,x
            ora Channel_StartH,x
            if ne
                dec Channel_Len,x
                if eq
                    lda Channel_StartL,x | sta <pMelody
                    lda Channel_StartH,x | sta <pMelody+1
                    continue:
                    ldy Channel_Offset,x
                    lda (<pMelody),y
                    if eq
                        ; end
                        sta Channel_StartL,x
                        sta Channel_StartH,x
                        offch:
                        sta Channel_Octave,x
                        cpx #0
                        if eq
                            lda Channel_Octave+1
                            if ne
                                pha
                                    lda #OnValue | sta ViaAcrPort
                                pla
                                sta OctavePort
                                lda Channel_Cycle+1 | sta CyclePort
                                jmp next
                            endif
                        endif
                        lda #OffValue | sta ViaAcrPort
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
                    lda (<pMelody),y
                    iny
                    pha
                        tya
                        sta Channel_Offset,x
                    pla
                    cmp #0
                    beq offch
                                        _deb: public _deb
                    tay
                    dey
                    lda Octerves,y
                    sta Channel_Octave,x
                    lda Cycles,y
                    sta Channel_Cycle,x
                    cpx #1
                    if eq
                        lda Channel_Octave
                        bne next
                    endif
                    pha
                        lda #OnValue | sta ViaAcrPort
                    pla
                    lda Channel_Octave,x | sta OctavePort
                    lda Channel_Cycle,x | sta CyclePort
                endif
            endif
            next:
            inx
            cpx #Count
        while ne | wend
        lda time
        clc | adc #tempo_denom
        sta time
    endif
rts

Melody:
    pha
        lda Channel_StartL
        ora Channel_StartH
        if eq
            jsr MelodyPrior
        endif
    pla
rts

MelodyPrior:
    sei
        sty Channel_StartL
        stx Channel_StartH
        ldy #0 | sty Channel_Offset
        iny | sty Channel_Len
    cli
rts

MelodyWait:
    jsr MelodyPrior
    pha
        do
            lda Channel_StartL
            ora Channel_StartH
        while ne | wend
    pla
rts


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp MelodyPrior


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    ldy #low stole_notes
    ldx #high stole_notes
jmp Melody


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    ldy #low fire_notes
    ldx #high fire_notes
jmp Melody


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    ldy #low bonus_notes
    ldx #high bonus_notes
jmp MelodyWait


; void Sound_Start();
start_notes:
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait


; void Sound_Clear();
clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait


; void Sound_GameOver();
over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        sei
            lda #low BGM_B | sta Channel_StartL+1
            lda #high BGM_B | sta Channel_StartH+1
            ldy #0 | sty Channel_Offset+1
            iny | sty Channel_Len+1
        cli
    pla
rts


; void StopBGM();
StopBGM_: public StopBGM_
    pha
        sei
            lda #0
            sta Channel_StartL+1
            sta Channel_StartH+1
            sta Channel_Octave+1
            lda #OffValue | sta ViaAcrPort
        cli
    pla
rts


A3 equ 1
A3S equ 2
B3 equ 3
C4 equ 4
C4S equ 5
D4 equ 6
D4S equ 7
E4 equ 8
F4 equ 9
F4S equ 10
G4 equ 11
G4S equ 12
A4 equ 13
A4S equ 14
B4 equ 15
C5 equ 16
C5S equ 17
D5 equ 18
D5S equ 19
E5 equ 20
F5 equ 21
F5S equ 22
G5 equ 23

Octerves:
defb 15 ; G3
defb 15 ; G3S
defb 15 ; A3
defb 15 ; A3S
defb 15 ; B3
defb 15 ; C4
defb 15 ; C4S
defb 15 ; D4
defb 15 ; D4S
defb 15 ; E4
defb 15 ; F4
defb 15 ; F4S
defb 15 ; G4
defb 15 ; G4S
defb 15 ; A4
defb 15 ; A4S
defb 51 ; B4
defb 51 ; C5
defb 51 ; C5S
defb 51 ; D5
defb 51 ; D5S
defb 51 ; E5
defb 51 ; F5
defb 51 ; F5S
defb 51 ; G5

Cycles:
defb 158 ; G3
defb 149 ; G#3
defb 140 ; A3
defb 133 ; A#3
defb 125 ; B3
defb 118 ; C4
defb 110 ; C#4
defb 104 ; D4
defb 99 ; D#4
defb 93 ; E4
defb 88 ; F4
defb 83 ; F#4
defb 78 ; G4
defb 74 ; G#4
defb 69 ; A4
defb 65 ; A#4
defb 125 ; B4
defb 118 ; C5
defb 110 ; C#5
defb 104 ; D5
defb 99 ; D#5
defb 93 ; E5
defb 88 ; F5
defb 83 ; F#5
defb 78 ; G5
