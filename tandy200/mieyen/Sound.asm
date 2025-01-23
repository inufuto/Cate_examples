ext WaitTimer_

PortB equ $b2
LoPort equ $b4
HighPort equ $b5

Tempo equ 180

Count equ 2
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1

dseg
Channels: public Channels
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
Time:
    defw 0


cseg
OffAll:
    di
        lxi h,Channels
        mvi b,Count*UnitSize
        xra a
        do
            mov m,a | inx h
            dcr b
        while nz | wend
    ei
ret
InitSound: public InitSound
    call OffAll
    di
        lxi h,0
        shld Time
    ei
ret


ToneOn:
; in
;   de : cycle
    push psw
        mov a,e | out LoPort
        mov a,d | ori $40 | out HighPort
        mvi a,$c3 | out $b8
        in PortB
        ani not $04
        ori $20
        out PortB
    pop psw
ret

ToneOff: public ToneOff
    push psw
        in PortB
        ani not $20
        ori $04
        out PortB
    pop psw
ret


SoundHandler: public SoundHandler
    push h | push d
        lhld Time
        lxi d,-Tempo
        dad d
        if nc
            push psw | push h | push b
                lxi h,Channels
                mvi b,Count
                do
                    mov e,m | inx h ; Channel_Ptr
                    mov d,m | dcx h
                    mov a,e | ora d
                    if nz
                        inx h | inx h | inx h | inx h | inx h | inx h
                        dcr m ; Channel_Len
                        dcx h | dcx h | dcx h | dcx h | dcx h | dcx h
                        if z
                            continue:
                            ldax d ; length
                            ora a
                            if z
                                ; end
                                mov m,a | inx h ; Channel_Ptr
                                mov m,a | dcx h
                                offch:
                                inx h | inx h | inx h | inx h
                                mov m,a | inx h ; Channel_Tone
                                mov m,a | dcx h
                                dcx h | dcx h | dcx h | dcx h
                                mov a,b
                                cpi Count
                                if z
                                    ; Channel0
                                    push h
                                        lxi h,Channel1+Channel_Tone
                                        mov e,m | inx h
                                        mov d,m
                                    pop h
                                    mov a,e | ora d
                                    if nz
                                        call ToneOn
                                        jmp next
                                    endif
                                endif
                                call ToneOff
                                jmp next
                            endif
                            inr a
                            if z
                                ; repeat
                                inx h | inx h
                                mov e,m | inx h ; Channel_Start
                                mov d,m | dcx h
                                dcx h | dcx h
                                jmp continue
                            endif
                            dcr a
                            inx h | inx h | inx h | inx h | inx h | inx h
                            mov m,a ; Channel_Len
                            dcx h | dcx h | dcx h | dcx h | dcx h | dcx h

                            inx d
                            ldax d ; tone
                            inx d
                            mov m,e | inx h ; Channel_Ptr
                            mov m,d | dcx h
                            ora a
                            jz offch
                            dcr a
                            push h
                                add a
                                mov l,a | mvi h,0
                                lxi d,cycles | dad d
                                mov e,m | inx h
                                mov d,m
                            pop h
                            inx h | inx h | inx h | inx h
                            mov m,e | inx h ; Channel_Tone
                            mov m,d | dcx h
                            dcx h | dcx h | dcx h | dcx h
                            mov a,b
                            cpi 1
                            if z
                                ; Channel1
                                push h
                                    lhld Channel0+Channel_Tone
                                    mov a,l | ora h
                                pop h
                                jnz next
                            endif
                            call ToneOn
                        endif
                    endif
                    next:
                    lxi d,UnitSize | dad d
                    dcr b
                while nz | wend
            pop b | pop h | pop psw
            lxi d,640/2 | dad d
        endif
        shld Time
    pop d | pop h
ret


Melody:
    di
        shld Channel0+Channel_Ptr  
        push psw
            mvi a,1
            sta Channel0+Channel_Len
        pop psw
    ei
ret

MelodyWait:
    call Melody
    push psw
        do
            lhld Channel0+Channel_Ptr
            mov a,l | ora h
        while nz | wend
    pop psw
ret 


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push psw | push h
        lxi h,loose_notes
        call MelodyWait
    pop h | pop psw
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_:  public Sound_Hit_
    push h
        lxi h,hit_notes
        call Melody
    pop h
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    push h
        lxi h,hit_notes
        call Melody
    pop h
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push h
        lxi h,fire_notes
        call Melody
    pop h
ret



bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push psw | push h
        lxi h,bonus_notes
        call MelodyWait
    pop h | pop psw
ret


start_notes:
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push h
        lxi h,start_notes
        call MelodyWait
    pop h
ret


clear_notes:
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push h
        lxi h,clear_notes
        call MelodyWait
    pop h
ret


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push h
        lxi h,over_notes
        call MelodyWait
    pop h
ret


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb $ff

StartBGM_: public StartBGM_
    push psw | push h
        di
            mvi a,1
            sta Channel1+Channel_Len
            lxi h,BGM_B
            shld Channel1+Channel_Start
            shld Channel1+Channel_Ptr
        ei
    pop h | pop psw
ret

StopBGM_: public StopBGM_
    push psw | push h | push d | push b
        call OffAll
        call ToneOff
    pop b | pop d | pop h | pop psw        
ret


G3 equ 1
G3S equ 2
A3 equ 3
A3S equ 4
B3 equ 5
C4 equ 6
C4S equ 7
D4 equ 8
D4S equ 9
E4 equ 10
F4 equ 11
F4S equ 12
G4 equ 13
G4S equ 14
A4 equ 15
A4S equ 16
B4 equ 17
C5 equ 18
C5S equ 19
D5 equ 20
D5S equ 21
E5 equ 22
F5 equ 23
F5S equ 24
G5 equ 25

cycles:
defw 12538 ; G3
defw 11835 ; G#3
defw 11170 ; A3
defw 10543 ; A#3
defw 9952 ; B3
defw 9393 ; C4
defw 8866 ; C#4
defw 8368 ; D4
defw 7899 ; D#4
defw 7455 ; E4
defw 7037 ; F4
defw 6642 ; F#4
defw 6269 ; G4
defw 5917 ; G#4
defw 5585 ; A4
defw 5271 ; A#4
defw 4976 ; B4
defw 4696 ; C5
defw 4433 ; C#5
defw 4184 ; D5
defw 3949 ; D#5
defw 3727 ; E5
defw 3518 ; F5
defw 3321 ; F#5
defw 3134 ; G5
