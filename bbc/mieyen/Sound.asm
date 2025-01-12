ext WaitTimer_

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

MinVolume equ 63

tempo equ 180/2
denom equ 600/2/2

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time: 
    defb 0

zseg
reg:
    defb 0
pMelody:
    defw 0

cseg
Write:
    pha
        lda #$ff | sta $fe43
    pla
    sta $fe4f
    pha
        lda #0 | sta $fe40
        nop | nop | nop | nop
        lda #8 | sta $fe40
    pla
rts


cseg
InitSound: public InitSound
    ldx #0
    do
        lda #0
        sta Channels+Channel_Ptr,x
        sta Channels+Channel_Ptr+1,x
        txa | clc|adc #unitSize | tax    
        cpx #unitSize*count
    while ne | wend
    lda #0 | sta time

    ldx #count
    lda #Dcsg_VolumeA or $8f
    do
        jsr Write
        clc|adc #$20
        dex
    while ne | wend
rts


SoundHandler: public SoundHandler
    lda time
    sec | sbc #tempo
    if cs
        pha
            ldx #0
            lda #Dcsg_ToneA | sta <reg
            do
                lda Channels+Channel_Ptr,x
                ora Channels+Channel_Ptr+1,x
                if ne
                    dec Channels+Channel_Len,x
                    if eq
                        continue:
                        lda Channels+Channel_Ptr,x | sta <pMelody
                        lda Channels+Channel_Ptr+1,x | sta <pMelody+1
                        ldy #0
                        lda (<pMelody),y
                        if eq
                            ; end
                            sta Channels+Channel_Ptr,x
                            sta Channels+Channel_Ptr+1,x
                            lda <reg
                            ora #$9f
                            jsr Write
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda Channels+Channel_Start,x | sta Channels+Channel_Ptr,x
                            lda Channels+Channel_Start+1,x | sta Channels+Channel_Ptr+1,x
                            jmp continue
                        endif
                        sta Channels+Channel_Len,x
                        iny
                        lda (pMelody),y
                        pha
                            lda Channels+Channel_Ptr,x | clc|adc #2 | sta Channels+Channel_Ptr,x
                            lda Channels+Channel_Ptr+1,x | adc #0 | sta Channels+Channel_Ptr+1,x
                        pla
                        cmp #0
                        if ne
                            sec|sbc #1
                            asl a
                            tay
                            lda <reg
                            ora #$80
                            ora cycles,y
                            jsr Write
                            lda cycles+1,y
                            jsr Write
                            lda <reg
                            lda #0
                        else
                            lda #MinVolume
                        endif
                        sta Channels+Channel_Vol,x
                        EndWriteCycle:
                    endif
                    lda Channels+Channel_Vol,x
                    lsr a | lsr a
                    ora <reg
                    ora #$90
                    jsr Write
                    lda Channels+Channel_Vol,x
                    cmp #MinVolume
                    if ne
                        clc|adc #1
                        sta Channels+Channel_Vol,x
                    endif
                endif
                next:
                lda <reg
                clc|adc #$20
                sta <reg
                txa | clc|adc #unitSize | tax
                cpx #unitSize*count
            while ne | wend
        pla
        clc|adc #denom
    endif
    sta time
rts


Melody:
    sei
        sty Channels+Channel_Ptr
        stx Channels+Channel_Ptr+1
        lda #1
        sta Channels+Channel_Len
    cli
rts

MelodyWait:
    jsr Melody
    do
        lda Channels+Channel_Ptr
        ora Channels+Channel_Ptr+1
    while ne | wend
rts


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pha
        ldy #low loose_notes
        ldx #high loose_notes
        jsr MelodyWait
    pla
rts


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    pha
        ldy #low hit_notes
        ldx #high hit_notes
        jsr Melody
    pla
rts


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    pha
        ldy #low stole_notes
        ldx #high stole_notes
        jsr Melody
    pla
rts


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    pha
        ldy #low fire_notes
        ldx #high fire_notes
        jsr Melody
    pla
rts


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    pha
        ldy #low bonus_notes
        ldx #high bonus_notes
        jsr MelodyWait
    pla
rts


; void Sound_Start();
start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pha
        ldy #low start_notes
        ldx #high start_notes
        jsr MelodyWait
    pla
rts


; void Sound_Clear();
clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pha
        ldy #low clear_notes
        ldx #high clear_notes
        jsr MelodyWait
    pla
rts


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pha
        ldy #low over_notes
        ldx #high over_notes
        jsr MelodyWait
    pla
rts


BGM_B:
    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,D4, N4,D4, N8,D4, N4,E4, N4P,D4
    defb N2P,0

    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,F4, N4,F4, N8,F4, N4,A4, N4P,G4
    defb N2P,0

    defb N8,E4, N8,E4, N8,E4, N4,E4, N8,E4, N4,A4
    defb N8,D4, N8,D4, N8,D4, N4,D4, N8,D4, N4,G4
    defb N8,0, N8,A4, N8,0, N8,G4, N8,0, N8,F4, N8,0, N8,E4
    defb N4,D4, N4,E4, N2,C4

    defb $ff
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 3
    defb N8,A3, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G3, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A3, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G3, N4,0, N8,G3; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A3, N4,0, N8,A3; 11
    defb N8,D3, N4,0, N8,D3, N8,G3, N4,0, N8,G3; 12
    defb N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,G3, N8,0, N8,G3
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14
    defb $ff

StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            lda #low BGM_B
            sta Channels+unitSize*1+Channel_Ptr
            sta Channels+unitSize*1+Channel_Start
            lda #high BGM_B
            sta Channels+unitSize*1+Channel_Ptr+1
            sta Channels+unitSize*1+Channel_Start+1
            stx Channels+unitSize*1+Channel_Len
            lda #low BGM_C
            sta Channels+unitSize*2+Channel_Ptr
            sta Channels+unitSize*2+Channel_Start
            lda #high BGM_C
            sta Channels+unitSize*2+Channel_Ptr+1
            sta Channels+unitSize*2+Channel_Start+1
            stx Channels+unitSize*2+Channel_Len
        cli
    pla
rts


StopBGM_: public StopBGM_
    pha
        sei
            lda #0
            sta Channels+unitSize*1+Channel_Ptr
            sta Channels+unitSize*1+Channel_Ptr+1
            sta Channels+unitSize*2+Channel_Ptr
            sta Channels+unitSize*2+Channel_Ptr+1

            ldx #count
            lda #Dcsg_VolumeB or $8f
            do
                jsr Write
                clc|adc #$20
                dex
            while ne | wend
        cli
    pla
rts


B2 equ 1
C3 equ 2
C3S equ 3
D3 equ 4
D3S equ 5
E3 equ 6
F3 equ 7
F3S equ 8
G3 equ 9
G3S equ 10
A3 equ 11
A3S equ 12
B3 equ 13
C4 equ 14
C4S equ 15
D4 equ 16
D4S equ 17
E4 equ 18
F4 equ 19
F4S equ 20
G4 equ 21
G4S equ 22
A4 equ 23
A4S equ 24
B4 equ 25
C5 equ 26
C5S equ 27
D5 equ 28
D5S equ 29
E5 equ 30
F5 equ 31
F5S equ 32
G5 equ 33

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 4,63 ; B2
defb 11,59 ; C3
defb 5,56 ; C#3
defb 3,53 ; D3
defb 3,50 ; D#3
defb 6,47 ; E3
defb 11,44 ; F3
defb 3,42 ; F#3
defb 13,39 ; G3
defb 9,37 ; G#3
defb 8,35 ; A3
defb 8,33 ; A#3
defb 10,31 ; B3
defb 13,29 ; C4
defb 2,28 ; C#4
defb 9,26 ; D4
defb 1,25 ; D#4
defb 11,23 ; E4
defb 5,22 ; F4
defb 1,21 ; F#4
defb 14,19 ; G4
defb 12,18 ; G#4
defb 12,17 ; A4
defb 12,16 ; A#4
defb 13,15 ; B4
defb 14,14 ; C5
defb 1,14 ; C#5
defb 4,13 ; D5
defb 8,12 ; D#5
defb 13,11 ; E5
defb 2,11 ; F5
defb 8,10 ; F#5
defb 15,9 ; G5
