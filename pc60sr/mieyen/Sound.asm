ext WaitTimer_

Port_Register equ 0a0h
Port_Out equ 0a1h

Psg_Tone_A equ 0
Psg_Tone_B equ 2
Psg_Tone_C equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_Volume_A equ 8
Psg_Volume_B equ 9
Psg_Volume_C equ 10
Psg_EnvTime equ 11
Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 15

Opn_OnOff equ 28h
Opn_Part equ 30h

MaxVol equ 63

Tempo equ 180

PsgCount equ 3
OpnCount equ 3
AllCount equ PsgCount+OpnCount
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

    dseg
Channels defs unitSize*AllCount
time: defw 0


cseg

WaitPort:
    nop | nop | nop | nop
ret

; BassTone:
;     defb 58,48,48,48
;     defb 36,18,45,0
;     defb 31,95,31,95
;     defb 18,10,14,10
;     defb 0,4,4,3
;     defb 38,38,38,38
;     defb 58
; BassTone:
;     defb 96,96,96,96
;     defb 23,23,63,0
;     defb 158,156,152,156
;     defb 14,4,10,5
;     defb 8,9,9,9
;     defb 182,198,198,198
;     defb 48
BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
PianoTone:
    defb 15,82,50,2
    defb 65,27,0,0
    defb 94,94,94,158
    defb 15,8,7,8
    defb 5,5,5,5
    defb 214,214,216,216
    defb 60
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60


SetTone:
    ld b,24
    do
        call WaitPort
        ld a,c
        out (Port_Register),a
        ld a,(hl) | inc hl
        out (Port_Out),a
        inc c | inc c | inc c | inc c
    dwnz
    ld a,c | add a,20h
    out (Port_Register),a
    ld a,(hl) | inc hl
    out (Port_Out),a
ret

InitSound: public InitSound
    ld hl,Channels
    xor a
    ld b,AllCount*unitSize
    do
        ld (hl),a
        inc hl
    dwnz
    ld hl,0
    ld (time),hl

    ld a,Psg_Mixer
    out (Port_Register),a
    ld a,38h
    out (Port_Out),a

    ld hl,BassTone
    ld c,Opn_Part
    call SetTone

    ld hl,PianoTone
    ld c,Opn_Part+1
    call SetTone

    ld hl,SnareTone
    ld c,Opn_Part+2
    call SetTone

    ld bc,OpnCount * 256
    do
        call WaitPort
        ld a,Opn_OnOff
        out (Port_Register),a
        ld a,(0)
        ld a,c
        out (Port_Out),a
        inc c
    dwnz
ret

SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,PsgCount * 100h ; b = count; c = register
                do
                    ld l,(ix+Channel_Ptr)
                    ld h,(ix+Channel_Ptr+1)
                    ld a,l
                    or h
                    if nz
                        dec (ix+Channel_Len)
                        if z
                            continue:
                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Channel_Ptr),a
                                ld (ix+Channel_Ptr+1),a
                                ld a,c
                                add a,Psg_Volume_A
                                out (Port_Register),a
                                xor a
                                out (Port_Out),a
                                jr next
                            endif
                            inc a
                            if z 
                                ; repeat
                                ld l,(ix+Channel_Start)
                                ld h,(ix+Channel_Start+1)
                                jr continue
                            endif
                            dec a
                            ld (ix+Channel_Len),a
                            inc hl
                            ld a,(hl)
                            inc hl
                            ld (ix+Channel_Ptr),l
                            ld (ix+Channel_Ptr+1),h
                            or a
                            if nz
                                dec a
                                add a,a
                                ld e,a
                                ld d,0
                                ld hl,cycles
                                add hl,de
                                ld a,c
                                add a,a
                                ld e,a
                                out (Port_Register),a
                                ld a,(hl)
                                inc hl
                                out (Port_Out),a
                                ld a,e
                                inc a
                                out (Port_Register),a
                                ld a,(hl)
                                out (Port_Out),a
                                ld (ix+Channel_Vol),MaxVol
                            else
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_Volume_A
                        out (Port_Register),a
                        ld a,(ix+Channel_Vol)
                        srl a | srl a
                        out (Port_Out),a
                        ld a,(ix+Channel_Vol)
                        or a
                        if nz
                            dec a
                            ld (ix+Channel_Vol),a
                        endif
                    endif
                    next:
                    inc c
                    ld de,unitSize
                    add ix,de
                dwnz
                ld bc,300h ; b = count; c = channel
                do
                    ld l,(ix+Channel_Ptr)
                    ld h,(ix+Channel_Ptr+1)
                    ld a,l
                    or h
                    if nz
                        dec (ix+Channel_Len)
                        if z
                            ld a,(ix+Channel_Vol)
                            or a
                            if nz
                                call WaitPort
                                ld a,Opn_OnOff
                                out (Port_Register),a
                                ld a,(0)
                                ld a,c
                                out (Port_Out),a
                                ld (ix+Channel_Vol),0
                            endif
                            continue2:
                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Channel_Ptr),a
                                ld (ix+Channel_Ptr+1),a
                                jr next2
                            endif
                            inc a
                            if z 
                                ; repeat
                                ld l,(ix+Channel_Start)
                                ld h,(ix+Channel_Start+1)
                                jr continue2
                            endif
                            dec a
                            ld (ix+Channel_Len),a
                            inc hl
                            ld a,(hl)
                            inc hl
                            ld (ix+Channel_Ptr),l
                            ld (ix+Channel_Ptr+1),h
                            or a
                            if nz
                                dec a
                                add a,a
                                ld e,a
                                ld d,0
                                ld hl,OpnScales
                                add hl,de
                                ld a,c
                                add a,0a4h
                                call WaitPort
                                out (Port_Register),a
                                ld a,(0)
                                ld a,(hl)
                                inc hl
                                out (Port_Out),a
                                call WaitPort
                                ld a,c
                                add a,0a0h
                                out (Port_Register),a
                                ld a,(0)
                                ld a,(hl)
                                out (Port_Out),a

                                call WaitPort
                                ld a,Opn_OnOff
                                out (Port_Register),a
                                ld a,(0)
                                ld a,c
                                or 0f0h
                                out (Port_Out),a
                                ld (ix+Channel_Vol),0ffh
                            endif
                        endif
                    endif
                    next2:
                    inc c
                    ld de,unitSize
                    add ix,de
                dwnz
            pop ix | pop bc | pop hl
            ld de,500/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody0:
    push af
        di
            ld (Channels+Channel_Ptr),hl
            ld a,1
            ld (Channels+Channel_Len),a
            ld a,Psg_Volume_A
            out (Port_Register),a
            xor a
            out (Port_Out),a
        ei
    pop af
ret


MelodyWait0:
    call Melody0
    push af
        do
            ld hl,(Channels+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
ret 

Melody4:
    push af
        di
            ld (Channels+unitSize*4+Channel_Ptr),hl
            ld a,1
            ld (Channels+unitSize*4+Channel_Len),a
        ei
    pop af
ret


MelodyWait4:
    call Melody4
    push af
        do
            ld hl,(Channels+unitSize*4+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
ret 


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push hl
        ld hl,loose_notes
        call MelodyWait0
    pop hl
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push hl
        ld hl,hit_notes
        call Melody0
    pop hl
ret


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    push hl
        ld hl,stole_notes
        call Melody0
    pop hl
ret


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push hl
        ld hl,fire_notes
        call Melody0
    pop hl
ret


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push af | push hl
        ld hl,bonus_notes
        call MelodyWait0
    pop hl | pop af
ret


; void Sound_Start();
start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait4
    pop hl
ret

; void Sound_Clear();
clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push hl
        ld hl,clear_notes
        call MelodyWait4
    pop hl
ret

; void Sound_GameOver();
over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait4
    pop hl
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
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 3
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0; 4
    defb N8,D4, N4,0, N4P,F4, N8,A3, N8,0; 5
    defb N8,G3, N4,0, N4P,B3, N8,D4, N8,0; 6

    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 7
    defb N8,A3, N4,0, N4P,C4, N8,E4, N8,0; 8
    defb N8,F4, N4,0, N8,F4, N8,G3, N4,0, N8,G3; 9
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 10

    defb N8,C4, N4,0, N8,C4, N8,A3, N4,0, N8,A3; 11
    defb N8,D4, N4,0, N8,D4, N8,G3, N4,0, N8,G3; 12
    defb N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,G3, N8,0, N8,G3
    defb N8,C4, N4,0, N4P,E4, N8,G4, N8,0; 14

    defb 0ffh
BGM_D:
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4

    defb N8,0, N8,A4, N8,0, N8,A4, N8,0, N8,A4, N8,0, N8,A4
    defb N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4
    
    defb 0ffh


StartBGM_: public StartBGM_
    push af | push hl
        di
        ld a,1
        ld hl,BGM_B
        ld (Channels+unitSize*4+Channel_Start),hl
        ld (Channels+unitSize*4+Channel_Ptr),hl
        ld (Channels+unitSize*4+Channel_Len),a
        ld hl,BGM_C
        ld (Channels+unitSize*3+Channel_Start),hl
        ld (Channels+unitSize*3+Channel_Ptr),hl
        ld (Channels+unitSize*3+Channel_Len),a
        ld hl,BGM_D
        ld (Channels+unitSize*5+Channel_Start),hl
        ld (Channels+unitSize*5+Channel_Ptr),hl
        ld (Channels+unitSize*5+Channel_Len),a
        ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
            ld hl,0
            ld (Channels+unitSize*4+Channel_Ptr),hl
            ld (Channels+unitSize*3+Channel_Ptr),hl
            ld (Channels+unitSize*5+Channel_Ptr),hl
            ld a,1
            ld (Channels+unitSize*4+Channel_Len),a
            ld (Channels+unitSize*3+Channel_Len),a
            ld (Channels+unitSize*5+Channel_Len),a
            
            ld bc,3*256 or Psg_Volume_A
            do
                ld a,c
                out (Port_Register),a
                xor a
                out (Port_Out),a
                inc c
            dwnz
            ld bc,300h
            do
                call WaitPort
                ld a,Opn_OnOff
                out (Port_Register),a
                ld a,(0)
                ld a,c
                out (Port_Out),a
                inc c
            dwnz
        ei
        ld a,10
        call WaitTimer_
    pop bc | pop hl | pop af
ret


E3 equ 1
F3 equ 2
F3S equ 3
G3 equ 4
G3S equ 5
A3 equ 6
A3S equ 7
B3 equ 8
C4 equ 9
C4S equ 10
D4 equ 11
D4S equ 12
E4 equ 13
F4 equ 14
F4S equ 15
G4 equ 16
G4S equ 17
A4 equ 18
A4S equ 19
B4 equ 20
C5 equ 21
C5S equ 22
D5 equ 23
D5S equ 24
E5 equ 25
F5 equ 26
F5S equ 27
G5 equ 28

cycles:
defw 757 ; E3
defw 714 ; F3
defw 674 ; F#3
defw 636 ; G3
defw 601 ; G#3
defw 567 ; A3
defw 535 ; A#3
defw 505 ; B3
defw 477 ; C4
defw 450 ; C#4
defw 424 ; D4
defw 401 ; D#4
defw 378 ; E4
defw 357 ; F4
defw 337 ; F#4
defw 318 ; G4
defw 300 ; G#4
defw 283 ; A4
defw 267 ; A#4
defw 252 ; B4
defw 238 ; C5
defw 225 ; C#5
defw 212 ; D5
defw 200 ; D#5
defw 189 ; E5
defw 178 ; F5
defw 168 ; F#5
defw 159 ; G5

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

OpnScales:
defb 19,11 ; E3
defb 19,57 ; F3
defb 19,106 ; F#3
defb 19,158 ; G3
defb 19,213 ; G#3
defb 20,16 ; A3
defb 20,78 ; A#3
defb 20,143 ; B3
defb 26,106 ; C4
defb 26,143 ; C#4
defb 26,182 ; D4
defb 26,223 ; D#4
defb 27,11 ; E4
defb 27,57 ; F4
defb 27,106 ; F#4
defb 27,158 ; G4
defb 27,213 ; G#4
defb 28,16 ; A4
defb 28,78 ; A#4
defb 28,143 ; B4
defb 34,106 ; C5
defb 34,143 ; C#5
defb 34,182 ; D5
defb 34,223 ; D#5
defb 35,11 ; E5
defb 35,57 ; F5
defb 35,106 ; F#5
defb 35,158 ; G5
