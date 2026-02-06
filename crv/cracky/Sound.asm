include "ZeroPage.inc"
include "Port.inc"

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

MinVolume equ 63

Tempo equ 160/2
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

zseg
reg:
    defb 0
pMelody:
    defw 0


cseg
Init equ $fe57
PreparePort equ $fe67
Write equ $fe77

; PreparePort:
;     pha
;         lda #$22 | sta PiaPort+3 ; B Control
;         lda #$ff | sta PiaPort+2 ; B Data Direction
;         lda #$26 | sta PiaPort+3 ; B Control
;     pla
; rts

; Write:
;     ; pha
;         sta PiaPort+2 ; B Out
;         do
;             lda PiaPort+3 ; B Control
;         while pl | wend
;         lda PiaPort+2 ; B In
;     ; pla
; rts

; InitValues:
;     defb $ff
;     defb Dcsg_VolumeC or $8f
;     defb Dcsg_VolumeB or $8f
;     defb Dcsg_VolumeA or $8f
; Init:
;     ldx #Count
;     do
;         lda InitValues,x
;         jsr Write
;         dex
;     while pl | wend
; rts

cseg
InitSound: public InitSound
    ldx #0 | txa
    sta Time
    do
        sta ChannelPtrL,x
        sta ChannelPtrH,x
        inx
        cpx #Count
    while ne | wend

    jsr PreparePort
    jsr Init
    ; ldx #Count
    ; lda #Dcsg_VolumeA or $8f
    ; do
    ;     jsr Write
    ;     clc|adc #$20
    ;     dex
    ; while ne | wend
rts


SoundHandler: public SoundHandler
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
                        clc|adc #1
                        sta ChannelVol,x
                    endif
                endif
                next:
                lda <reg
                clc|adc #$20
                sta <reg
                inx
                cpx #Count
            while ne | wend
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


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp MelodyWait


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    ldy #low beep_notes
    ldx #high beep_notes
jmp MelodyWait


start_notes: 
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N1,C5
    defb 0
Sound_Start_: public Sound_Start_
    pha
        ldy #low start_notes
        ldx #high start_notes
        jsr MelodyWait
    pla
rts


clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5,0       
    defb 0
Sound_Clear_: public Sound_Clear_
    pha
        ldy #low clear_notes
        ldx #high clear_notes
        jsr MelodyWait
    pla
rts


over_notes: 
    defb N8,C5, N8,C5, N8,G4, N8,G4, N8,A4, N8,A4, N8,B4, N8,B4
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
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,D5, N4,F5
    defb N8,F5, N8,E5, N8,C5, N4,C5, N4,D5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N4,F5, N4,F5, N4,E5, N4,E5
    defb N4,D5, N8,D5, N4,E5, N8,E5, N8,D5, N8,C5
    defb N4,C5, N4,C5, N8,D5, N4,D5, N4P,C5, N2P,0
    defb $ff

BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0 ; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0 ; 6
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 8
    defb N8,F2, N4,0, N4P,A2, N8,C3, N8,0 ; 9
    defb N8,D3, N4,0, N4P,E3, N8,A3, N8,0 ; 10
    defb N8,F2, N4,0, N8,F2, N8,G2, N8,0, N8,B2, N8,D3 ; 11
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 12
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
