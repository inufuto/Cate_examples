dseg
SoundProc:
    defw 0


cseg
InitSound: public InitSound
    ldw $0,0
    pre ix,SoundProc
    stw $0,(ix+$sx)
rtn


; void CallSound();
cseg
CallSound:
    jp $10
CallSound_: public CallSound_
    phsw $11
        pre ix,SoundProc
        ldw $10,(ix+$sx)
        orc $10,$11
        if nz
            cal CallSound
            pre ix,SoundProc
            xrw $10,$10
            stw $10,(ix+$sx)
        endif
    ppsw $10
rtn


Wait:
    phsw $11
        do
            sbw $10,$sy
        while nz | wend
    ppsw $10
rtn

Tone:
;   $10 = cycle
;   $12 = length
    do
        gst pd,$0 | or $0,&h40 | pst pd,$0
        cal Wait
        an $0,not &h40 | pst pd,$0
        cal Wait
        sbw $12,$10
    while nc | wend
rtn

Rest:
;   $10 = cycle
;   $12 = length
    do
        gst pd,$0 | or $0,&h00 | pst pd,$0
        cal Wait
        gst pd,$0 | an $0,not &h00 | pst pd,$0
        cal Wait
        sbw $12,$10
    while nc | wend
rtn

MakeLength:
    ld $13,$0
    ld $12,$sx
    ldw $14,$12
    adw $12,$12 ;*2
    ; adw $12,$14 ;*3
    ; adw $12,$12 ;*4
rtn

Melody: 
;   ix: address
    phsw $1
    phsm $15,6
        do
            ldi $0,(ix+$sx)
            sbc $0,$sx
        while nz
            cal MakeLength
            ldi $1,(ix+$sx)
            sbc $1,$sx
            if nz
                sb $1,$sy
                biu $1
                pre iz,cycles
                ldw $10,(iz+$1)
                cal Tone
            else
                pre iz,cycles
                ldw $10,(iz+$1)
                cal Rest
            endif
        wend
    ppsm $10,6
    ppsw $0
rtn


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_:  public Sound_Beep_
    pre ix,beep_notes
jp Melody


; void Sound_Get();
Sound_Get_: public Sound_Get_
    phsw $11
        ldw $10,Sound_Beep_
        pre ix,SoundProc
        stw $10,(ix+$sx)
    ppsw $10
rtn


; void Sound_Hit();
cseg
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    pre ix,loose_notes
jp Melody
Sound_Hit_: public Sound_Hit_
    phsw $11
        ldw $10,Sound_Hit
        pre ix,SoundProc
        stw $10,(ix+$sx)
    ppsw $10
rtn


; void Sound_Loose();
cseg
loose_notes:
    defb 2,C4, 2,0, 0
Sound_Loose_: public Sound_Loose_
    pre ix,loose_notes
jp Melody


; void Sound_Start();
start_notes:
	defb 5,C4,1,0, 5,G4,1,0, 5,E4,1,0, 5,G4,1,0, 23,C5,1,0
    defb 0
Sound_Start_: public Sound_Start_
    pre ix,start_notes
jp Melody


; void Sound_Clear();
clear_notes: 
	defb 5,C4,1,0, 5,E4,1,0, 5,G4,1,0, 5,D4,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0, 5,G4,1,0
	defb 5,B4,1,0, 17,C5,1,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pre ix,clear_notes
jp Melody


; void Sound_GameOver();
cseg
over_notes: 
	defb 5,C5,1,0, 5,G4,1,0, 5,E4,1,0, 5,C5,1,0, 5,B4,1,0, 5,G4,1,0, 5,E4,1,0, 5,B4,1,0
	defb 11,A4,1,0, 11,B4,1,0, 23,C5,1,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pre ix,over_notes
jp Melody


C4 equ 1
C4S equ 2
D4 equ 3
E4 equ 5
F4 equ 6
G4 equ 8
A4 equ 10
B4 equ 12
C5 equ 13
D5 equ 15
E5 equ 17
F5 equ 18

cycles:
defw 203   ;C4
defw 191   ;C#4
defw 181   ;D4
defw 170   ;D#4
defw 161   ;E4
defw 152   ;F
defw 143   ;F#4
defw 135   ;G4
defw 128   ;G#4
defw 120   ;A4
defw 114   ;A#4
defw 107   ;B4
defw 101   ;C5
defw 95   ;C#5
defw 90   ;D5
defw 85   ;D#5
defw 80   ;E5
defw 76   ;F5
