include "e500.inc"

ext WaitTimer_

Tempo equ 180

zseg
SoundProc:
    defp 0
toneLen:
    defw 0

cseg
InitSound: public InitSound
    mvp (<SoundProc),0
ret


; void CallSound();
cseg
CallSound_: public CallSound_
    pushs x
        mv x,(<SoundProc)
        inc x
        dec x
        if nz
            call JumpSoundProc
            mvp (<SoundProc),0
        endif
    pops x
ret
JumpSoundProc: jp x


cseg
Tone: ; i=cycle, ba=length
    mv (<toneLen),i
    pushu imr
        do
            or (SCR),10h
            mv i,(<toneLen)
            WAIT
            and (SCR),not 10h
            mv i,(<toneLen)
            WAIT
            dec ba
        while nz | wend
    popu imr
    mv i,(<toneLen)
ret

Rest: ; i=cycle, ba=length
    mv (<toneLen),i
    pushu imr
        do
            or (SCR),00h
            mv i,(<toneLen)
            WAIT
            and (SCR),not 00h
            mv i,(<toneLen)
            WAIT
            dec ba
        while nz | wend
    popu imr
ret


cseg
MakeLength:
    mvw dx,[y++]
    mv i,[y++]
    mv ba,0
    do
        add ba,i
        dec cl
    while nz | wend
    mv i,dx
ret
Melody:; x=score
    pushs ba | pushs i | pushs y | pushs cl | pushs dx
        do
            mv cl,[x++]
            cmp cl,0
        while nz
            mv dl,[x++]
            cmp dl,0
            if nz
                dec dl
                rc | shl dl | shl dl
                mv dh,0
                mv i,dx
                mv y,cycles
                add y,i
                call MakeLength
                call Tone
            else
                mv y,cycles
                call MakeLength
                call Rest
            endif
        wend
    pops dx | pops cl | pops y | pops i | pops ba
ret


; void Sound_Loose();
loose_notes:
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    pushs x
        mv x,loose_notes
        call Melody
    pops x
ret


; void Sound_Hit();
cseg
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit:
    pushs x
        mv x,hit_notes
        call Melody
    pops x
ret
Sound_Hit_:  public Sound_Hit_
    mvp (<SoundProc),Sound_Hit
ret


; void Sound_Stole();
cseg
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole:
    pushs x
        mv x,stole_notes
        call Melody
    pops x
ret
Sound_Stole_:  public Sound_Stole_
    mvp (<SoundProc),Sound_Stole
ret


; void Sound_Beep();
cseg
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    pushs x
        mv x,beep_notes
        call Melody
    pops x
ret
; void Sound_Fire();
cseg
Sound_Fire_:  public Sound_Fire_
    mvp (<SoundProc),Sound_Beep_
ret


; void Sound_Bonus();
cseg
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    pushs x
        mv x,bonus_notes
        call Melody
    pops x
ret


; void Sound_Start();
cseg
start_notes: 
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    pushs x
        mv x,start_notes
        call Melody
    pops x
ret


; void Sound_Clear();
cseg
clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pushs x
        mv x,clear_notes
        call Melody
    pops x
ret


; void Sound_GameOver();
cseg
over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pushs x
        mv x,over_notes
        call Melody
    pops x
ret


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

cseg
cycles:
defw 1470,1800000/Tempo/1470 ; C4
defw 1387,1800000/Tempo/1387 ; C4S
defw 1309,1800000/Tempo/1309 ; D4
defw 1236,1800000/Tempo/1236 ; D4S
defw 1166,1800000/Tempo/1166 ; E4
defw 1101,1800000/Tempo/1101 ; F4
defw 1039,1800000/Tempo/1039 ; F4S
defw 981,1800000/Tempo/981 ; G4
defw 926,1800000/Tempo/926 ; G4S
defw 874,1800000/Tempo/874 ; A4
defw 825,1800000/Tempo/825 ; A4S
defw 778,1800000/Tempo/778 ; B4
defw 735,1800000/Tempo/735 ; C5
defw 693,1800000/Tempo/693 ; C5S
defw 654,1800000/Tempo/654 ; D5
defw 618,1800000/Tempo/618 ; D5S
defw 583,1800000/Tempo/583 ; E5
defw 550,1800000/Tempo/550 ; F5
defw 519,1800000/Tempo/519 ; F5S
defw 490,1800000/Tempo/490 ; G5
