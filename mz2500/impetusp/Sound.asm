Port_Register equ 0c8h
Port_Out equ Port_Register+1

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

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
LowNoiseValue equ 30
HighNoiseValue equ LowNoiseValue*2/3

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
mixerValue: defb 0
shootingTone: defw 0

cseg
WaitPort:
    push af
        ld a,6
        do
            dec a
        while nz | wend
        do
            in a,(Port_Register)
            and 80h
        while nz | wend
    pop af
ret


BassTone:
    defb 96,96,102,97
    defb 33,40,20,0
    defb 31,31,148,31
    defb 15,5,16,13
    defb 7,6,6,7
    defb 40,23,71,87
    defb 58
; PianoTone:
;     defb 15,82,50,2
;     defb 65,27,0,0
;     defb 94,94,94,158
;     defb 15,8,7,8
;     defb 5,5,5,5
;     defb 214,214,216,216
;     defb 60
; GuiterTone:
;     defb 67,119,79,113
;     defb 10,23,22,8
;     defb 31,31,18,31
;     defb 4,4,1,12
;     defb 1,1,1,0
;     defb 16,16,24,24
;     defb 40
OrganTone:
    defb 114,116,20,18
    defb 50,0,0,0
    defb 31,29,29,29
    defb 20,0,0,0
    defb 0,0,0,0
    defb 72,10,10,10
    defb 54
; OrganTone:
;     defb 1,6,4,4
;     defb 26,33,0,0
;     defb 26,29,26,29
;     defb 0,0,0,0
;     defb 0,0,0,0
;     defb 5,5,8,8
;     defb 36
SnareTone:
    defb 15,0,0,0
    defb 14,19,17,0
    defb 31,31,31,31
    defb 0,24,15,19
    defb 0,0,17,16
    defb 8,184,44,44
    defb 60

Tones:
    defw BassTone,OrganTone,SnareTone


SetTone:
    ld b,24
    do
        call WaitPort
        ld a,c
        out (Port_Register),a
        ex (sp),hl | ex (sp),hl
        ld a,(hl) | inc hl
        out (Port_Out),a
        inc c | inc c | inc c | inc c
    dwnz
    ld a,c | add a,20h
    out (Port_Register),a
    ex (sp),hl | ex (sp),hl
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
    ld (shootingTone),hl

    ld a,0b8h and 07fh
    ld (mixerValue),a

    ld bc,OpnCount * 256
    do
        call WaitPort
        ld a,Opn_OnOff
        out (Port_Register),a
        ex (sp),hl | ex (sp),hl
        ld a,c
        out (Port_Out),a
        inc c
    dwnz
ret

SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(shootingTone)
        ld a,l
        or h
        if nz
            ld a,l
            ld a,Psg_Tone_A
            out (Port_Register),a
            ld a,l
            out (Port_Out),a
            ld a,Psg_Tone_A+1
            out (Port_Register),a
            ld a,h
            out (Port_Out),a
            ld de,15
            add hl,de
            ld a,h
            or a
            jr z,highzero
            ld a,l
            cp 300-256
            if nc
                ld a,Psg_Volume_A
                out (Port_Register),a
                xor a
                out (Port_Out),a
                ld l,0
            endif
            highzero:
            ld (shootingTone),hl
        endif

        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                exx
                    push bc
                    ld a,(mixerValue)                    
                    ld c,a
                    ld b,1
                exx
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
                            cp HighNoise
                            if z
                                ld e,HighNoiseValue
                                WriteNoise:
                                ld a,Psg_Noise
                                out (Port_Register),a
                                ld a,e
                                out (Port_Out),a
                                exx
                                    ld a,b
                                    or c
                                exx
                                ld e,a
                                exx
                                    ld a,b
                                    rlca
                                    rlca
                                    rlca
                                    cpl
                                exx
                                and e
                                exx
                                    ld c,a
                                exx
                                ld e,a
                                ld a,Psg_Mixer
                                out (Port_Register),a
                                ld a,e
                                out (Port_Out),a
                                ld (ix+Channel_Vol),MaxVol
                                jr EndWriteCycle
                            endif
                            cp LowNoise
                            if z
                                ld e,LowNoiseValue
                                jr WriteNoise
                            endif
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
                                exx
                                    ld a,b
                                    rlca
                                    rlca
                                    rlca
                                    or c
                                exx
                                ld e,a
                                exx
                                    ld a,b
                                    cpl
                                exx
                                and e
                                exx
                                    ld c,a
                                exx
                                ld e,a
                                ld a,Psg_Mixer
                                out (Port_Register),a
                                ld a,e
                                out (Port_Out),a
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
                    exx
                        sla b
                    exx
                dwnz
                exx
                    ld a,c
                    ld (mixerValue),a
                    pop bc
                exx
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
                                ex (sp),hl | ex (sp),hl
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
                                ex (sp),hl | ex (sp),hl
                                ld a,(hl)
                                inc hl
                                out (Port_Out),a
                                call WaitPort
                                ld a,c
                                add a,0a0h
                                out (Port_Register),a
                                ex (sp),hl | ex (sp),hl
                                ld a,(hl)
                                out (Port_Out),a

                                push bc
                                    ld l,c
                                        
                                    ld a,c
                                    add a,Opn_Part
                                    ld c,a
                                    sla l
                                    ld h,0
                                    ld de,Tones
                                    add hl,de
                                    ld a,(hl) | inc hl
                                    ld h,(hl)
                                    ld l,a
                                    call SetTone
                                pop bc

                                call WaitPort
                                ld a,Opn_OnOff
                                out (Port_Register),a
                                ex (sp),hl | ex (sp),hl
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
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody0:
    di
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
    ld a,Psg_Volume_A
    out (Port_Register),a
    xor a
    out (Port_Out),a
    ei
ret


MelodyWait0:
    call Melody0
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 

Melody4:
    di
    ld (Channels+unitSize*4+Channel_Ptr),hl
    ld a,1
    ld (Channels+unitSize*4+Channel_Len),a
    ei
ret


MelodyWait4:
    call Melody4
    do
        ld hl,(Channels+unitSize*4+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

Sound_Fire_: public Sound_Fire_
    push af| push hl | push de
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
        if z
            di
                ld hl,0
                ld (Channels++Channel_Ptr),hl

                ld hl, 150
                ld (shootingTone),hl
                ld a,Psg_Volume_A
                out (Port_Register),a
                ld a,15
                out (Port_Out),a
                ld a,(mixerValue)
                and 0f8h
                or 08h
                ld (mixerValue),a
                ld e,a
                ld a,Psg_Mixer
                out (Port_Register),a
                ld a,e
                out (Port_Out),a
                ld a,Psg_Volume_A
                out (Port_Register),a
                ld a,15
                out (Port_Out),a
            ei
        endif
    pop de | pop hl | pop af
ret

smallExplosion_notes:
    defb 12*2,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push af | push hl
        ld hl,smallExplosion_notes
        call Melody0
    pop hl | pop af
ret

largeExplosion_notes:
    defb 24*2,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push af | push hl
        ld hl,largeExplosion_notes
        call Melody0
    pop hl | pop af
ret

up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push af | push hl
        ld hl,up_notes
        call Melody0
    pop hl | pop af
ret


start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait4
    pop hl | pop af
ret

over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait4
    pop hl | pop af
ret


BGM_B: 
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2,G4, N2P,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2,D5, N2P,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2,C5, N2P,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb 0ffh

BGM_C:
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4
    
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,D4, N8,D4, N8,0, N8,D4, N8,0, N8,D4, N8,0, N8,D4
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,A3
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb 0ffh

BGM_D:
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4
    
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N8,A4, N8,A4

    defb N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4, N4,0, N4,A4
    defb N4,0, N4,A4, N4,0, N4,A4, N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N4,0, N8,A4, N8,A4, N4,0, N4,A4
    ; defb N4,0, N8,A4, N8,A4, N4,0, N4,A4,  N8,0, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4, N8,A4

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
                call WaitPort
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
                ex (sp),hl | ex (sp),hl
                ld a,c
                out (Port_Out),a
                inc c
            dwnz
        ei
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
defw 758 ;E3
defw 716 ;F3
defw 676 ;F#3
defw 638 ;G3
defw 602 ;G#3
defw 568 ;A3
defw 536 ;A#3
defw 506 ;B3
defw 478 ;C4
defw 451 ;C#4
defw 426 ;D4
defw 402 ;D#4
defw 379 ;E4
defw 358 ;F4
defw 338 ;F#4
defw 319 ;G4
defw 301 ;G#4
defw 284 ;A4
defw 268 ;A#4
defw 253 ;B4
defw 239 ;C5
defw 225 ;C#5
defw 213 ;D5
defw 201 ;D#5
defw 190 ;E5
defw 179 ;F5
defw 169 ;F#5
defw 159 ;G5

OpnScales:
defb 27,10 ;E3
defb 27,56 ;F3
defb 27,105 ;F#3
defb 27,157 ;G3
defb 27,212 ;G#3
defb 28,14 ;A3
defb 28,76 ;A#3
defb 28,141 ;B3
defb 34,105 ;C4
defb 34,142 ;C#4
defb 34,181 ;D4
defb 34,222 ;D#4
defb 35,10 ;E4
defb 35,56 ;F4
defb 35,105 ;F#4
defb 35,157 ;G4
defb 35,212 ;G#4
defb 36,14 ;A4
defb 36,76 ;A#4
defb 36,141 ;B4
defb 42,105 ;C5
defb 42,142 ;C#5
defb 42,181 ;D5
defb 42,222 ;D#5
defb 43,10 ;E5
defb 43,56 ;F5
defb 43,105 ;F#5
defb 43,157 ;G5
