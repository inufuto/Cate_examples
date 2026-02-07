; include "ZeroPage.inc"
include "Port.inc"

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

HighNoise equ 0f0h
LowNoise equ 0f1h

MinVolume equ 63
HighNoiseValue equ 0e4h
LowNoiseValue equ 0e5h


Tempo equ 180/2
Denom equ 600/2/2

Count equ 3

dseg
Channels: public Channels
ChannelPtrL:
    defs Count
ChannelPtrH:
    defs Count
ChannelStartL:
    defs Count
ChannelStartH:
    defs Count
ChannelLen:
    defs Count
ChannelVol:
    defs Count
Time:
    defb 0
NoiseVolume:
    defb 0
ShootingTone:
    defw 0

zseg
reg:
    defb 0
pMelody:
    defw 0
toneL:
    defb 0


cseg
Init equ $fe57
PreparePort equ $fe67
Write equ $fe77

cseg
InitSound: public InitSound
    ldx #0 | txa
    sta Time
    sta ShootingTone | sta ShootingTone+1
    do
        sta ChannelPtrL,x
        sta ChannelPtrH,x
        inx
        cpx #Count
    while ne | wend

    jsr PreparePort
    jsr Init
    lda #MinVolume | sta NoiseVolume
rts


SoundHandler: public SoundHandler
    lda ShootingTone
    bne onShooting
    lda ShootingTone+1
    if ne
        onShooting:
        jsr PreparePort
        lda ShootingTone | sta <toneL
        and #$0f | ora #$80
        jsr Write
        lda ShootingTone+1
        asl <toneL | rol a
        asl <toneL | rol a
        asl <toneL | rol a
        asl <toneL | rol a
        and #$3f
        jsr Write

        lda ShootingTone | clc|adc #15 | sta ShootingTone
        lda ShootingTone+1 | adc #0 | sta ShootingTone+1
        beq highzero
        lda ShootingTone
        cmp #260-256
        if cs
            lda #Dcsg_VolumeA or $8f
            jsr Write
            lda #0 | sta ShootingTone | sta ShootingTone+1
        endif
        highzero:
    endif

    lda Time
    sec | sbc #Tempo
    if cs
        pha
            jsr PreparePort
            ldx #0
            lda #Dcsg_ToneA | sta <reg
            do
                lda ChannelPtrL,x
                ora ChannelPtrH,x
                if ne
                    dec ChannelLen,x
                    if eq
                        continue:
                        lda ChannelPtrL,x | sta <pMelody
                        lda ChannelPtrH,x | sta <pMelody+1
                        ldy #0
                        lda (<pMelody),y
                        if eq
                            ; end
                            sta ChannelPtrL,x
                            sta ChannelPtrH,x
                            lda <reg
                            ora #$9f
                            jsr Write
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda ChannelStartL,x | sta ChannelPtrL,x
                            lda ChannelStartH,x | sta ChannelPtrH,x
                            jmp continue
                        endif
                        sta ChannelLen,x
                        iny
                        lda (pMelody),y
                        pha
                            lda ChannelPtrL,x | clc|adc #2 | sta ChannelPtrL,x
                            lda ChannelPtrH,x | adc #0 | sta ChannelPtrH,x
                        pla
                        cmp #HighNoise
                        if eq
                            lda #HighNoiseValue
                            WriteNoise:
                            jsr Write
                            lda #0 | sta NoiseVolume
                            lda #MinVolume | sta ChannelVol,x
                            jmp EndWriteCycle
                        endif
                        cmp #LowNoise
                        if eq
                            lda #LowNoiseValue
                            jmp WriteNoise
                        endif
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
                        sta ChannelVol,x
                        EndWriteCycle:
                    endif
                    lda ChannelVol,x
                    lsr a | lsr a
                    ora <reg
                    ora #$90
                    jsr Write
                    lda ChannelVol,x
                    cmp #MinVolume
                    if ne
                        inc ChannelVol,x
                    endif
                endif
                next:
                lda <reg
                clc|adc #$20
                sta <reg
                inx
                cpx #Count
            while ne | wend
            lda NoiseVolume
            lsr a | lsr a
            ora #$80 or Dcsg_NoiseVolume
            jsr Write
            lda NoiseVolume
            cmp #MinVolume
            if ne
                inc NoiseVolume
            endif
        pla
        clc|adc #Denom
    endif
    sta Time
rts


Melody: ; (xy)
    pha
        sei
            sty ChannelPtrL+0
            stx ChannelPtrH+0
            lda #1
            sta ChannelLen+0
            lda #0 | sta ShootingTone | sta ShootingTone+1
        cli
    pla
rts

MelodyWait:
    jsr Melody
    pha
        do
            lda ChannelPtrL+0
            ora ChannelPtrH+0
        while ne | wend
    pla
rts


Sound_Fire_: public Sound_Fire_
    pha
        lda ChannelPtrL+0
        ora ChannelPtrH+0
        if eq
            sei
                jsr PreparePort
                lda #110 | sta ShootingTone
                lda #0 | sta ShootingTone+1
                lda #Dcsg_VolumeA or $80
                jsr Write
            cli
        endif
    pla
rts


smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    ldy #low smallExplosion_notes
    ldx #high smallExplosion_notes
jmp Melody


largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    ldy #low largeExplosion_notes
    ldx #high largeExplosion_notes
jmp Melody


up_notes:
    defb 1,C4, 1,C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    ldy #low up_notes
    ldx #high up_notes
jmp Melody


start_notes: 
    defb N8,A4, N8,G4, N8,A4, N4,C5, N8,E5, N2,D5,  N8,0, N4,C5, N8,C5, N4,D5
    defb 0
Sound_Start_: public Sound_Start_
    pha
        ldy #low start_notes
        ldx #high start_notes
        jsr MelodyWait
    pla
rts


clear_notes: 
    defb N8,E4, N8,G4, N8,C5, N8,A4, N8,0, N8,A4, N8,0, N8,G4,  N8,0, N8,G4, N8,0, N8,G4, N8,0, N8,G4, N4,A4
    defb 0
Sound_Clear_: public Sound_Clear_
    pha
        ldy #low clear_notes
        ldx #high clear_notes
        jsr MelodyWait
    pla
rts


over_notes: 
    defb N8,E4, N8,E4, N8,G4, N4,E4, N8,C5, N8,B4, N8,A4,  N8,G4, N8,A4, N8,0, N4,A4, N8,G4, N4,A4
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pha
        ldy #low over_notes
        ldx #high over_notes
        jsr MelodyWait
    pla
rts


BGM_B:
    defb N8,A4, N8,A4, N8,C5, N8,A4, N8,C5, N4,A4, N8,0,  N8,G4, N4,G4, N4,G4, N8,G4, N4,A4
    defb N8,A4, N8,A4, N8,C5, N8,A4, N8,C5, N4,D5, N8,0,  N8,E5, N4,E5, N4,E5, N8,D5, N4,E5
    defb N8,A4, N8,A4, N8,C5, N8,A4, N8,C5, N4,A4, N8,0,  N8,G4, N4,G4, N4,G4, N8,G4, N4,A4
    defb N8,A4, N8,A4, N8,C5, N8,A4, N8,C5, N4,D5, N8,0,  N8,E5, N4,E5, N4,E5, N8,D5, N4,E5
    defb N8,D5, N8,D5, N8,D5, N4,D5, N8,C5, N4,D5,  N8,D5, N8,D5, N8,D5, N4,D5, N8,C5, N4,D5
    defb N8,A4, N8,A4, N8,A4, N4,A4, N8,G4, N4,A4,  N8,A4, N8,A4, N8,A4, N4,A4, N8,G4, N4,A4
    defb N8,D5, N8,D5, N8,D5, N4,D5, N8,C5, N4,D5,  N8,D5, N8,D5, N8,D5, N4,D5, N8,C5, N4,D5
    defb N8,E5, N8,E5, N4,E5, N8,D5, N4P,E5,  N8,F5, N4,F5, 15*2,E5
    defb $ff

BGM_C:
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2,  N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3,  N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2,  N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3,  N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2
    defb N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0,  N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0
    defb N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0,  N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0
    defb N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0,  N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0
    defb N8,A2, N8,0, N8,A2, N8,0, N8,E2, N8,0, N8,E2, N8,0,  N8,C3, N8,B2, N8,0, N2,A2, N8,0
    defb $ff

StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            lda #low BGM_B
            sta ChannelPtrL+1
            sta ChannelStartL+1
            lda #high BGM_B
            sta ChannelPtrH+1
            sta ChannelStartH+1
            stx ChannelLen+1
            
            lda #low BGM_C
            sta ChannelPtrL+2
            sta ChannelStartL+2
            lda #high BGM_C
            sta ChannelPtrH+2
            sta ChannelStartH+2
            stx ChannelLen+2
        cli
    pla
rts


StopBGM_: public StopBGM_
    pha
        sei
            lda #0
            sta ChannelPtrL+1
            sta ChannelPtrH+1
            sta ChannelPtrL+2
            sta ChannelPtrH+2

            jsr PreparePort
            
            ldx #count
            lda #Dcsg_VolumeB or $8f
            do
                pha
                    jsr Write
                pla
                clc|adc #$20
                dex
            while ne | wend
        cli
    pla
rts


N8 equ 6
N8L equ 8
N8R equ 4
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


cycles:
defb 6,47 ; E2
defb 11,44 ; F2
defb 3,42 ; F#2
defb 13,39 ; G2
defb 9,37 ; G#2
defb 8,35 ; A2
defb 8,33 ; A#2
defb 10,31 ; B2
defb 13,29 ; C3
defb 2,28 ; C#3
defb 9,26 ; D3
defb 1,25 ; D#3
defb 11,23 ; E3
defb 5,22 ; F3
defb 1,21 ; F#3
defb 14,19 ; G3
defb 12,18 ; G#3
defb 12,17 ; A3
defb 12,16 ; A#3
defb 13,15 ; B3
defb 14,14 ; C4
defb 1,14 ; C#4
defb 4,13 ; D4
defb 8,12 ; D#4
defb 13,11 ; E4
defb 2,11 ; F4
defb 8,10 ; F#4
defb 15,9 ; G4
defb 6,9 ; G#4
defb 14,8 ; A4
defb 6,8 ; A#4
defb 14,7 ; B4
defb 7,7 ; C5
defb 0,7 ; C#5
defb 10,6 ; D5
defb 4,6 ; D#5
defb 14,5 ; E5
defb 9,5 ; F5
defb 4,5 ; F#5
defb 15,4 ; G5
