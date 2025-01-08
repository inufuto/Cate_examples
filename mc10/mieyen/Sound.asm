ext @Temp@Word
ext @Temp@Word2
ext @Temp@Byte
ext @Temp@Byte2
ext @Temp@Byte3

Port_Sound equ $bfff
OffByte equ $24;
OnByte equ OffByte or $80
tempo equ 180*2

dseg
SoundProc:
    defw 0

cycle equ @Temp@Word2
outValue equ @Temp@Byte
unitLength equ @Temp@Byte2

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
Tone: public Tone
; in:
;   b: length
;   <@Temp@Word2: <cycle
;   <@Temp@Byte: <outValue
    do
        ldaa <outValue
        staa Port_Sound
        ldx <cycle
        do
            dex
        while ne | wend
        ldaa #OffByte
        staa Port_Sound
        ldx <cycle
        do
            dex
        while ne | wend
        decb
    while ne | wend
rts


cseg
Melody:
    stx <@Temp@Word
    do
        ldx <@Temp@Word
        ldaa 0,x
    while ne
        staa <@Temp@Byte3
        inx
        ldaa 0,x
        if ne
            asla
            adda 0,x
            suba #3
            ldab #OnByte
        else
            ldab #OffByte
        endif        
        inx
        stx <@Temp@Word
        
        ldx #cycles
        stx <cycle | adda <cycle+1 | staa <cycle+1
        ldaa <cycle | adca #0 | staa <cycle
        ldx <cycle

        ldaa 2,x
        staa <unitLength
        ldaa 0,x | staa <cycle
        ldaa 1,x | staa <cycle+1
        stab <outValue

        do
            ldab <unitLength
            bsr Tone
            ; ldaa <outValue
            ; if ne
            ;     suba #2
            ;     staa <outValue
            ; endif
            dec <@Temp@Byte3
        while ne | wend
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
    ldx #Sound_Hit | stx SoundProc
rts


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole:
    ldx #stole_notes
bra Melody
Sound_Stole_: public Sound_Stole_
    ldx #Sound_Stole | stx SoundProc
rts


beep_notes:
    defb 1,A4, 0
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
defw 211 | defb (10000000/tempo-6)/(22+16*211) ;C4
defw 199 | defb (10000000/tempo-6)/(22+16*199) ;C#4
defw 188 | defb (10000000/tempo-6)/(22+16*188) ;D4
defw 177 | defb (10000000/tempo-6)/(22+16*177) ;D#4
defw 167 | defb (10000000/tempo-6)/(22+16*167) ;E4
defw 157 | defb (10000000/tempo-6)/(22+16*157) ;F4
defw 148 | defb (10000000/tempo-6)/(22+16*148) ;F#4
defw 140 | defb (10000000/tempo-6)/(22+16*140) ;G4
defw 132 | defb (10000000/tempo-6)/(22+16*132) ;G#4
defw 125 | defb (10000000/tempo-6)/(22+16*125) ;A4
defw 117 | defb (10000000/tempo-6)/(22+16*117) ;A#4
defw 111 | defb (10000000/tempo-6)/(22+16*111) ;B4
defw 104 | defb (10000000/tempo-6)/(22+16*104) ;C5
defw 98 | defb (10000000/tempo-6)/(22+16*98) ;C#5
defw 93 | defb (10000000/tempo-6)/(22+16*93) ;D5
defw 88 | defb (10000000/tempo-6)/(22+16*88) ;D#5
defw 83 | defb (10000000/tempo-6)/(22+16*83) ;E5
defw 78 | defb (10000000/tempo-6)/(22+16*78) ;F5
