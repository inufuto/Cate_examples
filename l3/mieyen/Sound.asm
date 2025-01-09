; include 'Temp6809.inc'
    cseg

Tempo equ 180*2

zseg 
Dp.Word0:
    defw 0

dseg
SoundProc:
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
        lda #$80            ;2
        sta $FFD3          ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        lda #$0
        sta $FFD3
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y           ;4+1
    while ne | wend         ;3 [8]
rts


Rest:
; in:
;   Dp.Word0: cycle
;   y: length
    do
        lda #$0            ;2
        sta $FFD3           ;5
        ldd <Dp.Word0       ;5 [12]
        do
            subd #1         ;4 
        while ne | wend     ;3 [7]
        lda #$0
        sta $FFD3
        ldd <Dp.Word0
        do
            subd #1
        while ne | wend
        leay -1,y           ;4+1
    while ne | wend         ;3 [8]
rts


Melody:
    pshs cc
        orcc #$60
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
    puls cc
rts


loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    pshs a,b,x,y
        ldx #loose_notes
        bsr Melody
    puls a,b,x,y
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
    pshs a,b,x,y
        ldx #beep_notes
        bsr Melody
    puls a,b,x,y
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
Sound_Start_: 
    public Sound_Start_
    pshs a,b,x,y
        ldx #start_notes
        bsr Melody
    puls a,b,x,y
rts


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_:
    public Sound_Clear_
    pshs a,b,x,y
        ldx #clear_notes
        bsr Melody
    puls a,b,x,y
rts


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pshs a,b,x,y
        ldx #over_notes
        bsr Melody
    puls a,b,x,y
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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles: public cycles
defw 271,(10000000/Tempo)/(3818+8) ; C4
defw 255,(10000000/Tempo)/(3594+8) ; C4S
defw 241,(10000000/Tempo)/(3398+8) ; D4
defw 227,(10000000/Tempo)/(3202+8) ; D4S
defw 214,(10000000/Tempo)/(3020+8) ; E4
defw 202,(10000000/Tempo)/(2852+8) ; F
defw 191,(10000000/Tempo)/(2698+8) ; F4S
defw 180,(10000000/Tempo)/(2544+8) ; G4
defw 170,(10000000/Tempo)/(2404+8) ; G4S
defw 160,(10000000/Tempo)/(2264+8) ; A4
defw 151,(10000000/Tempo)/(2138+8) ; A4S
defw 142,(10000000/Tempo)/(2012+8) ; B4
defw 134,(10000000/Tempo)/(1900+8) ; C5
defw 127,(10000000/Tempo)/(1802+8) ; C5S
defw 119,(10000000/Tempo)/(1690+8) ; D5
defw 113,(10000000/Tempo)/(1606+8) ; D5S
defw 106,(10000000/Tempo)/(1508+8) ; E5
defw 100,(10000000/Tempo)/(1424+8) ; F5
