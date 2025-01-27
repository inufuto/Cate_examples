SOUND equ $FF64
SNSCOM equ $FF19
Tempo equ 180

dseg
SoundProc:
    defw 0


cseg
InitSound: public InitSound
    clr SoundProc
    clr SoundProc+1
rts


; void CallSound();
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
Melody: public Melody
    psha | pshb
        do
            ldab 0,x
        while ne
            inx
            ldaa #$31 | jsr SNSCOM
            pshb
                ldab 0,x
                pshx
                    if ne
                        ldx #cycles
                        aslb
                        abx
                        ldaa 0,x | jsr SNSCOM
                        ldaa 1,x | jsr SNSCOM
                    else
                        clra | jsr SNSCOM
                        clra | jsr SNSCOM
                    endif
                pulx
                inx
            pulb
            clra
            asld | asld | asld | asld
            subd #1
            jsr SNSCOM
            tba | jsr SNSCOM

            ldaa #$31 | jsr SNSCOM
            clra | jsr SNSCOM
            ldaa #1 | jsr SNSCOM
            clra | jsr SNSCOM
            ldaa #1 | jsr SNSCOM
        wend
    pulb | pula
rts


; void Sound_Loose();
loose_notes:
    defb N64,C4, 0
Sound_Loose_: public Sound_Loose_
    ldx #loose_notes
bra Melody


; void Sound_Hit();
cseg
hit_notes:
    defb N64,F4, N64,G4, N64,A4, N64,B4, N64,C5, N64,D5, N64,E5, N64,F5
    defb 0 
Sound_Hit:
    ldx #hit_notes
bra Melody
Sound_Hit_:  public Sound_Hit_
    ldx #Sound_Hit
    stx SoundProc
rts


; void Sound_Stole();
stole_notes:
    defb N64,F5, N64,E5, N64,D5, N64,C5, N64,B4, N64,A4, N64,G4, N64,F4, 0
    defb 0 
Sound_Stole:
    ldx #stole_notes
bra Melody
Sound_Stole_: public Sound_Stole_
    ldx #Sound_Stole
    stx SoundProc
rts


; void Sound_Beep();
beep_notes:
    defb N64,A4, 0
Sound_Beep_:  public Sound_Beep_
    ldx #beep_notes
bra Melody


; void Sound_Fire();
Sound_Fire_:  public Sound_Fire_
    ldx #Sound_Beep_
    stx SoundProc
rts


; void Sound_Bonus();
bonus_notes:
    defb N64,C4, N64, C4S, N64,D4, N64,F4, N64,A4, N64,C5, 0
Sound_Bonus_: public Sound_Bonus_
    ldx #bonus_notes
bra Melody


; void Sound_Start();
cseg
start_notes:
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    ldx #start_notes
bra Melody


; void Sound_Clear();
clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    ldx #clear_notes
bra Melody


; void Sound_GameOver();
cseg
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    ldx #over_notes
bra Melody


N1 equ 37500/Tempo
N2 equ 18750/Tempo
N2P equ 28125/Tempo
N4 equ 9375/Tempo
N4P equ 14063/Tempo
N8 equ 4688/Tempo
N64 equ 586/Tempo

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
defw 1174 ;C4
defw 1108 ;C#4
defw 1046 ;D4
defw 987 ;D#4
defw 932 ;E4
defw 879 ;F4
defw 830 ;F#4
defw 783 ;G4
defw 740 ;G#4
defw 698 ;A4
defw 659 ;A#4
defw 622 ;B4
defw 587 ;C5
defw 554 ;C#5
defw 523 ;D5
defw 494 ;D#5
defw 466 ;E5
defw 440 ;F5
defw 415 ;F#5
defw 392 ;G5
