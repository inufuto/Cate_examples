include "Apple2.inc"
include "ZeroPage.inc"

Tempo equ 220*2

dseg
SoundProc:
    defw 0

cseg

InitSound: public InitSound
    lda #0
    sta SoundProc
    sta SoundProc+1
rts

CallSound:
    jmp (SoundProc)

CallSound_: public CallSound_
    lda SoundProc
    ora SoundProc+1
    if ne
        jsr CallSound
        lda #0
        sta SoundProc
        sta SoundProc+1
    endif
rts



Tone:
;   <ZB3: length
;   <ZB0: cycle
    do
        lda SPKR
        lda <ZB0
        sta <ZB4
        do
            nop | nop | nop | nop | nop | nop
            dec <ZB4
        while ne | wend
        lda SPKR
        lda <ZB0
        sta <ZB4
        do
            nop | nop | nop | nop | nop | nop
            dec <ZB4
        while ne | wend
        dec <ZB3
    while ne | wend
rts


Rest:
;   <ZB3: length
;   <ZB0: cycle
    do
        lda SoundProc
        lda <ZB0
        sta <ZB4
        do
            nop | nop | nop | nop | nop | nop
            dec <ZB4
        while ne | wend
        lda SoundProc
        lda <ZB0
        sta <ZB4
        do
            nop | nop | nop | nop | nop | nop
            dec <ZB4
        while ne | wend
        dec <ZB3
    while ne | wend
rts


Melody: public Melody
    pha
        sty <ZW2 | stx <ZW2+1
        ldy #0
        do
            lda (<ZW2),y
        while ne
            sta <ZB1

            iny
            lda (<ZW2),y
            iny
            
            cmp #0
            if ne
                sec | sbc #1
                asl a
                tax
                lda cycles,x
                sta <ZB0
                inx 
                do
                    lda cycles,x | sta <ZB3
                    jsr Tone
                    dec <ZB1
                while ne | wend
            else
                asl a
                tax
                lda cycles,x
                sta <ZB0
                inx 
                do
                    lda cycles,x | sta <ZB3
                    jsr Rest
                    dec <ZB1
                while ne | wend
            endif
        wend
    pla
rts


beep_notes:
    defb 1,A4, 0
Sound_Beep_:  public Sound_Beep_
    ldy #low beep_notes
    ldx #high beep_notes
jmp Melody


Sound_Get_: public Sound_Get_
    pha
        lda #low Sound_Beep_ | sta SoundProc
        lda #high Sound_Beep_ | sta SoundProc+1
    pla
rts


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    ldy #low hit_notes
    ldx #high hit_notes
jmp Melody
Sound_Hit_: public Sound_Hit_
    pha
        lda #low Sound_Hit | sta SoundProc
        lda #high Sound_Hit | sta SoundProc+1
    pla
rts


loose_notes:
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    ldy #low loose_notes
    ldx #high loose_notes
jmp Melody


start_notes:
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    ldy #low start_notes
    ldx #high start_notes
jmp Melody


clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldy #low clear_notes
    ldx #high clear_notes
jmp Melody


over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldy #low over_notes
    ldx #high over_notes
jmp Melody


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

cycles:
defb 102,(10230000/Tempo-10)/(3896+16) ; C4
defb 96,(10230000/Tempo-10)/(3668+16) ; C4S
defb 91,(10230000/Tempo-10)/(3478+16) ; D4
defb 86,(10230000/Tempo-10)/(3288+16) ; D4S
defb 81,(10230000/Tempo-10)/(3098+16) ; E4
defb 76,(10230000/Tempo-10)/(2908+16) ; F4
defb 72,(10230000/Tempo-10)/(2756+16) ; F4S
defb 68,(10230000/Tempo-10)/(2604+16) ; G4
defb 64,(10230000/Tempo-10)/(2452+16) ; G4S
defb 60,(10230000/Tempo-10)/(2300+16) ; A4
defb 57,(10230000/Tempo-10)/(2186+16) ; A4S
defb 53,(10230000/Tempo-10)/(2034+16) ; B4
defb 50,(10230000/Tempo-10)/(1920+16) ; C5
defb 48,(10230000/Tempo-10)/(1844+16) ; C5S
defb 45,(10230000/Tempo-10)/(1730+16) ; D5
defb 42,(10230000/Tempo-10)/(1616+16) ; D5S
defb 40,(10230000/Tempo-10)/(1540+16) ; E5
defb 38,(10230000/Tempo-10)/(1464+16) ; F5
