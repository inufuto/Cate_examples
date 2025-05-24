include "Zeropage.inc"

Tempo equ 220/3
Tempo_denom equ 600/2/3

ChannelCount equ 6
WaveLength equ 32

EndOfScore equ $00
RepeatScore equ $ff
MaxVol equ $3f

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
LeadWave:
	defb $19,$07,$0b,$05,$05,$04,$00,$02
	defb $02,$05,$05,$05,$07,$06,$07,$07
	defb $07,$07,$06,$07,$05,$05,$05,$02
	defb $02,$00,$04,$05,$05,$0b,$07,$19

WaveForms:
    defw LeadWave
    defw BassWave
    defw ChordWave
    defw ChordWave
    defw ChordWave
    defw SquareWave


; void InitSound();
cseg
MasterVolumes:
    defb $ed, $bf
    defb $1d,$95,$d1
    defb $de
InitSound: public InitSound
    lda #0 | sta time
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
                    if ne
                        defb $3A ; dec a
                        asl a
                        tay
                        lda cycles,y | sta $0802
                        lda cycles+1,y | sta $0803
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
    pha
        sei
            sty Channel_PtrL+0
            stx Channel_PtrH+0
            lda #1 | sta Channel_Len+0
        cli
    pla
rts

MelodyWait0:
    jsr Melody0
    pha
        do
            lda Channel_PtrL+0 | ora Channel_PtrH+0
        while ne | wend
    pla
rts


Melody5:
    pha
        sei
            sty Channel_PtrL+5
            stx Channel_PtrH+5
            lda #1 | sta Channel_Len+5
        cli
    pla
rts

MelodyWait5:
    jsr Melody5
    do
        lda Channel_PtrL+5 | ora Channel_PtrH+5
    while ne | wend
rts


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait5


; void Sound_Get();
Sound_Get_: public Sound_Get_
    ldy #low beep_notes
    ldx #high beep_notes
jmp Melody5


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody5


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait5


; void Sound_Start();
cseg
start_notes:
    defb N8,C4, N8,G4, N8,E4, N8,G4, N2,C5
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp MelodyWait0


; void Sound_Clear();
clear_notes:
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp MelodyWait0


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,G4, N8,E4, N8,C5,  N8,B4, N8,G4, N8,E4, N8,B4,  N4,A4, N4,B4,  N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp MelodyWait0


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

BGM_D1:
    defb N4P,0
    defb N4P,F4, N4P,F4, N4,F4  ;F
    defb N4P,E4, N4P,E4, N4,E4  ;C
    defb N2,F4, N2,G4, N2+N8,E4, N4P,0 ;F G Am
    defb N4P,E4, N4P,E4, N4,E4  ;Am
    defb N4P,G4, N4P,G4, N4,G4  ;G
    defb N2,F4, N2,E4, N2+N8,F4 ;F C F
    defb $ff

BGM_D2:
    defb N4P,0
    defb N4P,C4, N4P,C4, N4,C4  ;F
    defb N4P,C4, N4P,C4, N4,C4  ;C
    defb N2,C4, N2,D4, N2+N8,C4, N4P,0 ;F G Am
    defb N4P,C4, N4P,C4, N4,C4  ;Am
    defb N4P,D4, N4P,D4, N4,D4  ;G
    defb N2,C4, N2,C4, N2+N8,C4 ;F C F
    defb $ff

BGM_D3:
    defb N4P,0
    defb N4P,A3, N4P,A3, N4,A3  ;F
    defb N4P,G3, N4P,G3, N4,G3  ;C
    defb N2,A3, N2,B3, N2+N8,A3, N4P,0 ;F G Am
    defb N4P,A3, N4P,A3, N4,A3  ;Am
    defb N4P,B3, N4P,B3, N4,B3  ;G
    defb N2,A3, N2,G3, N2+N8,A3 ;F C F
    defb $ff

; void StartBGM();
cseg
Parts:
    defw BGM_B,BGM_C
    defw BGM_D1,BGM_D2,BGM_D3
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
