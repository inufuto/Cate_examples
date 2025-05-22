include "atari5200.inc"
include "Zeropage.inc"

Tempo equ 220/3
Tempo_denom equ 600/2/3

ToneBits equ $a0
MaxVol equ 31   ;63

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


cseg
InitSound: public InitSound
    ldx #0
    ldy #count
    do
        lda #0
        sta Channels+Channel_Ptr,x
        sta Channels+Channel_Ptr+1,x
        txa | clc | adc #unitSize | tax
        dey
    while ne | wend
    lda #0
    sta time

    lda #$08 | sta AUDCTL
    lda #ToneBits
    ldx #0
    do
        sta AUDC1,x
        inx
        inx
        cpx #4*2
    while ne | wend
rts


cseg
SoundHandler: public SoundHandler
    lda <ZB0 | pha
    lda <ZW0+0 | pha
    lda <ZW0+1 | pha
        lda time
        sec | sbc #Tempo
        sta time
        if cc
            ldx #0
            ldy #0
            sty <ZB0 ; port offset
            do
                lda Channels+Channel_Ptr,x
                ora Channels+Channel_Ptr+1,x
                if ne
                    dec Channels+Channel_Len,x
                    if eq
                        continue:
                        lda Channels+Channel_Ptr,x
                        sta <ZW0+0
                        lda Channels+Channel_Ptr+1,x
                        sta <ZW0+1
                        ldy #0 | lda (<ZW0),y
                        cmp #0
                        if eq
                            ; end
                            sta Channels+Channel_Ptr,x
                            sta Channels+Channel_Ptr+1,x
                            lda #ToneBits
                            cpx #unitSize*2
                            if ne
                                ldy <ZB0 ; port offset
                                sta AUDC1,y
                            else
                                sta AUDC3
                                sta AUDC4
                            endif
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda Channels+Channel_Start,x
                            sta Channels+Channel_Ptr,x
                            lda Channels+Channel_Start+1,x
                            sta Channels+Channel_Ptr+1,x
                            jmp continue
                        endif
                        sta Channels+Channel_Len,x
                        ldy #1 | lda (<ZW0),y
                        if ne
                            cpx #unitSize*2
                            if ne
                                tay
                                lda highCycles-C4,y
                                ldy <ZB0
                                sta AUDF1,y
                            else
                                asl a
                                tay
                                lda lowCycles-E2*2,y | sta AUDF3
                                lda lowCycles-E2*2+1,y | sta AUDF4
                            endif
                            lda #MaxVol
                        else
                            ldy <ZB0
                            lda #0
                        endif
                        sta Channels+Channel_Vol,x
                        lda Channels+Channel_Ptr,x | clc | adc #2 | sta Channels+Channel_Ptr,x
                        lda Channels+Channel_Ptr+1,x | adc #0 | sta Channels+Channel_Ptr+1,x
                    endif
                    lda Channels+Channel_Vol,x
                    lsr a
                    ora #ToneBits
                    cpx #unitSize*2
                    if ne
                        ldy <ZB0
                        sta AUDC1,y
                    else
                        sta AUDC4
                    endif
                    lda Channels+Channel_Vol,x
                    if ne
                        sec|sbc #1
                        sta Channels+Channel_Vol,x
                    endif
                endif
                next:
                txa | clc | adc #unitSize | tax
                inc <ZB0 ; port offset
                inc <ZB0 ; port offset
                cmp #count*unitSize
            while ne | wend
            lda time
            clc | adc #Tempo_denom
            sta time
        endif
    pla | sta <ZW0+1
    pla | sta <ZW0+0
    pla | sta <ZB0
rts                

Melody:
    sei
        sty Channels+unitSize*0+Channel_Ptr
        stx Channels+unitSize*0+Channel_Ptr+1
        pha
            lda #1
            sta Channels+unitSize*0+Channel_Len
        pla
    cli
rts

MelodyWait:
    jsr Melody
    pha
        do
            lda Channels+unitSize*0+Channel_Ptr
            ora Channels+unitSize*0+Channel_Ptr+1
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
    defb 1,C4, 0
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
    sei
        lda #low BGM_B
        sta Channels+unitSize*1+Channel_Start
        sta Channels+unitSize*1+Channel_Ptr
        lda #high BGM_B
        sta Channels+unitSize*1+Channel_Start+1
        sta Channels+unitSize*1+Channel_Ptr+1
        lda #1
        sta Channels+unitSize*1+Channel_Len
        
        lda #low BGM_C
        sta Channels+unitSize*2+Channel_Start
        sta Channels+unitSize*2+Channel_Ptr
        lda #high BGM_C
        sta Channels+unitSize*2+Channel_Start+1
        sta Channels+unitSize*2+Channel_Ptr+1
        lda #1
        sta Channels+unitSize*2+Channel_Len
    cli
rts


; void StopBGM();
StopBGM_: public StopBGM_
    sei
        lda #0
        sta Channels+unitSize*1+Channel_Ptr
        sta Channels+unitSize*1+Channel_Ptr+1
        sta Channels+unitSize*2+Channel_Ptr
        sta Channels+unitSize*2+Channel_Ptr+1
        ldy #0
        do
            sta AUDC1,y
            iny | iny
            cpy #(count+1)*2
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


highCycles:
defb 245 ; C4
defb 231 ; C#4
defb 218 ; D4
defb 206 ; D#4
defb 194 ; E4
defb 183 ; F4
defb 173 ; F#4
defb 163 ; G4
defb 154 ; G#4
defb 145 ; A4
defb 137 ; A#4
defb 130 ; B4
defb 122 ; C5
defb 115 ; C#5
defb 109 ; D5
defb 103 ; D#5
defb 97 ; E5
defb 92 ; F5
defb 86 ; F#5
defb 82 ; G5

lowCycles:
defw 777 ; E2
defw 733 ; F2
defw 692 ; F2S
defw 653 ; G2
defw 616 ; G2S
defw 582 ; A2
defw 549 ; A2S
defw 518 ; B2
defw 489 ; C3
defw 462 ; C3S
defw 436 ; D3
defw 411 ; D3S
defw 388 ; E3
defw 367 ; F3
defw 346 ; F3S
defw 327 ; G3
defw 308 ; G3S
defw 291 ; A3
defw 275 ; A3S
defw 259 ; B3
