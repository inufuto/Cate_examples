include "GameCom.inc"

Tempo equ 180
MaxVol equ 1fh

dseg
Channels: public Channels
Melody_Current:
    defw 0
Melody_Start:
    defw 0
Melody_Len:
    defb 0
Melody_Vol:
    defb 0
Bass_Current:
    defw 0
Bass_Start:
    defw 0
Bass_Tone:
    defw 0
Bass_Len:
    defb 0
Bass_Vol:
    defb 0
Effect_Current:
    defw 0
Effect_Len:
    defb 0
Effect_Vol:
    defb 0
time:
    defw 0

cseg
PianoWave:
	defb 0efh,0ach,89h,56h,44h,23h,22h,12h
	defb 10h,22h,22h,43h,54h,86h,0a9h,0ech
BassWave:
	defb 99h,78h,45h,23h,11h,00h,10h,21h
	defb 22h,11h,00h,10h,21h,43h,75h,98h
InitSound: public InitSound
    mov r SGC,0
    
    movw rr0,PianoWave
    mov r2,60h
    do
        mov r3,(rr0)+
        mov (r2)+,r3
        cmp r2,70h
    while nz | wend
    movw rr0,BassWave
    do
        mov r3,(rr0)+
        mov (r2)+,r3
        cmp r2,80h
    while nz | wend

    xorw rr0,rr0
    movw @Melody_Current,rr0
    movw @Bass_Current,rr0
    movw @Effect_Current,rr0

    mov r SGC,80h
    clr r0
    ; mov r SG0L,r0
    ; mov r SG1L,r0
    mov @time,r0
    mov @time+1,r0
ret


SoundHandler: public SoundHandler
    pushw rr0
        movw rr0,@time
        subw rr0,Tempo
        if c
            pushw rr0 | pushw rr2 | push r4
                movw rr2,@Melody_Current
                or r2,r2
                if nz
                    mov r0,@Melody_Len
                    dec r0
                    mov @Melody_Len,r0
                    if z
                        continue0:
                        mov r0,(rr2)+ ; length
                        or r0,r0
                        if z
                            ; end
                            clr r1
                            movw @Melody_Current,rr0
                            mov @Melody_Vol,r0
                            bclr r SGC,0
                            br t,next0
                        endif
                        cmp r0,0ffh
                        if z
                            ; repeat
                            movw rr2,@Melody_Start
                            br t,continue0
                        endif
                        mov @Melody_Len,r0
                        mov r1,(rr2)+ ; scale
                        movw @Melody_Current,rr2
                        or r1,r1
                        if nz
                            call ToCycle
                            movw rr SG0TH,rr0
                            mov r0,MaxVol | mov @Melody_Vol,r0
                            bset r SGC,0
                        else
                            mov @Melody_Vol,r1
                            bclr r SGC,0
                        endif
                    endif
                    mov r0,@Melody_Vol
                    or r0,r0
                    if nz
                        dec r0
                        mov @Melody_Vol,r0
                        mov r SG0L,r0
                    endif
                endif
                next0:
                
                movw rr2,@Bass_Current
                or r2,r2
                if nz
                    mov r0,@Bass_Len
                    dec r0
                    mov @Bass_Len,r0
                    if z
                        continue1:
                        mov r0,(rr2)+ ; length
                        or r0,r0
                        if z
                            ; end
                            clr r1
                            movw @Bass_Current,rr0
                            mov @Bass_Vol,r0
                            mov r0,@Effect_Vol
                            or r0,r0
                            if z
                                bclr r SGC,1
                            endif
                            br t,next1
                        endif
                        cmp r0,0ffh
                        if z
                            ; repeat
                            movw rr2,@Bass_Start
                            br t,continue1
                        endif
                        mov @Bass_Len,r0
                        mov r1,(rr2)+ ; scale
                        movw @Bass_Current,rr2
                        or r1,r1
                        if nz
                            call ToCycle
                            movw @Bass_Tone,rr0
                            mov r4,@Effect_Vol
                            or r4,r4
                            if z
                                movw rr SG1TH,rr0
                            endif
                            mov r0,MaxVol | mov @Bass_Vol,r0
                            bset r SGC,1
                        else
                            mov @Bass_Vol,r1
                            mov r0,@Effect_Vol
                            or r0,r0
                            if z
                                bclr r SGC,1
                            endif
                        endif
                    endif
                    mov r0,@Bass_Vol
                    or r0,r0
                    if nz
                        dec r0
                        mov @Bass_Vol,r0
                        mov r4,@Effect_Vol
                        or r4,r4
                        if z
                            mov r SG1L,r0
                        endif
                    endif
                endif
                next1:

                movw rr2,@Effect_Current
                or r2,r2
                if nz
                    mov r0,@Effect_Len
                    dec r0
                    mov @Effect_Len,r0
                    if z
                        continue2:
                        mov r0,(rr2)+ ; length
                        or r0,r0
                        if z
                            ; end
                            clr r1
                            movw @Effect_Current,rr0
                            mov @Effect_Vol,r0
                            mov r0,@Bass_Vol
                            or r0,r0
                            if nz
                                mov r SG1L,r0
                                movw rr0,@Bass_Tone
                                movw rr SG1TH,rr0
                                br t,next2
                            endif
                            bclr r SGC,1
                            br t,next2
                        endif
                        ; cmp r0,0ffh
                        ; if z
                        ;     ; repeat
                        ;     movw rr2,@Effect_Start
                        ;     br t,continue2
                        ; endif
                        mov @Effect_Len,r0
                        mov r1,(rr2)+ ; scale
                        movw @Effect_Current,rr2
                        or r1,r1
                        if nz
                            call ToCycle
                            movw rr SG1TH,rr0
                            mov r0,MaxVol | mov @Effect_Vol,r0
                            bset r SGC,1
                        else
                            mov @Effect_Vol,r1
                            bclr r SGC,1
                        endif
                    endif
                    mov r0,@Effect_Vol
                    or r0,r0
                    if nz
                        dec r0
                        mov @Effect_Vol,r0
                        mov r SG1L,r0
                    endif
                endif
                next2:
            pop r4 | popw rr2 | popw rr0
            addw rr0,600/2
        endif
        movw @time,rr0
    popw rr0
ret
ToCycle:
    dec r1
    sll r1
    clr r0
    addw rr0,cycles
    movw rr0,@rr0
ret

PlayMelody:
    di
        movw @Melody_Current,rr0
        pushw rr0
            mov r0,1 
            mov @Melody_Len,r0
        popw rr0
    ei
ret

PlayMelodyWait:
    call PlayMelody
    do
        movw rr0,@Melody_Current
        orw rr0,rr0
    while nz | wend
ret 


PlayEffect:
    di
        movw @Effect_Current,rr0
        pushw rr0
            mov r0,1 
            mov @Effect_Len,r0
        popw rr0
    ei
ret

PlayEffectWait:
    call PlayEffect
    do
        movw rr0,@Effect_Current
        orw rr0,rr0
    while nz | wend
ret 


; void Sound_Loose();
cseg
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    pushw rr0
        movw rr0,loose_notes
        call PlayEffectWait
    popw rr0
ret


; void Sound_Hit();
cseg
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0
Sound_Hit_: public Sound_Hit_
    pushw rr0
        movw rr0,hit_notes
        call PlayEffect
    popw rr0
ret


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4
    defb 0
Sound_Stole_: public Sound_Stole_
    pushw rr0
        movw rr0,stole_notes
        call PlayEffect
    popw rr0
ret


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5
    defb 0
Sound_Fire_: public Sound_Fire_
    pushw rr0
        movw rr0,fire_notes
        call PlayEffect
    popw rr0
ret


; void Sound_Bonus();
cseg
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5
    defb 0
Sound_Bonus_: public Sound_Bonus_
    pushw rr0
        movw rr0,bonus_notes
        call PlayEffectWait
    popw rr0
ret


; void Sound_Start();
cseg
start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    pushw rr0
        movw rr0,start_notes
        call PlayMelodyWait
    popw rr0
ret


; void Sound_Clear();
cseg
clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    pushw rr0
        movw rr0,clear_notes
        call PlayMelodyWait
    popw rr0
ret


; void Sound_GameOver();
cseg
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    pushw rr0
        movw rr0,over_notes
        call PlayMelodyWait
    popw rr0
ret


BGM_B:
    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,D4, N4,D4, N8,D4, N4,E4, N4P,D4
    defb N2P,0

    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,F4, N4,F4, N8,F4, N4,A4, N4P,G4
    defb N2P,0

    defb N8,E4, N8,E4, N8,E4, N4,E4, N8,E4, N4,A4
    defb N8,D4, N8,D4, N8,D4, N4,D4, N8,D4, N4,G4
    defb N8,0, N8,A4, N8,0, N8,G4, N8,0, N8,F4, N8,0, N8,E4
    defb N4,D4, N4,E4, N2,C4

    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G2, N4,0, N8,G2; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G2, N4,0, N8,G2; 12
    defb N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

    defb 0ffh

; void StartBGM();
StartBGM_: public StartBGM_
    pushw rr0
        di
            movw rr0,BGM_B | movw @Melody_Current,rr0 | movw @Melody_Start,rr0
            movw rr0,BGM_C | movw @Bass_Current,rr0 | movw @Bass_Start,rr0
            mov r0,1 | mov @Melody_Len,r0 | mov @Bass_Len,r0
        ei
    popw rr0
ret

; void StopBGM();
cseg
StopBGM_: public StopBGM_
    pushw rr0
        di
            xorw rr0,rr0
            movw @Melody_Current,rr0
            movw @Bass_Current,rr0
            mov @Melody_Vol,r0 | mov @Bass_Vol,r0
            bclr r SGC,0
            bclr r SGC,1
        ei
    popw rr0
ret

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

E2 equ 1
F2 equ 2
F2S equ 3
G2 equ 4
G2S equ 5
A2 equ 6
A2S equ 7
B2 equ 8
C3 equ 9
C3S equ 10
D3 equ 11
D3S equ 12
E3 equ 13
F3 equ 14
F3S equ 15
G3 equ 16
G3S equ 17
A3 equ 18
A3S equ 19
B3 equ 20
C4 equ 21
C4S equ 22
D4 equ 23
D4S equ 24
E4 equ 25
F4 equ 26
F4S equ 27
G4 equ 28
G4S equ 29
A4 equ 30
A4S equ 31
B4 equ 32
C5 equ 33
C5S equ 34
D5 equ 35
D5S equ 36
E5 equ 37
F5 equ 38
F5S equ 39
G5 equ 40

cycles:
defw 1896 ; E2
defw 1790 ; F2
defw 1689 ; F#2
defw 1594 ; G2
defw 1505 ; G#2
defw 1420 ; A2
defw 1341 ; A#2
defw 1265 ; B2
defw 1194 ; C3
defw 1127 ; C#3
defw 1064 ; D3
defw 1004 ; D#3
defw 948 ; E3
defw 895 ; F3
defw 845 ; F#3
defw 797 ; G3
defw 752 ; G#3
defw 710 ; A3
defw 670 ; A#3
defw 633 ; B3
defw 597 ; C4
defw 564 ; C#4
defw 532 ; D4
defw 502 ; D#4
defw 474 ; E4
defw 447 ; F4
defw 422 ; F#4
defw 399 ; G4
defw 376 ; G#4
defw 355 ; A4
defw 335 ; A#4
defw 316 ; B4
defw 299 ; C5
defw 282 ; C#5
defw 266 ; D5
defw 251 ; D#5
defw 237 ; E5
defw 224 ; F5
defw 211 ; F#5
defw 199 ; G5
