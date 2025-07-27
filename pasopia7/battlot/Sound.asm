Port_Dcsg equ 03ah

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

HighNoise equ 0f0h
LowNoise equ 0f1h

MinVolume equ 63
HighNoiseValue equ 0e4h
LowNoiseValue equ 0e5h

tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

    dseg
Channels defs unitSize*count
time: defw 0
noiseVolume: defb 0
shootingTone: defw 0


C2 equ 1
C2S equ 2
D2 equ 3
D2S equ 4
E2 equ 5
F2 equ 6
F2S equ 7
G2 equ 8
G2S equ 9
A2 equ 10
A2S equ 11
B2 equ 12
C3 equ 13
C3S equ 14
D3 equ 15
D3S equ 16
E3 equ 17
F3 equ 18
F3S equ 19
G3 equ 20
G3S equ 21
A3 equ 22
A3S equ 23
B3 equ 24
C4 equ 25
C4S equ 26
D4 equ 27
D4S equ 28
E4 equ 29
F4 equ 30
F4S equ 31
G4 equ 32
G4S equ 33
A4 equ 34
A4S equ 35
B4 equ 36
C5 equ 37
C5S equ 38
D5 equ 39
D5S equ 40
E5 equ 41
F5 equ 42

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N1 equ N2*2


cseg

InitSound_: public InitSound_
    di
        ld ix,Channels
        ld b,count
        ld de,unitSize
        xor a
        do
            ld (ix+Channel_Ptr),a
            ld (ix+Channel_Ptr+1),a
            ld (ix+Channel_Len),1
            add ix,de
        dwnz

        ld hl,0
        ld (time),hl
        ld (shootingTone),hl

        ld a,MinVolume
        ld (noiseVolume),a
        or Dcsg_NoiseVolume or 80h
        out (Port_Dcsg),a
    ei
ret

Tone:
    ld a,l
    and 0fh
    or 80h or Dcsg_ToneA
    out (Port_Dcsg),a
    add hl,hl
    add hl,hl
    add hl,hl
    add hl,hl
    ld a,h
    and 3fh
    out (Port_Dcsg),a
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(shootingTone)
        ld a,l
        or h
        if nz
            push hl
                call Tone
            pop hl
            ld de,15
            add hl,de
            ld a,h
            or a
            jr z,highzero
            ld a,l
            cp 260-256
            if nc
                ld a,Dcsg_VolumeA or 8fh
                out (Port_Dcsg),a
                ld l,0
            endif
            highzero:
            ld (shootingTone),hl
        endif

        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,(count * 100h) or Dcsg_ToneA   ; b = count; c = register
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
                                or 9fh
                                out (Port_Dcsg),a
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
                                ld a,HighNoiseValue 
                                WriteNoise:
                                out (Port_Dcsg),a
                                xor a
                                ld (noiseVolume),a
                                jr EndWriteCycle
                            endif
                            cp LowNoise
                            if z
                                ld a,LowNoiseValue
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
                                or 80h
                                or (hl)
                                out (Port_Dcsg),a
                                inc hl
                                ld a,(hl)
                                out (Port_Dcsg),a
                                ld a,c
                                cp Dcsg_ToneC
                                if z 
                                    ld a,4
                                else
                                    xor a
                                endif
                                ld (ix+Channel_Vol),a
                            else
                                ld (ix+Channel_Vol),MinVolume
                            endif
                            EndWriteCycle:
                        endif
                        ld a,(ix+Channel_Vol)
                        srl a | srl a
                        or c
                        or 90h
                        out (Port_Dcsg),a
                        ld a,(ix+Channel_Vol)
                        cp MinVolume
                        if nz
                            inc a
                            ld (ix+Channel_Vol),a
                        endif
                    endif
                    next:
                    ld a,c
                    add a,20h
                    ld c,a
                    ld de,unitSize
                    add ix,de
                dwnz
                ld a,(noiseVolume)
                srl a | srl a
                or Dcsg_NoiseVolume or 80h
                out (Port_Dcsg),a
                ld a,(noiseVolume)
                cp MinVolume
                if nz
                    inc a
                    ld (noiseVolume),a
                endif
            pop ix | pop bc | pop hl
            ld de,640/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    di
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
    ld hl,0
    ld (shootingTone),hl
    ei
ret

MelodyWait:
    call Melody
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


Sound_Fire_: public Sound_Fire_
    push af| push hl | push de
        di
            ld hl,0
            ld (Channels++Channel_Ptr),hl

            ld hl, 110
            ld (shootingTone),hl
            ld a,Dcsg_VolumeA or 80h
            out (Port_Dcsg),a
        ei
    pop de | pop hl | pop af
ret

smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push af | push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl | pop af
ret

largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push af | push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl | pop af
ret


beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push af | push hl
        ld hl,beep_notes
        call MelodyWait
    pop hl | pop af
ret


start_notes: 
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret


clear_notes: 
    defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret


over_notes: 
    defb N8,A4, N8,E5, N8,D5, N8,C5, N8,D5, N8,C5, N8,B4, N4P,A4
    defb N8,0, N4,G4, N8,G4, N4,A4
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B: 
    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N8,E5, N8,F5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4
    defb N8P,C5, N8P,B4, N8,A4, N8P,B4, N8P,A4, N8,G4

    defb N4,A4, N4,A4, N8,A4, N4,C5, N8,D5
    defb N2,E5, N4,0, N8,E5, N8,F5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4
    defb N8P,C5, N8P,B4, N8,A4, N8P,B4, N8P,A4, N8,G4

    defb N8,A4, N8,A4, N4,A4, N8,0, N8,G4, N8,0, N8,A4
    defb N8,C5, N8,C5, N4,C5, N8,0, N8,B4, N8,0, N8,C5
    defb N8,D5, N8,D5, N4,D5, N8,0, N8,C5, N8,0, N8,D5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4

    defb N8,A4, N8,A4, N4,A4, N8,0, N8,G4, N8,0, N8,A4
    defb N8,C5, N8,C5, N4,C5, N8,0, N8,B4, N8,0, N8,C5
    defb N8,D5, N8,D5, N4,D5, N8,0, N8,C5, N8,0, N8,D5
    defb N8P,E5, N8P,D5, N8,C5, N8P,D5, N8P,C5, N8,B4

    defb 0ffh

BGM_C:
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8, 0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2, N8,0

    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8, 0, N8,C3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,F2, N8,0, N8,F2, N8,0, N8,G2, N8,0, N8,G2, N8,0

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,C3, N8,0, N8,C3, N8,0, N8,B2, N8,0, N8,B2, N8,0

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,C3, N8,0, N8,C3, N8,0, N8,B2, N8,0, N8,B2, N8,0

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
        ld b,3
        ld a, Dcsg_VolumeB or 8fh
        do
            out (Port_Dcsg),a
            add a,20h
        dwnz
        ei
    pop bc | pop hl | pop af
ret


cycles:
defb 10,59 ; C2
defb 4,56 ; C#2
defb 1,53 ; D2
defb 2,50 ; D#2
defb 5,47 ; E2
defb 10,44 ; F2
defb 2,42 ; F#2
defb 12,39 ; G2
defb 9,37 ; G#2
defb 7,35 ; A2
defb 7,33 ; A#2
defb 9,31 ; B2
defb 13,29 ; C3
defb 2,28 ; C#3
defb 8,26 ; D3
defb 1,25 ; D#3
defb 10,23 ; E3
defb 5,22 ; F3
defb 1,21 ; F#3
defb 14,19 ; G3
defb 12,18 ; G#3
defb 11,17 ; A3
defb 11,16 ; A#3
defb 12,15 ; B3
defb 14,14 ; C4
defb 1,14 ; C#4
defb 4,13 ; D4
defb 8,12 ; D#4
defb 13,11 ; E4
defb 2,11 ; F4
defb 8,10 ; F#4
defb 15,9 ; G4
defb 6,9 ; G#4
defb 13,8 ; A4
defb 5,8 ; A#4
defb 14,7 ; B4
defb 7,7 ; C5
defb 0,7 ; C#5
defb 10,6 ; D5
defb 4,6 ; D#5
defb 14,5 ; E5
defb 9,5 ; F5
