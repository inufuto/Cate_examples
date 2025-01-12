include "Zeropage.inc"

Tempo equ 180/3
Tempo_denom equ 600/2/3 

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
unitSize equ Channel_Len+1



dseg
Channels defs unitSize*count
time: defb 0


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

    ldy #0
    do
        lda #$11 | sta $D405,y ; Attack and Decay length
        lda #$f1 | sta $D406,y ; Sustain volume and Release length
        tya | clc|adc #7 | tay
        cpy #count*7
    while ne | wend

    lda #$0f
    sta $D418
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
                            lda #0
                            ldy <ZB0 ; port offset
                            sta $D404,y
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
                            sec | sbc #1
                            asl a
                            tay
                            lda cycles,y
                            pha
                                lda cycles+1,y
                                ldy <ZB0
                                sta $D401,y
                            pla
                            sta $D400,y
                            lda #$11
                        else
                            ldy <ZB0
                            lda #$00
                        endif
                        sta $D404,y

                        lda Channels+Channel_Ptr,x | clc | adc #2 | sta Channels+Channel_Ptr,x
                        lda Channels+Channel_Ptr+1,x | adc #0 | sta Channels+Channel_Ptr+1,x
                    endif
                    lda Channels+Channel_Len,x
                    if eq
                        lda #0
                        ldy <ZB0 ; port offset
                        sta $D404,y
                    endif
                endif
                next:
                txa | clc | adc #unitSize | tax
                lda <ZB0 ; port offset
                clc | adc #7
                sta <ZB0 ; port offset
                cmp #count*7
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
        sty Channels+unitSize*1+Channel_Ptr
        stx Channels+unitSize*1+Channel_Ptr+1
        lda #1
        sta Channels+unitSize*1+Channel_Len
    cli
rts

MelodyWait:
    jsr Melody
    do
        lda Channels+unitSize*1+Channel_Ptr
        ora Channels+unitSize*1+Channel_Ptr+1
    while ne | wend
rts


; void Sound_Loose();
loose_notes:
    defb 1,C4, 0
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
jmp Melody


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
BGM_C:
	defb 5,C3,1,0, 12,0, 17,E3,1,0
	defb 5,G3,1,0, 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,D3,1,0, 12,0
	defb 17,F3,1,0, 5,A3,1,0
	defb 6,0, 5,G2,1,0, 12,0
	defb 17,B2,1,0, 5,D3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,F3,1,0, 12,0
	defb 5,F3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 5,C3,1,0, 5,A2,1,0, 12,0
	defb 5,A2,1,0, 5,D3,1,0, 12,0
	defb 5,D3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 6,0, 5,F2,1,0, 6,0
	defb 5,F2,1,0, 6,0, 5,G2,1,0, 6,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    sei
        lda #low BGM_B
        sta Channels+unitSize*0+Channel_Start
        sta Channels+unitSize*0+Channel_Ptr
        lda #high BGM_B
        sta Channels+unitSize*0+Channel_Start+1
        sta Channels+unitSize*0+Channel_Ptr+1
        lda #1
        sta Channels+unitSize*0+Channel_Len
        
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
        sta Channels+unitSize*0+Channel_Ptr
        sta Channels+unitSize*0+Channel_Ptr+1
        sta Channels+unitSize*2+Channel_Ptr
        sta Channels+unitSize*2+Channel_Ptr+1
        ldy #0
        do
            sta $D404,y
            tya | clc|adc #7 | tay
            cpy #count*7
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
defw 1352 ; E2
defw 1432 ; F2
defw 1517 ; F#2
defw 1608 ; G2
defw 1703 ; G#2
defw 1805 ; A2
defw 1912 ; A#2
defw 2025 ; B2
defw 2146 ; C3
defw 2274 ; C#3
defw 2409 ; D3
defw 2552 ; D#3
defw 2704 ; E3
defw 2864 ; F3
defw 3035 ; F#3
defw 3215 ; G3
defw 3406 ; G#3
defw 3609 ; A3
defw 3824 ; A#3
defw 4051 ; B3
defw 4292 ; C4
defw 4547 ; C#4
defw 4817 ; D4
defw 5104 ; D#4
defw 5407 ; E4
defw 5729 ; F4
defw 6070 ; F#4
defw 6430 ; G4
defw 6813 ; G#4
defw 7218 ; A4
defw 7647 ; A#4
defw 8102 ; B4
defw 8584 ; C5
defw 9094 ; C#5
defw 9635 ; D5
defw 10208 ; D#5
defw 10815 ; E5
defw 11458 ; F5
defw 12139 ; F#5
defw 12861 ; G5
