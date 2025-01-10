cseg

tempo equ 180*2

zseg 
Dp.Word0:
    defw 0

dseg
SoundProc: public SoundProc
    defw 0

cseg

InitSound: public InitSound
    pshs x
        ldx #0
        stx SoundProc
    puls x
rts


CallSound_: public CallSound_
    pshs x
        ldx SoundProc
        if ne
            jsr ,x
        endif
        ldx #0
        stx SoundProc
    puls x
rts


cseg
Tone:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda #$81
        sta $FD03
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        lda #$0
        sta $FD03
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y
    while ne | wend
rts


Rest:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda #$0
        sta $FD03
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        lda #$0
        sta $FD03
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y
    while ne | wend
rts


Melody:
    pshs a,b,y,cc
        orcc #$50
        do
            ldb ,x+
        while ne
            lda ,x+
            if ne
                pshs b
                    ldy #cycles
                    deca
                    asla
                    asla
                    leay a,y
                    ldd ,y++
                    std <Dp.Word0
                    ldy ,y
                puls b
                do
                    pshs b,y
                        bsr Tone
                    puls b,y
                    decb
                while ne | wend
            else
                pshs b
                    ldd cycles
                    std <Dp.Word0
                    ldy cycles+2
                puls b
                do
                    pshs b,y
                        bsr Rest
                    puls b,y
                    decb
                while ne | wend
            endif
        wend
    puls a,b,y,cc
rts


loose_notes:
    defb 2,A3, 2,0, 0
Sound_Loose_: public Sound_Loose_
    pshs x
        ldx #loose_notes
        bsr Melody
    puls x
rts


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    pshs x
        ldx #hit_notes
        bsr Melody
    puls x
rts
Sound_Hit_:  public Sound_Hit_
    pshs x
        ldx #Sound_Hit
        stx SoundProc
    puls x
rts


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole:
    pshs x
        ldx #stole_notes
        bsr Melody
    puls x
rts
Sound_Stole_:  public Sound_Stole_
    pshs x
        ldx #Sound_Stole
        stx SoundProc
    puls x
rts


beep_notes:
    defb 1,A4, 1,0, 0
Sound_Beep_: public Sound_Beep_
    pshs x
        ldx #beep_notes
        bsr Melody
    puls x
rts
Sound_Fire_: public Sound_Fire_
    pshs x
        ldx #Sound_Beep_
        stx SoundProc
    puls x
rts


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    pshs a,b,x,y
        ldx #bonus_notes
        bsr Melody
    puls a,b,x,y
rts


start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    pshs x
        ldx #start_notes
        bsr Melody
    puls x
rts


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pshs x
        ldx #clear_notes
        bsr Melody
    puls x
rts


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs x
        ldx #over_notes
        bsr Melody
    puls x
rts


A3 equ 1
A3S equ 2
B3 equ 3
C4 equ 4
C4S equ 5
D4 equ 6
D4S equ 7
E4 equ 8
F4 equ 9
F4S equ 10
G4 equ 11
G4S equ 12
A4 equ 13
A4S equ 14
B4 equ 15
C5 equ 16
C5S equ 17
D5 equ 18
D5S equ 19
E5 equ 20
F5 equ 21
F5S equ 22
G5 equ 23

cycles: public cycles
defw 387,(12000000/tempo)/(5442+8) ; A3
defw 366,(12000000/tempo)/(5148+8) ; A#3
defw 345,(12000000/tempo)/(4854+8) ; B3
defw 325,(12000000/tempo)/(4574+8) ; C4
defw 307,(12000000/tempo)/(4322+8) ; C#4
defw 290,(12000000/tempo)/(4084+8) ; D4
defw 273,(12000000/tempo)/(3846+8) ; D#4
defw 258,(12000000/tempo)/(3636+8) ; E4
defw 243,(12000000/tempo)/(3426+8) ; F4
defw 229,(12000000/tempo)/(3230+8) ; F#4
defw 216,(12000000/tempo)/(3048+8) ; G4
defw 204,(12000000/tempo)/(2880+8) ; G#4
defw 193,(12000000/tempo)/(2726+8) ; A4
defw 182,(12000000/tempo)/(2572+8) ; A#4
defw 171,(12000000/tempo)/(2418+8) ; B4
defw 162,(12000000/tempo)/(2292+8) ; C5
defw 152,(12000000/tempo)/(2152+8) ; C#5
defw 144,(12000000/tempo)/(2040+8) ; D5
defw 136,(12000000/tempo)/(1928+8) ; D#5
defw 128,(12000000/tempo)/(1816+8) ; E5
defw 121,(12000000/tempo)/(1718+8) ; F5
defw 114,(12000000/tempo)/(1620+8) ; F#5
defw 107,(12000000/tempo)/(1522+8) ; G5
