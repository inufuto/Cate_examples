include "Zeropage.inc"

Tempo equ 180/3
Tempo_denom equ 600/2/3

ChannelCount equ 6
WaveLength equ 32

EndOfScore equ $00
RepeatScore equ $ff
HighNoise equ $f0
LowNoise equ $f1

MaxVol equ $3f
HighNoiseValue equ 10
LowNoiseValue equ 15

dseg
Channels: public Channels
Channel_PtrL:
    defs ChannelCount
Channel_PtrH:
    defs ChannelCount
Channel_StartL:
    defs ChannelCount
Channel_StartH:
    defs ChannelCount
Channel_Len:
    defs ChannelCount
Channel_Vol:
    defs ChannelCount
time:
    defb 0

pSource equ ZW0

cseg
SquareWave:
	defb $10,$10,$10,$10,$10,$10,$10,$10
	defb $10,$10,$10,$10,$10,$10,$10,$10
	defb $00,$00,$00,$00,$00,$00,$00,$00
	defb $00,$00,$00,$00,$00,$00,$00,$00
; SawWave:
; 	defb $00,$01,$02,$03,$04,$05,$06,$07
; 	defb $08,$09,$0a,$0b,$0c,$0d,$0e,$0f
; 	defb $10,$11,$12,$13,$14,$15,$16,$17
; 	defb $18,$19,$1a,$1b,$1c,$1d,$1e,$1f
; SineWave:
; 	defb $1f,$1f,$1e,$1c,$1a,$18,$15,$12
; 	defb $0f,$0c,$09,$06,$04,$02,$01,$00
; 	defb $00,$01,$02,$04,$06,$09,$0c,$0f
; 	defb $12,$15,$18,$1a,$1c,$1e,$1f,$1f
BassWave:
	defb $1f,$1e,$1a,$16,$11,$0d,$09,$06
	defb $04,$02,$00,$00,$01,$03,$05,$07
	defb $07,$05,$03,$01,$00,$00,$02,$04
	defb $06,$09,$0d,$11,$16,$1a,$1e,$1f
ChordWave:
	defb $1f,$1d,$18,$15,$12,$0f,$0c,$0a
	defb $09,$07,$05,$04,$04,$04,$02,$00
	defb $00,$02,$04,$04,$04,$05,$07,$09
	defb $0a,$0c,$0f,$12,$15,$18,$1d,$1f
; LeadWave:
; 	defb $19,$07,$0b,$05,$05,$04,$00,$02
; 	defb $02,$05,$05,$05,$07,$06,$07,$07
; 	defb $07,$07,$06,$07,$05,$05,$05,$02
; 	defb $02,$00,$04,$05,$05,$0b,$07,$19
Lead2Wave:
	defb $19,$13,$09,$02,$02,$03,$02,$01
	defb $01,$01,$01,$00,$01,$00,$00,$00
	defb $00,$00,$00,$01,$00,$01,$01,$01
	defb $01,$02,$03,$02,$02,$09,$13,$19

WaveForms:
    defw Lead2Wave
    defw BassWave
    defw ChordWave
    defw ChordWave
    defw ChordWave
    defw SquareWave


cseg
MasterVolumes:
    defb $ed, $bf
    defb $1d,$95,$d1
    defb $de
InitSound: public InitSound
    stz time
    tax | tay
    do
        stx $0800

        lda #0
        sta Channel_PtrL,x
        sta Channel_PtrH,x
        sta $0804 | sta $0807

        lda MasterVolumes,x | sta $0801
        lda #$ff | sta $0805

        defb $da ; phx
            txa | asl a | tax
            lda WaveForms,x | sta <pSource
            lda WaveForms+1,x | sta <pSource+1
            ldy #0
            do
                lda (<pSource),y | iny
                sta $0806
                cpy #WaveLength
            while ne | wend
        defb $fa ; plx
        inx
        cpx #ChannelCount
    while ne | wend
rts


zseg
pScore:
    defw 0
byteValue:
    defb 0

cseg
SoundHandler: public SoundHandler
    lda time
    sec|sbc #Tempo
    sta time
    if cc
        ldx #0
        do
            lda Channel_PtrL,x | ora Channel_PtrH,x
            if ne
                stx $0800
                dec Channel_Len,x
                if eq
                    continue:
                    lda Channel_PtrL,x | sta <pScore
                    lda Channel_PtrH,x | sta <pScore+1
                    ldy #0 | lda (<pScore),y ; length
                    cmp #EndOfScore
                    if eq
                        ; end
                        sta Channel_PtrL,x | sta Channel_PtrH,x
                        sta $0804
                        jmp next
                    endif
                    cmp #RepeatScore
                    if eq
                        ; repeat
                        lda Channel_StartL,x | sta Channel_PtrL,x
                        lda Channel_StartH,x | sta Channel_PtrH,x
                        jmp continue
                    endif
                    sta Channel_Len,x
                    iny | lda (<pScore),y ; tone
                    cmp #HighNoise
                    if eq
                        lda #HighNoiseValue or $80
                        sta $0807
                        jmp EndWriteCycle
                    endif
                    cmp #LowNoise
                    if eq
                        lda #LowNoiseValue or $80
                        sta $0807
                        jmp EndWriteCycle
                    endif
                    cmp #0
                    if ne
                        defb $3A ; dec a
                        asl a
                        tay
                        lda cycles,y | sta $0802
                        lda cycles+1,y | sta $0803
                        defb $9c | defw $0807 ; stz
                        EndWriteCycle:
                        lda #MaxVol | sta Channel_Vol,x
                        lsr a
                        ora #$40
                        sta $0804
                        eor #$c0
                    else
                        lda #$00 | sta Channel_Vol,x
                    endif
                    sta $0804

                    lda <pScore | clc | adc #2 | sta Channel_PtrL,x
                    lda <pScore+1 | adc #0 | sta Channel_PtrH,x
                else
                    lda Channel_Vol,x
                    if ne
                        defb $3A ; dec a
                        sta Channel_Vol,x
                        if ne
                            lsr a
                            ora #$80
                            sta $0804
                        endif
                    endif
                endif
            endif
            next:
            inx
            cpx #ChannelCount
        while ne | wend
        lda time
        clc|adc #Tempo_denom
        sta time
    endif
rts


Melody0:
    sei
        stx Channel_PtrL+0
        sty Channel_PtrH+0
        lda #1 | sta Channel_Len+0
    cli
rts

MelodyWait0:
    jsr Melody0
    do
        lda Channel_PtrL+0 | ora Channel_PtrH+0
    while ne | wend
rts


Melody5:
    pha
        lda Channel_PtrL+5
        ora Channel_PtrH+5
        if eq
            jsr MelodyPrior5
        endif
    pla
rts

MelodyWait5:
    jsr MelodyPrior5
    pha
        do
                lda Channel_PtrL+5 | ora Channel_PtrH+5
        while ne | wend
    pla
rts


MelodyPrior5:
    pha
        sei
            stx Channel_PtrL+5
            sty Channel_PtrH+5
            lda #1 | sta Channel_Len+5
        cli
    pla
rts


; void Sound_Fire();
fire_notes:
    defb 1,C5, 1,A4S, 1,G4S, 1,F4S, 0
Sound_Fire_: public Sound_Fire_
    ldx #low fire_notes
    ldy #high fire_notes
jmp Melody5


; void Sound_SmallBang();
smallExplosion_notes:
    defb N2,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    ldx #low smallExplosion_notes
    ldy #high smallExplosion_notes
jmp MelodyPrior5


; void Sound_LargeBang();
largeExplosion_notes:
    defb N2,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    ldx #low largeExplosion_notes
    ldy #high largeExplosion_notes
jmp MelodyPrior5


; void Sound_Up();
up_notes:
    defb 1,C4, 1,C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    ldx #low up_notes
    ldy #high up_notes
jmp Melody5


; void Sound_Start();
cseg
start_notes:
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #low start_notes
    ldy #high start_notes
jmp MelodyWait0


; ; void Sound_Clear();
; clear_notes:
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_Clear_: public Sound_Clear_
;     ldx #low clear_notes
;     ldy #high clear_notes
; jmp MelodyWait0


; void Sound_GameOver();
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #low over_notes
    ldy #high over_notes
jmp MelodyWait0


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
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F2, N8,F2, N8,0, N4P,E2, N4,0

    defb $ff

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;4  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;5  Em
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;6  Am
    
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;8  F
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;9  G
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;10  Em

    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;11  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;12  G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;13  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;14  C

    defb N8,E4, N8,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;15  Am
    defb N8,F4, N8,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;16  Dm
    defb N8,E4, N8,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;17  Am
    defb N8,F4, N8,F4, N8,0, N4P,G4, N4,0  ;18  F Em

    defb $ff

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;4  Dm
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;5  Em
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;6  Am
    
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  F
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;9  G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10  Em

    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;11  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12  G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;13  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;14  C

    defb N8,C4, N8,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;15  Am
    defb N8,D4, N8,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;16  Dm
    defb N8,C4, N8,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;17  Am
    defb N8,C4, N8,C4, N8,0, N4P,E4, N4,0  ;18  F Em

    defb $ff

BGM_D3:
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;3  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;5  Em
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;6  Am

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;7  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  F
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;9  G
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;10  Em

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;11  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;12  G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;13  C
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;14  C

    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;15  Am
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;16  Dm
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;17  Am
    defb N8,A3, N8,A3, N8,0, N4P,B3, N4,0  ;18  F Em

    defb $ff


; void StartBGM();
cseg
Parts:
    defw BGM_B,BGM_C
    defw BGM_D1,BGM_D2,D3
StartBGM_: public StartBGM_
    sei
        ldy #0 | ldx #0
        do
            lda Parts,y | iny
            sta Channel_StartL,x | sta Channel_PtrL,x
            lda Parts,y | iny
            sta Channel_StartH,x | sta Channel_PtrH,x
            lda #1 | sta Channel_Len,x
            inx
            cpx #ChannelCount-1
        while ne | wend
    cli
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    sei
        lda #0 | tax
        do
            sta Channel_PtrL,x
            sta Channel_PtrH,x
            stx $0800
            sta $0804
            inx
            cpx #ChannelCount
        while ne | wend
    cli
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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defw 1357 ; E2
defw 1281 ; F2
defw 1209 ; F#2
defw 1141 ; G2
defw 1077 ; G#2
defw 1017 ; A2
defw 960 ; A#2
defw 906 ; B2
defw 855 ; C3
defw 807 ; C#3
defw 762 ; D3
defw 719 ; D#3
defw 679 ; E3
defw 641 ; F3
defw 605 ; F#3
defw 571 ; G3
defw 539 ; G#3
defw 508 ; A3
defw 480 ; A#3
defw 453 ; B3
defw 428 ; C4
defw 404 ; C#4
defw 381 ; D4
defw 360 ; D#4
defw 339 ; E4
defw 320 ; F4
defw 302 ; F#4
defw 285 ; G4
defw 269 ; G#4
defw 254 ; A4
defw 240 ; A#4
defw 226 ; B4
defw 214 ; C5
defw 202 ; C#5
defw 190 ; D5
defw 180 ; D#5
defw 170 ; E5
defw 160 ; F5
defw 151 ; F#5
defw 143 ; G5
