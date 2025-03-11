include "ZeroPage.inc"
include "gametank.inc"
include "SubBin.inc"

ext SubBin

Tempo equ 180/2
Denom equ 600/2/2
Count equ 3
MaxVolume equ 31

dseg
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
	;BassWave
	defb $26,$20,$15,$0c,$05,$00,$00,$05
	defb $08,$05,$00,$00,$05,$0c,$15,$20
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
        stz Channel_CurrentL,x
        stz Channel_CurrentH,x
        inx
        cpx #Count
    while ne | wend

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
                        EndWriteCycle:
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


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait0


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody0


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldy #low beep_notes
    ldx #high beep_notes
jmp MelodyWait0


; void Sound_Start();
start_notes:
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait1


; void Sound_Clear();
clear_notes:
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait1


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait1


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
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G2, N4,0, N8,G2; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G2, N4,0, N8,G2; 12
    defb N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

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
