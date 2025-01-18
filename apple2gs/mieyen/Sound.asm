include "apple2.inc"
include "apple2gs.inc"
include "Zeropage.inc"

Tempo equ 180/2
Denom equ 600/2/2

Register_Low equ $00
Register_High equ $20
Register_Volume equ $40
Register_Address equ $80
Register_Control equ $a0
Register_Size equ $c0
Register_Oscillator equ $e1

ToneChannelCount equ 6
ChannelCount equ ToneChannelCount+1
DrumChannelCount equ 4
MaxVolume equ $ff

ToneWaveAddress equ $00
DrumWaveAddress equ $10
ToneChannel equ $00
DrumChannel equ $08
TimerChannel equ $0f
BangChannel equ $07

ToneWaveCount equ 4


dseg
MasterVolumme:
    defb 0
Channels: public Channels
Channel_CurrentL:
    defs ChannelCount
Channel_CurrentH:
    defs ChannelCount
Channel_StartL:
    defs ChannelCount
Channel_StartH:
    defs ChannelCount
Channel_Len:
    defs ChannelCount
Channel_Volume:
    defs ChannelCount
time:
    defb 0

zseg
pScore:
    defw 0
cycle:
    defw 0

cseg
WaveForms1:
    ext LeadWave, BassWave, PianoWave, SquareWave
    defw LeadWave ; $0000
    defw BassWave ; $0100
    defw PianoWave ; $0200
    defw SquareWave ; $0300
AddressTable:
    defb 0,1, 2,2,2, 3
ControlTable1:
    defb $00,$10,$00,$10,$00,$10
WaveForms4:
    ext BassDrumWave,SnareDrumWave,HiHatWave,CymbalWave
    defw BassDrumWave ; $1000
    defw SnareDrumWave ; $1400
    defw HiHatWave ; $1800
    defw CymbalWave ; $1c00
ControlTable4:
    defb $02,$12,$02,$12
DrumCycleTable:
    defb 60 ; BD
    defb 65 ; SD
    defb 80 ; HH
    defb 50 ; CY
cseg
InitSound: public InitSound
    php
        sep #$20 | a8
        lda $E100CA ; Read the control panel volume
        and #$0f
        sta MasterVolumme

        sep #$10 | i8
        lda MasterVolumme | sta SOUNDCTL
        lda #Register_Oscillator | ldy #16*2 | jsr WriteByte

        lda #TimerChannel+Register_Low | ldy #low 158 | jsr WriteByte
        lda #TimerChannel+Register_High | ldy #high 158 | jsr WriteByte
        lda #TimerChannel+Register_Volume | ldy #$00 | jsr WriteByte
        lda #TimerChannel+Register_Address | ldy #$00 | jsr WriteByte
        lda #TimerChannel+Register_Size | ldy #$00 | jsr WriteByte
        lda #TimerChannel+Register_Control | ldy #$18 | jsr WriteByte
        ldx #0
        do
            ldy AddressTable,x
            txa | clc|adc #ToneChannel+Register_Address | jsr WriteByte
            ldy #0
            txa | clc|adc #ToneChannel+Register_Size | jsr WriteByte
            txa | clc|adc #ToneChannel+Register_Volume | jsr WriteByte
            inx
            cpx #ToneChannelCount
        while ne | wend
        ldx #0
        ldy #DrumWaveAddress
        do
            txa | clc|adc #DrumChannel+Register_Address | jsr WriteByte
            phy
                ldy DrumCycleTable,x
                txa | clc|adc #DrumChannel+Register_Low | jsr WriteByte
                ldy #0
                txa | clc|adc #DrumChannel+Register_High | jsr WriteByte
                ldy #$12
                txa | clc|adc #DrumChannel+Register_Size | jsr WriteByte
                ldy #$ff
                txa | clc|adc #DrumChannel+Register_Volume | jsr WriteByte
            ply
            iny | iny | iny | iny
            inx
            cpx #DrumChannelCount
        while ne | wend
        lda #BangChannel+Register_High | ldy #0 | jsr WriteByte
        lda #BangChannel+Register_Volume | ldy #$ff | jsr WriteByte
        lda #BangChannel+Register_Address | ldy #$14 | jsr WriteByte
        lda #BangChannel+Register_Size | ldy #$12 | jsr WriteByte

        ldy #ToneWaveAddress
        ldx #0
        do
            rep #$20 | a16
            lda WaveForms1,x | inx | inx
            phx | phy
                rep #$10 | i16
                tax
                sep #$20 | a8
                tya
                ldy #$100
                jsr FillMemory
            sep #$10 | i8
            ply | plx
            iny
            cpy #ToneWaveAddress+ToneWaveCount
        while ne | wend
        ldy #DrumWaveAddress
        ldx #0 
        do
            rep #$20 | a16
            lda WaveForms4,x | inx | inx
            phx | phy
                rep #$10 | i16
                tax
                sep #$20 | a8
                tya
                ldy #$400
                jsr FillMemory
            sep #$10 | i8
            ply | plx
            iny | iny | iny | iny
            cpy #DrumWaveAddress+$04*DrumChannelCount
        while ne | wend

        ldx #0
        do
            stz Channel_CurrentL,x
            stz Channel_CurrentH,x
            stz Channel_Volume,x
            inx
            cpx #ChannelCount
        while ne | wend
    plp
rts

FillMemory: 
; a: high address x:pCource
    i16 | a8
    pha
        lda MasterVolumme
        ora #$60 | sta SOUNDCTL
    pla
    stz SOUNDADRL
    sta SOUNDADRH
    do
        lda 0,x | inx
        sta SOUNDDATA
        dey
    while ne | wend
rts

WriteByte:
; a:register, y:value
    i8 | a8
    sta SOUNDADRL
    sty SOUNDDATA
rts


cseg
SoundHandler: public SoundHandler
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            lda time
            sec|sbc #Tempo
            sta time
            if cc
                ldx #0
                do
                    lda Channel_CurrentL,x | ora Channel_CurrentH,x
                    if ne
                        dec Channel_Len,x
                        if eq
                            continue:
                            lda Channel_CurrentL,x | sta <pScore
                            lda Channel_CurrentH,x | sta <pScore+1
                            ldy #0 | lda (<pScore),y ; length
                            if eq
                                ; end
                                lda MasterVolumme | sta SOUNDCTL
                                ldy #1
                                txa | clc|adc #Register_Control | jsr WriteByte

                                stz Channel_CurrentL,x | stz Channel_CurrentH,x
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
                            iny | lda (<pScore),y ; tone
                            if ne
                                cpx #ToneChannelCount
                                if cc
                                    dec a
                                    asl a
                                    tay
                                    rep #$20 | a16
                                    lda Cycles,y | sta <cycle
                                    sep #$20 | a8
                                    
                                    lda MasterVolumme | sta SOUNDCTL
                                    ldy <cycle
                                    txa | clc|adc #Register_Low | jsr WriteByte
                                    ldy <cycle+1
                                    txa | clc|adc #Register_High | jsr WriteByte
                                    ldy AddressTable,x
                                    txa | clc|adc #Register_Address | jsr WriteByte
                                    lda ControlTable1,x | tay
                                    txa | clc|adc #Register_Control | jsr WriteByte
                                    
                                    lda #MaxVolume | sta Channel_Volume,x
                                else
                                    phx
                                        ldx MasterVolumme | stx SOUNDCTL
                                        ldx #0
                                        do
                                            lsr a
                                            if cs
                                                pha
                                                    txa | clc|adc #DrumChannel+Register_Control
                                                    ldy #01 | jsr WriteByte
                                                    ldy ControlTable4,x |  jsr WriteByte
                                                pla
                                            endif
                                            inx
                                            cpx #DrumChannelCount
                                        while ne | wend
                                    plx
                                endif
                            endif
                            lda <pScore | clc | adc #2 | sta Channel_CurrentL,x
                            lda <pScore+1 | adc #0 | sta Channel_CurrentH,x
                        endif
                        lda MasterVolumme | sta SOUNDCTL

                        lda Channel_Volume,x
                        if ne
                            sec|sbc #8
                            if cc
                                lda #0
                            endif
                            sta Channel_Volume,x
                            
                            tay
                            txa | clc|adc #Register_Volume | jsr WriteByte
                        endif
                    endif
                    next:
                    inx
                    cpx #ChannelCount
                while ne | wend
                lda time
                clc|adc #Denom
                sta time
            endif
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


Melody0:
    a8 | i8
    pha
        sei
            sty Channel_CurrentL+0
            stx Channel_CurrentH+0
            lda #1 | sta Channel_Len+0
        cli
    pla
rts

MelodyWait0:
    a8 | i8
    jsr Melody0
    pha
        do
            lda Channel_CurrentL+0 | ora Channel_CurrentH+0
        while ne | wend
    pla
rts

Melody5:
    a8 | i8
    pha
        sei
            sty Channel_CurrentL+5
            stx Channel_CurrentH+5
            lda #1 | sta Channel_Len+5
        cli
    pla
rts

MelodyWait5:
    a8 | i8
    jsr Melody5
    pha
        do
            lda Channel_CurrentL+5 | ora Channel_CurrentH+5
        while ne | wend
    pla
rts

Bang:
    a8 | i8
    sep #$30 | a8 | i8
    lda MasterVolumme | sta SOUNDCTL
    lda #BangChannel+Register_Low | jsr WriteByte
    lda #BangChannel+Register_Control | ldy #$12 | jsr WriteByte
rts


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low loose_notes
            ldx #high loose_notes
            jsr MelodyWait5
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low hit_notes
            ldx #high hit_notes
            jsr Melody5
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low stole_notes
            ldx #high stole_notes
            jsr Melody5
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low fire_notes
            ldx #high fire_notes
            jsr Melody5
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low bonus_notes
            ldx #high bonus_notes
            jsr MelodyWait5
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Start();
cseg
start_notes:
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low start_notes
            ldx #high start_notes
            jsr MelodyWait0
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_Clear();
clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low clear_notes
            ldx #high clear_notes
            jsr MelodyWait0
        rep #$30 | i16
        ply | plx | pla
    plp
rts


; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #low over_notes
            ldx #high over_notes
            jsr MelodyWait0
        rep #$30 | i16
        ply | plx | pla
    plp
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

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;4  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;5  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;6  G

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;8  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;9  F G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10 C

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;11 C Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;12 Dm G
    defb N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,G4, N8,0, N8,G4 ;13 F G
    defb N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0 ;14 C

    defb $ff

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;4  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;5  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;6  G

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,D4 , N8,0, N8,D4  ;9  F G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;10 C

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;11 C Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12 Dm G
    defb N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,D4, N8,0, N8,D4 ;13 F G
    defb N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0 ;14 C

    defb $ff

BGM_D3:
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;3  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;5  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;6  G

    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;7  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;9  F G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;10 C

    defb N4,G3, N8,0, N8,G3, N8,0, N8,A3 , N8,0, N8,A3  ;11 C Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;12 Dm G
    defb N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,B3, N8,0, N8,B3 ;13 F G
    defb N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0 ;14 C

    defb $ff

BGM_R:
    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,SD

    defb N8,CY+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,HH, N8,HH+SD, N8,HH

    defb N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD, N8,BD, N8,SD
    defb N8,HH+BD, N8,HH, N8,HH+SD, N8,HH, N8,HH+BD, N8,SD, N8,SD, N8,SD

    defb $ff

BGM:
    defw BGM_B,BGM_C, BGM_D1,BGM_D2,BGM_D3
    defw 0,BGM_R

; void StartBGM();
cseg
StartBGM_: public StartBGM_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            ldy #0 | ldx #0
            do
                lda BGM,y | iny
                sta Channel_StartL,x | sta Channel_CurrentL,x
                lda BGM,y | iny
                sta Channel_StartH,x | sta Channel_CurrentH,x
                lda #1 | sta Channel_Len,x
                inx
                cpx #ChannelCount
            while ne | wend
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    php
        rep #$30 | a16 | i16
        pha | phx | phy
            sep #$30 | a8 | i8
            lda MasterVolumme | sta SOUNDCTL
            ldx #0
            do
                lda #0
                sta Channel_StartL,x | sta Channel_CurrentL,x
                sta Channel_StartH,x | sta Channel_CurrentH,x
                inc a
                sta Channel_Len,x
                ldy #1
                txa | clc|adc #Register_Control | jsr WriteByte
                inx
                cpx #ChannelCount
            while ne | wend
        rep #$30 | a16 | i16
        ply | plx | pla
    plp
rts


CY equ $08
HH equ $04
SD equ $02
BD equ $01

N8 equ 6
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
defw 217   ;E2
defw 230   ;F2
defw 244   ;F#2
defw 258   ;G2
defw 274   ;G#2
defw 290   ;A2
defw 307   ;A#2
defw 326   ;B2
defw 345   ;C3
defw 365   ;C#3
defw 387   ;D3
defw 410   ;D#3
defw 435   ;E3
defw 460   ;F3
defw 488   ;F#3
defw 517   ;G3
defw 547   ;G#3
defw 580   ;A3
defw 615   ;A#3
defw 651   ;B3
defw 690   ;C4
defw 731   ;C#4
defw 774   ;D4
defw 820   ;D#4
defw 869   ;E4
defw 921   ;F4
defw 976   ;F#4
defw 1034   ;G4
defw 1095   ;G#4
defw 1160   ;A4
defw 1229   ;A#4
defw 1302   ;B4
defw 1380   ;C5
defw 1462   ;C#5
defw 1549   ;D5
defw 1641   ;D#5
defw 1738   ;E5
defw 1842   ;F5
defw 1951   ;F#5
defw 2067   ;G5
