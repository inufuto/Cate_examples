include "InternalRam.inc"

Tempo equ 200
WaitCount equ 1
PortMask equ 01h
BeepLow equ 20h
BeepOn equ 10h

dseg
    defb 0
SoundProc: public SoundProc
    defw 0
    defb 0


cseg
InitSound: public InitSound
    lia 78h ; call
    lidp SoundProc-1|std
    lia 0
    lidp SoundProc|std
    lidp SoundProc+1|std
    lia 37h ; rtn
    lidp SoundProc+2|std
rtn


; void CallSound();
cseg
CallSound_: public CallSound_
    push
    exab|push
        lidp SoundProc|ldd
        cpia 0
        if nz
            lidp SoundProc+1|ldd
            cpia 0
            if nz
                call SoundProc-1
                lia 0
                lidp SoundProc|std
                lidp SoundProc+1|std
            endif            
        endif
    pop|exab
    pop
rtn


cseg
Tone: public Tone
; a=cycle, b,i=length
    lip 5fh
    do
        exab|push|exab
            do
                anim PortMask
                orim BeepOn
                outc
                push
                    do
                        nopw
                        deca
                    while nz|wend
                pop
                anim PortMask
                outc
                push
                    do
                        nopw
                        deca
                    while nz|wend
                pop
                decb
            while nz|wend
        exab|pop|exab
        deci
    while nz|wend
rtn


Rest: public Rest
    do
        exab|push|exab
            do
                lip 5fh
                anim PortMask
                orim 00h
                outc
                push
                    do
                        nopw
                        deca
                    while nz|wend
                pop
                lip 5fh
                anim PortMask
                outc
                push
                    do
                        nopw
                        deca
                    while nz|wend
                pop
                decb
            while nz|wend
        exab|pop|exab
        deci
    while nz|wend
rtn


Melody:; x=score-1
    exab|push|exab
    lp RegisterI|exam|push|exam
        do
            ixl
            cpia 0
        while nz
            lp RegisterI|exam
            ixl
            exab
                lp RegisterX+1|ldm|push
                lp RegisterX|ldm|push
            exab
            cpia 0
            if nz
                sl ;*2
                exab
                    lia high(cycles-2-1)|lp RegisterX+1|exam
                    lia low(cycles-2-1)|lp RegisterX|exam
                exab
                lib 0
                adb
                ixl|exab
                ixl
                call Tone
            else
                lia high(cycles-1)|lp RegisterX+1|exam
                lia low(cycles-1)|lp RegisterX|exam
                ixl|exab
                ixl
                call Rest
            endif
            lp RegisterX|pop|exam
            lp RegisterX+1|pop|exam
        wend
    lp RegisterI|exam|pop|exam
    exab|pop|exab
rtn


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire:
    push
    lp RegisterX+1|exam|push|exam
    lp RegisterX|exam|push|exam
        lia low(fire_notes-1)|lp RegisterX+0|exam
        lia high(fire_notes-1)|lp RegisterX+1|exam
        call Melody
    lp RegisterX+1|exam|pop|exam
    lp RegisterX|exam|pop|exam
    pop
rtn
Sound_Fire_: public Sound_Fire_
    push
        lia low Sound_Fire | lidp SoundProc+1 | std
        lia high Sound_Fire | lidp SoundProc | std
    pop
rtn


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit: 
    push
    lp RegisterX+1|exam|push|exam
    lp RegisterX|exam|push|exam
        lia low(hit_notes-1)|lp RegisterX+0|exam
        lia high(hit_notes-1)|lp RegisterX+1|exam
        call Melody
    lp RegisterX+1|exam|pop|exam
    lp RegisterX|exam|pop|exam
    pop
rtn
Sound_Hit_: public Sound_Hit_
    push
        lia low Sound_Hit | lidp SoundProc+1 | std
        lia high Sound_Hit | lidp SoundProc | std
    pop
rtn


; void Sound_Loose();
cseg
loose_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Loose: 
    push
    lp RegisterX+1|exam|push|exam
    lp RegisterX|exam|push|exam
        lia low(loose_notes-1)|lp RegisterX+0|exam
        lia high(loose_notes-1)|lp RegisterX+1|exam
        call Melody
    lp RegisterX+1|exam|pop|exam
    lp RegisterX|exam|pop|exam
    pop
rtn
Sound_Loose_: public Sound_Loose_
    push
        lia low Sound_Loose | lidp SoundProc+1 | std
        lia high Sound_Loose | lidp SoundProc | std
    pop
rtn


; void Sound_Start();
cseg
start_notes: 
	defb 5,A4,1,0, 11,B4,1,0, 11,C5,1,0
	defb 11,C5,1,0, 5,A4,1,0, 11,D5,1,0
	defb 11,D5,1,0, 5,C5,1,0, 17,D5,1,0
	defb 35-15,E5,15,E5, 1,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push
    lp RegisterX+1|exam|push|exam
    lp RegisterX|exam|push|exam
        lia low(start_notes-1)|lp RegisterX+0|exam
        lia high(start_notes-1)|lp RegisterX+1|exam
        call Melody
    lp RegisterX|exam|pop|exam
    lp RegisterX+1|exam|pop|exam
    pop
rtn


; void Sound_GameOver();
cseg
over_notes:
	defb 11,A4,1,0, 5,E4,1,0, 5,A4,1,0
	defb 5,G4,1,0, 5,F4,1,0, 5,E4,1,0, 5,D4,1,0
	defb 35-15,E4,15,E4,1,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push
    lp RegisterX+1|exam|push|exam
    lp RegisterX|exam|push|exam
        lia low(over_notes-1)|lp RegisterX+0|exam
        lia high(over_notes-1)|lp RegisterX+1|exam
        call Melody
    lp RegisterX+1|exam|pop|exam
    lp RegisterX|exam|pop|exam
    pop
rtn


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

cycles:
defb 880/Tempo,40 ; A3
defb 932/Tempo,37 ; A#3
defb 988/Tempo,35 ; B3
defb 1047/Tempo,33 ; C4
defb 1109/Tempo,31 ; C#4
defb 1175/Tempo,30 ; D4
defb 1245/Tempo,28 ; D#4
defb 1319/Tempo,26 ; E4
defb 1397/Tempo,25 ; F4
defb 1480/Tempo,24 ; F#4
defb 1568/Tempo,22 ; G4
defb 1661/Tempo,21 ; G#4
defb 1760/Tempo,20 ; A4
defb 1865/Tempo,19 ; A#4
defb 1976/Tempo,18 ; B4
defb 2093/Tempo,17 ; C5
defb 2217/Tempo,16 ; C#5
defb 2349/Tempo,15 ; D5
defb 2489/Tempo,14 ; D#5
defb 2637/Tempo,13 ; E5
defb 2794/Tempo,12 ; F5
defb 2960/Tempo,12 ; F#5
defb 3136/Tempo,11 ; G5
