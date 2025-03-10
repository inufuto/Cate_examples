include "ZeroPage.inc"
include "gametank.inc"
include "SubBin.inc"

ext SubBin

Tempo equ 180/2
Denom equ 600/2/2
Count equ 3
MaxVolume equ 31

HighNoise equ $f0
LowNoise equ $f1

LowNoiseCycle equ 20
HighNoiseCycle equ LowNoiseCycle*4/5


dseg
Channels: public Channels
Channel_CurrentL:
    defs Count
Channel_CurrentH:
    defs Count
Channel_StartL:
    defs Count
Channel_StartH:
    defs Count
Channel_Len:
    defs Count
Channel_Vol:
    defs Count
Time:
    defb 0
NoiseVolume:
    defb 0

zseg
pMelody:
    defw 0

pSource equ ZW0
pDestination equ ZW1

cseg
ToneWaves:
	;SquareWave
	defb $20,$20,$20,$20,$20,$20,$20,$20
	defb $00,$00,$00,$00,$00,$00,$00,$00
	;SquareWave
	defb $20,$20,$20,$20,$20,$20,$20,$20
	defb $00,$00,$00,$00,$00,$00,$00,$00
	;SquareWave
	defb $20,$20,$20,$20,$20,$20,$20,$20
	defb $00,$00,$00,$00,$00,$00,$00,$00
NoiseWave:
	defb $21,$3e,$0a,$19,$1e,$38,$09,$1d
	defb $3b,$04,$3a,$32,$09,$1b,$26,$25
	defb $32,$24,$18,$30,$31,$19,$25,$3c
	defb $31,$2a,$13,$2f,$0f,$1a,$3e,$3a
	defb $3d,$0c,$01,$27,$21,$3d,$17,$2e
	defb $02,$0e,$1c,$23,$33,$39,$06,$2d
	defb $34,$3e,$24,$10,$2a,$21,$20,$35
	defb $00,$08,$14,$29,$0c,$37,$1e,$13
SubVectors:
    defw SubNmi,SubMain,SubIrq

InitSound: public InitSound
    stz AUDIO_RATE

    lda #low SubBin | sta <pSource
    lda #high SubBin | sta <pSource+1

    lda #low(SOUND_RAM+SubMain) | sta <pDestination
    lda #high(SOUND_RAM+SubMain) | sta <pDestination+1

    ldx #(SubBin_size+$ff)/$100
    do
        ldy #0
        do
            lda (<pSource),y
            sta (pDestination),y
            iny
        while ne | wend
        inc <pSource+1
        inc <pDestination+1

        dex
    while ne | wend

    ldx #0
    do
        lda SubVectors,x
        sta SOUND_RAM+$ffa,x
        inx
        cpx #2*3
    while ne | wend

    ldx #0
    do
        lda ToneWaves,x
        sta SOUND_RAM+SubToneSamples,x
        inx
        cpx #16*3
    while ne | wend

    ldx #0
    do
        lda NoiseWave,x
        sta SOUND_RAM+SubNoiseSamples,x
        inx
        cpx #64
    while ne | wend

    ldx #0
    do
        stz Channel_CurrentL,x
        stz Channel_CurrentH,x
        stz Channel_Vol,x
        inx
        cpx #Count
    while ne | wend
    stz NoiseVolume

    stz AUDIO_RESET
    lda #255 | sta AUDIO_RATE
rts


SoundHandler: public SoundHandler
    lda Time
    sec | sbc #Tempo
    if cs
        pha
            ldx #0 
            do
                lda Channel_CurrentL,x
                ora Channel_CurrentH,x
                if ne
                    dec Channel_Len,x
                    if eq
                        continue:
                        lda Channel_CurrentL,x | sta <pMelody
                        lda Channel_CurrentH,x | sta <pMelody+1
                        ldy #0
                        lda (<pMelody),y
                        if eq
                            ; end
                            stz Channel_CurrentL,x
                            stz Channel_CurrentH,x
                            stz SOUND_RAM+SubVolumes,x
                            cpx #0
                            if eq
                                stz NoiseVolume
                                stz SOUND_RAM+SubNoiseVolume
                            endif
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda Channel_StartL,x | sta Channel_CurrentL,x
                            lda Channel_StartH,x | sta Channel_CurrentH,x
                            jmp continue
                        endif
                        sta Channel_Len,x
                        iny
                        lda (<pMelody),y
                        pha
                            lda Channel_CurrentL,x | clc|adc #2 | sta Channel_CurrentL,x
                            lda Channel_CurrentH,x | adc #0 | sta Channel_CurrentH,x
                        pla
                        cmp #HighNoise
                        if eq
                            lda #HighNoiseCycle
                            noiseOn:
                            sta SOUND_RAM+SubNoiseCycle
                            lda #MaxVolume/2 | sta NoiseVolume
                            lda #0
                            jmp startVol
                        endif
                        cmp #LowNoise
                        if eq
                            lda #LowNoiseCycle
                            jmp noiseOn
                        endif
                        cmp #0
                        if ne
                            dec a
                            phx
                                tax
                                lda Cycles,x
                            plx
                            sta SOUND_RAM+SubCycles,x
                            lda #MaxVolume
                        else
                            lda #0
                        endif
                        startVol:
                        sta Channel_Vol,x
                    endif
                    lda Channel_Vol,x
                    tay
                        lsr a | lsr a
                        sta SOUND_RAM+SubVolumes,x
                    tya
                    if ne
                        dec a
                        sta Channel_Vol,x
                    endif
                endif
                next:
                inx
                cpx #Count
            while ne | wend
            lda NoiseVolume
            if ne
                tay
                    lsr a
                    sta SOUND_RAM+SubNoiseVolume
                tya
                if ne
                    dec a
                    sta NoiseVolume
                endif
            endif
        pla
        clc|adc #Denom
    endif
    sta Time
rts

Melody0:
    pha
        sei
            sty Channel_CurrentL+0
            stx Channel_CurrentH+0
            lda #1
            sta Channel_Len+0
        cli
    pla
rts

MelodyWait0:
    jsr Melody0
    pha
        do
            lda Channel_CurrentL+0
            ora Channel_CurrentH+0
        while ne | wend
    pla
rts

Melody1:
    pha
        sei
            sty Channel_CurrentL+1
            stx Channel_CurrentH+1
            lda #1
            sta Channel_Len+1
        cli
    pla
rts

MelodyWait1:
    jsr Melody1
    pha
        do
            lda Channel_CurrentL+1
            ora Channel_CurrentH+1
        while ne | wend
    pla
rts


; void Sound_Fire();
fire_notes:
    defb 1,C5, 1,A4S, 1,G4S, 1,F4S, 0
Sound_Fire_: public Sound_Fire_
    ldy #low fire_notes
    ldx #high fire_notes
jmp Melody0


; void Sound_SmallBang();
cseg
smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    ldy #low smallExplosion_notes
    ldx #high smallExplosion_notes
jmp Melody0


; void Sound_LargeBang();
cseg
largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    ldy #low largeExplosion_notes
    ldx #high largeExplosion_notes
jmp Melody0


; void Sound_Start();
start_notes:
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait1


; void Sound_GameOver();
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait1


BGM_B: 
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2P,G4, N2,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2P,D5, N2,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2P,C5, N2,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb $ff

BGM_C:
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,C3S ;3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3 ;4
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,G3S ;5
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2 ;6

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,E3 ;7
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3S ;8
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3 ;9
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3 ;10

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,A2S ;11
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3 ;12
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3 ;13
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3 ;14
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,C3S ;15
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,G3S ;16
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2 ;17
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0 ;18

    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    pha
        sei
            ldx #1
            lda #low BGM_B
            sta Channel_CurrentL+1
            sta Channel_StartL+1
            lda #high BGM_B
            sta Channel_CurrentH+1
            sta Channel_StartH+1
            stx Channel_Len+1
            lda #low BGM_C
            sta Channel_CurrentL+2
            sta Channel_StartL+2
            lda #high BGM_C
            sta Channel_CurrentH+2
            sta Channel_StartH+2
            stx Channel_Len+2
        cli
    pla
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    pha
        sei
            ldx #1
            do
                stz Channel_CurrentL,x
                stz Channel_CurrentH,x
                stz SOUND_RAM+SubVolumes,x
                inx
                cpx #Count
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
defb 255 ; E2
defb 240 ; F2
defb 227 ; F#2
defb 214 ; G2
defb 202 ; G#2
defb 191 ; A2
defb 180 ; A#2
defb 170 ; B2
defb 160 ; C3
defb 151 ; C#3
defb 143 ; D3
defb 135 ; D#3
defb 127 ; E3
defb 120 ; F3
defb 113 ; F#3
defb 107 ; G3
defb 101 ; G#3
defb 95 ; A3
defb 90 ; A#3
defb 85 ; B3
defb 80 ; C4
defb 76 ; C#4
defb 71 ; D4
defb 67 ; D#4
defb 64 ; E4
defb 60 ; F4
defb 57 ; F#4
defb 54 ; G4
defb 51 ; G#4
defb 48 ; A4
defb 45 ; A#4
defb 42 ; B4
defb 40 ; C5
defb 38 ; C#5
defb 36 ; D5
defb 34 ; D#5
defb 32 ; E5
defb 30 ; F5
defb 28 ; F#5
defb 27 ; G5
