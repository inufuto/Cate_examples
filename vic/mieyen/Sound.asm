include "ZeroPage.inc"

Tempo equ 180/5
Tempo_denom equ 600/2/5

Count equ 3

Port equ $900a

dseg
; Channels defs unitSize*Count
ChannelPtrL:
    defs Count
ChannelPtrH:
    defs Count
ChannelStartL:
    defs Count
ChannelStartH:
    defs Count
ChannelNoteLen:
    defs Count
Time: defb 0

pScore equ ZW0


cseg  
OffAll:
    ldx #0
    txa
    do
        sta ChannelPtrL,x
        sta ChannelPtrH,x
        sta Port,x
        inx
        cpx #Count
    while ne | wend
rts
InitSound: public InitSound
    jsr OffAll
    lda #0 | sta Time
rts


cseg
SoundHandler: public SoundHandler
    lda <pScore+0 | pha
    lda <pScore+1 | pha
        lda Time
        sec | sbc #Tempo
        sta Time
        if cc
            ldx #0
            do
                lda ChannelPtrL,x
                ora ChannelPtrH,x
                if ne
                    dec ChannelNoteLen,x
                    if eq
                        continue:
                        lda ChannelPtrL,x
                        sta <ZW0+0
                        lda ChannelPtrH,x
                        sta <ZW0+1
                        ldy #0 | lda (<pScore),y
                        cmp #0
                        if eq
                            ; end
                            sta ChannelPtrL,x
                            sta ChannelPtrH,x
                            sta Port,x
                            jmp next
                        endif
                        cmp #$ff
                        if eq
                            ; repeat
                            lda ChannelStartL,x
                            sta ChannelPtrL,x
                            lda ChannelStartH,x
                            sta ChannelPtrH,x
                            jmp continue
                        endif
                        sta ChannelNoteLen,x
                        ldy #1 | lda (<pScore),y
                        if ne
                            sec | sbc #1
                            tay
                            lda cycles, y
                        else
                            lda #0
                        endif
                        sta Port,x

                        lda ChannelPtrL,x | clc | adc #2 | sta ChannelPtrL,x
                        lda ChannelPtrH,x | adc #0 | sta ChannelPtrH,x
                    endif
                    lda ChannelNoteLen,x
                    if eq
                        lda #0
                        sta Port,x
                    endif
                endif
                next:
                inx
                cpx #Count
            while ne | wend
            lda Time
            clc | adc #Tempo_denom
            sta Time
        endif
    pla | sta <pScore+1
    pla | sta <pScore+0
rts


Melody:
    sei
        sty ChannelPtrL+1
        stx ChannelPtrH+1
        lda #1
        sta ChannelNoteLen+1
    cli
rts

MelodyWait:
    sei
        sty ChannelPtrL+2
        stx ChannelPtrH+2
        lda #1
        sta ChannelNoteLen+2
    cli
    do
        lda ChannelPtrL+2
        ora ChannelPtrH+2
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


BGM_2:
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

BGM_0:
	defb 5,C4,1,0, 12,0, 17,E4,1,0
	defb 5,G4,1,0, 6,0, 5,A4,1,0, 12,0
	defb 17,C4,1,0, 5,E4,1,0
	defb 6,0, 5,D4,1,0, 12,0
	defb 17,F4,1,0, 5,A4,1,0
	defb 6,0, 5,G4,1,0, 12,0
	defb 17,B4,1,0, 5,D4,1,0
	defb 6,0, 5,C4,1,0, 12,0
	defb 17,E4,1,0, 5,G4,1,0
	defb 6,0, 5,A4,1,0, 12,0
	defb 17,C4,1,0, 5,E4,1,0
	defb 6,0, 5,F4,1,0, 12,0
	defb 5,F4,1,0, 5,G4,1,0, 12,0
	defb 5,G4,1,0, 5,C4,1,0, 12,0
	defb 17,E4,1,0, 5,G4,1,0
	defb 6,0, 5,C4,1,0, 12,0
	defb 5,C4,1,0, 5,A4,1,0, 12,0
	defb 5,A4,1,0, 5,D4,1,0, 12,0
	defb 5,D4,1,0, 5,G4,1,0, 12,0
	defb 5,G4,1,0, 6,0, 5,F4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,G4,1,0, 5,C4,1,0, 12,0
	defb 17,E4,1,0, 5,G4,1,0
	defb 6,0
    defb $ff

; void StartBGM();
StartBGM_: public StartBGM_
    sei
        lda #low BGM_0
        sta ChannelStartL+0
        sta ChannelPtrL+0
        lda #high BGM_0
        sta ChannelStartH+0
        sta ChannelPtrH+0
        lda #1
        sta ChannelNoteLen+0
        
        lda #low BGM_2
        sta ChannelStartL+2
        sta ChannelPtrL+2
        lda #high BGM_2
        sta ChannelStartH+2
        sta ChannelPtrH+2
        lda #1
        sta ChannelNoteLen+2
    cli
rts


; void StopBGM();
StopBGM_: public StopBGM_
    sei
        jsr OffAll
    cli
rts


G3 equ 1
G3S equ 2
A3 equ 3
A3S equ 4
B3 equ 5
C4 equ 6
C4S equ 7
D4 equ 8
D4S equ 9
E4 equ 10
F4 equ 11
F4S equ 12
G4 equ 13
G4S equ 14
A4 equ 15
A4S equ 16
B4 equ 17
C5 equ 18
C5S equ 19
D5 equ 20
D5S equ 21
E5 equ 22
F5 equ 23
F5S equ 24
G5 equ 25

cycles:
defb 173 ; G3
defb 178 ; G#3
defb 182 ; A3
defb 186 ; A#3
defb 190 ; B3
defb 193 ; C4
defb 197 ; C#4
defb 200 ; D4
defb 203 ; D#4
defb 206 ; E4
defb 209 ; F4
defb 211 ; F#4
defb 214 ; G4
defb 216 ; G#4
defb 218 ; A4
defb 220 ; A#4
defb 222 ; B4
defb 224 ; C5
defb 226 ; C#5
defb 227 ; D5
defb 229 ; D#5
defb 230 ; E5
defb 232 ; F5
defb 233 ; F#5
defb 234 ; G5
