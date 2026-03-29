include "kh1000.inc"

ext WaitTimer_

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10

HighNoise equ 0f0h
LowNoise equ 0f1h

MaxVol equ 63
LowNoiseValue equ 31
HighNoiseValue equ LowNoiseValue*2/3

Tempo equ 150

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time:
    defw 0
mixerValue:
    defb 0

cseg

InitSound: public InitSound
    ld ix,Channels
    ld b,count
    ld de,unitSize
    xor a
    do
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        add ix,de
    dwnz
    ld hl,0
    ld (time),hl

    ld a,PsgR7Bits
    ld (mixerValue),a
ret


SoundHandler: public SoundHandler
    push hl | push de
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
                ld bc,count * 100h ; b = count; c = register
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
                                add a,Psg_VolumeA | out (PsgAddressPort),a
                                xor a | out (PsgWritePort),a
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
                                ld a,Psg_Noise | out (PsgAddressPort),a
                                ld a,e | out (PsgWritePort),a
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
                                ld a,Psg_Mixer | out (PsgAddressPort),a
                                ld a,e | out (PsgWritePort),a
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
                                add a,a | out (PsgAddressPort),a
                                push af
                                    ld a,(hl) | out (PsgWritePort),a
                                    inc hl
                                pop af
                                inc a | out (PsgAddressPort),a
                                ld a,(hl) | out (PsgWritePort),a
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
                                ld a,Psg_Mixer | out (PsgAddressPort),a
                                ld a,e | out (PsgWritePort),a
                                jr EndWriteCycle
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_VolumeA | out (PsgAddressPort),a
                        ld e,(ix+Channel_Vol)
                        ld a,e
                        srl a | srl a | out (PsgWritePort),a
                        ld a,e
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
            pop ix | pop bc | pop hl
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    push af | push de
        di
            ld (Channels+Channel_Ptr),hl
            ld a,1
            ld (Channels+Channel_Len),a
        ei
    pop de | pop af
ret

MelodyWait:
    call Melody
    push af
        do
            ld hl,(Channels+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
ret 


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push af | push hl
                        _deb: public _deb
        ld hl,(Channels+Channel_Ptr)
        ld a,l | or h
        if z
            ld hl,fire_notes
            call Melody
        endif
    pop hl | pop af
ret


; void Sound_SmallBang();
smallExplosion_notes:
    defb N2,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl
ret


; void Sound_LargeBang();
largeExplosion_notes:
    defb N1,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push hl
        ld hl,up_notes
        call Melody
    pop hl
ret


; void Sound_Start();
start_notes: 
    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,D5, N8,C5
    defb N8P,D5, N16,D5, N8,D5, N8,E5, N4,D5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


; void Sound_GameOver();
over_notes: 
    defb N8,F5, N8,F5, N8,E5, N8,E5, N8,D5, N8,D5, N8,C5, N8,C5
    defb N8,B4, N8,G4, N8,A4, N8,B4, N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,D5, N8,C5
    defb N8P,D5, N16,D5, N8,D5, N8,E5, N4,D5, N4,0
    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,D5, N8,C5
    defb N2,D5, N2,0

    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,D5, N8,C5
    defb N8P,D5, N16,D5, N8,D5, N8,E5, N4,D5, N4,0
    defb N4,G4, N8,G4, N8,C5, N8,E5, N4,F5, N8,E5
    defb N2,D5, N4,0, N8,D5, N8,E5

    defb N8P,F5, N16,F5, N8,F5, N8,E5, N4,F5, N4,0
    defb N8P,E5, N16,E5, N8,E5, N8,D5, N4,E5, N4,0
    defb N8P,D5, N16,D5, N8,D5, N8,C5, N4,D5, N8,C5, N8,D5
    defb N2,E5, N2,0

    defb N8P,F5, N16,F5, N8,F5, N8,E5, N4,F5, N4,0
    defb N8P,E5, N16,E5, N8,E5, N8,D5, N4,E5, N4,0
    defb N8P,D5, N16,D5, N8,D5, N8,E5, N8,F5, N4,E5, N8,D5
    defb N2,C5, N2,0

    defb 0ffh

BGM_C:
    ; 19
    defb N8,C3, N8,C3, N8,G3, N8,C3,  N8,A2, N8,A2, N8,C3, N8,E3
    defb N8,D3, N8,D3, N8,A3, N8,D3,  N8,G2, N8,G2, N8,B2, N8,D3
    defb N8,C3, N8,C3, N8,E3, N8,G3,  N8,A2, N8,A2, N8,E3, N8,A2
    defb N8,D3, N8,D3, N8,A3, N8,A3,  N8,G3, N8,G3, N8,D4, N8,D3
    ; 23
    defb N8,C3, N8,C3, N8,G3, N8,C3,  N8,A2, N8,A2, N8,E3, N8,C3
    defb N8,D3, N8,D3, N8,F3, N8,A3,  N8,G3, N8,G3, N8,B2, N8,D3
    defb N8,C3, N8,C3, N8,E3, N8,G3,  N8,F2, N8,F2, N8,C3, N8,F2
    defb N8,E2, N8,E2, N8,G2, N8,B2,  N8,A2, N8,A2, N8,E3, N8,A2
    ; 27
    defb N8,D3, N8,D3, N8,F3, N8,A3,  N8,G3, N8,G3, N8,B2, N8,D3
    defb N8,C3, N8,C3, N8,E3, N8,E3, N8,G3, N8,G3, N8,C3, N8,C3
    defb N8,D3, N8,D3, N8,F3, N8,F3, N8,A3, N8,A3, N8,D3, N8,D3
    defb N8,A2, N8,A2, N8,C3, N8,C3, N8,E3, N8,E3, N8,C3, N8,E3
    ; 31    
    defb N8,D3, N8,D3, N8,A3, N8,D3,  N8,G3, N8,G3, N8,D3, N8,B2
    defb N8,C3, N8,C3, N8,E3, N8,E3, N8,G3, N8,G3, N8,C3, N8,C3
    defb N8,D3, N8,D3, N8,F3, N8,A3,  N8,G3, N8,G3, N8,B2, N8,D3
    defb N8,C3, N8,C3, N8,E3, N8,E3, N8,G3, N8,G3, N8,A3, N8,G3

    defb 0ffh

StartBGM_: public StartBGM_
    push af | push hl
        di
            ld a,1
            ld hl,BGM_B
            ld (Channels+unitSize*1+Channel_Start),hl
            ld (Channels+unitSize*1+Channel_Ptr),hl
            ld (Channels+unitSize*1+Channel_Len),a
            ld hl,BGM_C
            ld (Channels+unitSize*2+Channel_Start),hl
            ld (Channels+unitSize*2+Channel_Ptr),hl
            ld (Channels+unitSize*2+Channel_Len),a
        ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld bc,2*256 or Psg_VolumeB
        do
            ld a,c | out (PsgAddressPort),a
            xor a | out (PsgWritePort),a
            inc c
        dwnz
        ei
    pop bc | pop hl | pop af
ret


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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

cycles:
defw 1357 ; E2
defw 1281 ; F2
defw 1209 ; F#2
defw 1141 ; G2
defw 1077 ; G#2
defw 1016 ; A2
defw 959 ; A#2
defw 905 ; B2
defw 855 ; C3
defw 807 ; C#3
defw 761 ; D3
defw 719 ; D#3
defw 678 ; E3
defw 640 ; F3
defw 604 ; F#3
defw 570 ; G3
defw 538 ; G#3
defw 508 ; A3
defw 479 ; A#3
defw 452 ; B3
defw 427 ; C4
defw 403 ; C#4
defw 380 ; D4
defw 359 ; D#4
defw 339 ; E4
defw 320 ; F
defw 302 ; F#4
defw 285 ; G4
defw 269 ; G#4
defw 254 ; A4
defw 239 ; A#4
defw 226 ; B4
defw 213 ; C5
defw 201 ; C#5
defw 190 ; D5
defw 179 ; D#5
defw 169 ; E5
defw 160 ; F5
defw 151 ; F#5
defw 142 ; G5
