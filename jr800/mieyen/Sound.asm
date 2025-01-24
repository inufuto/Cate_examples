include "ZeroPage.inc"

Port_Sound equ $02
Port_Bit equ $10
Tempo equ 180*2

dseg
SoundProc:
    defw 0

cycle equ ZW0
dummy equ ZB0
unitLength equ ZB1
length equ ZB2

cseg
InitSound: public InitSound
    clr SoundProc
    clr SoundProc+1
rts


CallSound_: public CallSound_
    psha | pshb
        ldx SoundProc
        if ne
            jsr 0,x
        endif
        ldx #0
        stx SoundProc
    pulb | pula
rts


cseg
Tone:
; in:
;   b: length
;   <cycle
    do
        ldaa <Port_Sound
        oraa #Port_Bit
        staa <Port_Sound
        ldx <cycle
        do
            dex
        while ne | wend
        ldaa <Port_Sound
        anda #not Port_Bit
        staa <Port_Sound
        ldx <cycle
        do
            dex
        while ne | wend
        decb
    while ne | wend
rts

Rest:
; in:
;   b: length
;   <cycle
    do
        ldaa <dummy
        oraa #0
        ldaa <dummy
        ldx <cycle
        do
            dex
        while ne | wend
        ldaa <dummy
        anda #not 0
        ldaa <dummy
        ldx <cycle
        do
            dex
        while ne | wend
        decb
    while ne | wend
rts


cseg
Melody: public Melody
    do
        ldaa 0,x
    while ne
        staa <length
        inx
        ldaa 0,x
        pshx
            if ne
                deca
                ldab #3
                mul
                ldx #cycles
                abx
                ldaa 2,x
                staa <unitLength
                ldd 0,x | std <cycle
                do
                    ldab <unitLength
                    bsr Tone
                    dec <length
                while ne | wend
            else
                ldaa cycles+2 | staa <unitLength
                ldd cycles | std <cycle
                do
                    ldab <unitLength
                    bsr Rest
                    dec <length
                while ne | wend
            endif        
        pulx
        inx
    wend
rts


loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
bra Melody


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    ldx #hit_notes
bra Melody
Sound_Hit_: public Sound_Hit_
    ldx #Sound_Hit
    stx SoundProc
rts


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole:
    ldx #stole_notes
bra Melody
Sound_Stole_: public Sound_Stole_
    ldx #Sound_Stole
    stx SoundProc
rts


beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_:  public Sound_Beep_
    ldx #beep_notes
bra Melody
Sound_Fire_: public Sound_Fire_
    ldx #Sound_Beep_ | stx SoundProc
rts


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    ldx #bonus_notes
bra Melody


start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
bra Melody


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldx #clear_notes
bra Melody


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #over_notes
bra Melody


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
defw 584 | defb (1228800*5*2/Tempo-4)/(24+8*584) ;C4
defw 551 | defb (1228800*5*2/Tempo-4)/(24+8*551) ;C#4
defw 520 | defb (1228800*5*2/Tempo-4)/(24+8*520) ;D4
defw 490 | defb (1228800*5*2/Tempo-4)/(24+8*490) ;D#4
defw 462 | defb (1228800*5*2/Tempo-4)/(24+8*462) ;E4
defw 436 | defb (1228800*5*2/Tempo-4)/(24+8*436) ;F4
defw 412 | defb (1228800*5*2/Tempo-4)/(24+8*412) ;F#4
defw 388 | defb (1228800*5*2/Tempo-4)/(24+8*388) ;G4
defw 366 | defb (1228800*5*2/Tempo-4)/(24+8*366) ;G#4
defw 346 | defb (1228800*5*2/Tempo-4)/(24+8*346) ;A4
defw 326 | defb (1228800*5*2/Tempo-4)/(24+8*326) ;A#4
defw 308 | defb (1228800*5*2/Tempo-4)/(24+8*308) ;B4
defw 290 | defb (1228800*5*2/Tempo-4)/(24+8*290) ;C5
defw 274 | defb (1228800*5*2/Tempo-4)/(24+8*274) ;C#5
defw 258 | defb (1228800*5*2/Tempo-4)/(24+8*258) ;D5
defw 243 | defb (1228800*5*2/Tempo-4)/(24+8*243) ;D#5
defw 229 | defb (1228800*5*2/Tempo-4)/(24+8*229) ;E5
defw 216 | defb (1228800*5*2/Tempo-4)/(24+8*216) ;F5
