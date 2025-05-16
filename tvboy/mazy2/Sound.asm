Port_Sound equ $02
Port_Bit equ $60
Tempo equ 220*2

dseg
SoundProc: public SoundProc
    defw 0

ext @Temp@Word
ext @Temp@Word2
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3

cycle equ @Temp@Word
dummy equ @Temp@Byte
unitLength equ @Temp@Byte2
length equ @Temp@Byte3


cseg
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


beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_:  public Sound_Beep_
    ldx #beep_notes
bra Melody


Sound_Get_: public Sound_Get_
    ldx #Sound_Beep_ | stx SoundProc
rts


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    ldx #hit_notes
bra Melody
Sound_Hit_: public Sound_Hit_
    ldx #Sound_Hit | stx SoundProc
rts


loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
bra Melody


start_notes: 
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
bra Melody


clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    ldx #clear_notes
bra Melody


over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
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
F5S equ 19
G5 equ 20

cycles:
defw 424 | defb (894886*6/Tempo-4)/(24+8*424) ;C4
defw 400 | defb (894886*6/Tempo-4)/(24+8*400) ;C#4
defw 377 | defb (894886*6/Tempo-4)/(24+8*377) ;D4
defw 356 | defb (894886*6/Tempo-4)/(24+8*356) ;D#4
defw 336 | defb (894886*6/Tempo-4)/(24+8*336) ;E4
defw 317 | defb (894886*6/Tempo-4)/(24+8*317) ;F4
defw 299 | defb (894886*6/Tempo-4)/(24+8*299) ;F#4
defw 282 | defb (894886*6/Tempo-4)/(24+8*282) ;G4
defw 266 | defb (894886*6/Tempo-4)/(24+8*266) ;G#4
defw 251 | defb (894886*6/Tempo-4)/(24+8*251) ;A4
defw 236 | defb (894886*6/Tempo-4)/(24+8*236) ;A#4
defw 223 | defb (894886*6/Tempo-4)/(24+8*223) ;B4
defw 210 | defb (894886*6/Tempo-4)/(24+8*210) ;C5
defw 198 | defb (894886*6/Tempo-4)/(24+8*198) ;C#5
defw 187 | defb (894886*6/Tempo-4)/(24+8*187) ;D5
defw 176 | defb (894886*6/Tempo-4)/(24+8*176) ;D#5
defw 166 | defb (894886*6/Tempo-4)/(24+8*166) ;E5
defw 157 | defb (894886*6/Tempo-4)/(24+8*157) ;F5
defw 148 | defb (894886*6/Tempo-4)/(24+8*148) ;F#5
defw 139 | defb (894886*6/Tempo-4)/(24+8*139) ;G5
