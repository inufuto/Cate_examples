include "ZeroPage.inc"
include "Vram.inc"

OffByte equ ScreenMode
OnByte equ OffByte or 2

Tempo equ 180/4
TempoDenom equ 500/4

Count equ 2

zseg
pMelody:
    defw 0
dseg
Channels: public Channels
Channel_StartL:
    defs Count
Channel_StartH:
    defs Count
Channel_Offset:
    defs Count
Channel_Tone:
    defs Count
Channel_Len:
    defs Count
Time:
    defb 0


cseg
OffAll:
    lda #0 | tax
    do
        sta Channel_StartL,x
        sta Channel_StartH,x
        sta Channel_Tone,x
        inx
        cpx #Count
    while ne | wend
    lda #OffByte | sta $fe07
rts
InitSound: public InitSound
    lda #0 | sta Time
    jsr OffAll
rts


SoundHandler: public SoundHandler
    lda Time
    sec | sbc #Tempo
    sta Time
    if cc
        txa | pha | tya | pha
            ldx #0 ; Channel
            do
                lda Channel_StartL,x | ora Channel_StartH,x
                if ne
                    dec Channel_Len,x
                    if eq
                        lda Channel_StartL,x | sta <pMelody
                        lda Channel_StartH,x | sta <pMelody+1
                        continue:
                        ldy Channel_Offset,x | lda (<pMelody),y
                        if eq
                            ; end
                            sta Channel_StartL,x | sta Channel_StartH,x
                            offch:
                            sta Channel_Tone,x
                            cpx #0
                            if eq
                                lda Channel_Tone+1
                                if ne
                                    sta $fe06
                                    lda #OnByte | sta $fe07
                                    jmp next
                                endif
                            endif
                            lda #OffByte | sta $fe07
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda #0 | sta Channel_Offset,x
                            jmp continue
                        endif
                        sta Channel_Len,x
                        iny | lda (<pMelody),y | iny
                        pha
                            tya
                            sta Channel_Offset,x
                        pla
                        cmp #0
                        beq offch
                        tay | dey
                        lda cycles,y
                        sta Channel_Tone,x
                        cpx #1
                        if eq
                            lda Channel_Tone+0
                            bne next
                        endif
                        lda Channel_Tone,x | sta $fe06
                        lda #OnByte | sta $fe07
                    endif
                endif
                next:
                inx
                cpx #Count
            while ne | wend
        pla | tay | pla | tax            
        lda Time
        clc | adc #TempoDenom
        sta Time
    endif
rts


Melody:
    pha
        sei
            sty Channel_StartL
            stx Channel_StartH
            lda #0 | sta Channel_Offset
            lda #1 | sta Channel_Len
        cli
    pla
rts


MelodyWait:
    jsr Melody
    pha
        do
            lda Channel_StartL | ora Channel_StartH
        while ne | wend
    pla
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


cseg
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

; void StartBGM();
cseg
StartBGM_: public StartBGM_
    pha
        lda #low BGM_B | sta Channel_StartL+1
        lda #high BGM_B | sta Channel_StartH+1
        lda #0 | sta Channel_Offset+1
        lda #1 | sta Channel_Len+1
    pla
rts


;void StopBGM();
StopBGM_: public StopBGM_
    pha
        jsr OffAll
    pla
rts

C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18
F5S equ 19
G5 equ 20

cycles:
defb 238 ; C4
defb 225 ; C4S
defb 212 ; D4
defb 200 ; D4S
defb 189 ; E4
defb 178 ; F4
defb 168 ; F4S
defb 159 ; G4
defb 150 ; G4S
defb 141 ; A4
defb 134 ; A4S
defb 126 ; B4
defb 119 ; C5
defb 112 ; C5S
defb 106 ; D5
defb 100 ; D5S
defb 94 ; E5
defb 89 ; F5
defb 84 ; F5S
defb 79 ; G5
