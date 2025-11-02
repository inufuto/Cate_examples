Port_Dcsg equ 0f2h

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

Tempo equ 200

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


cseg
InitSound: public InitSound
    di
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
        ld (shootingTone),hl

        ld a,MinVolume
        ld (noiseVolume),a
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
            cp 300-256
            if nc
                ld a,Dcsg_VolumeA or 8fh
                out (Port_Dcsg),a
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
            ld de,600/2
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
        ld hl,(Channels++Channel_Ptr)
        ld a,l
        or h
        if z
            di
                ; ld hl,0
                ; ld (Channels++Channel_Ptr),hl
                ld hl, 150
                ld (shootingTone),hl
                ld a,Dcsg_VolumeA or 80h
                out (Port_Dcsg),a
            ei
        endif
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

up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push af | push hl
        ld hl,up_notes
        call Melody
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
        call MelodyWait
    pop hl | pop af
ret


; clear_notes: 
;     defb N8,A4, N8,0, N8,A4, N8,G4, N8,A4, N4,C5, N8,D5, N8,0, N8,C5, N8,0, N4P,A4, N2,0
;     defb 0
; Sound_Clear_: 
;     public Sound_Clear_
;     push af | push hl
;         ld hl,clear_notes
;         call MelodyWait
;     pop hl | pop af
; ret


over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B: 
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,B4, N4P,G4, N2P,G4, N2,0
    defb N4P,A4, N4P,B4, N2,C5, N4,C5, N4,B4, N4,C5
    defb N4P,G5, N4P,D5, N2P,D5, N2,0
    defb N4P,F5, N4P,E5, N2,F5, N4,F5, N4,E5, N4,F5
    defb N4P,E5, N4P,C5, N2P,C5, N2,0
    
    defb N8,A4, N8,A4, N8,B4, N4,C5, N4,C5, N8,C5
    defb N8,B4, N8,B4, N8,C5, N4,D5, N4,D5, N8,D5
    defb N8,C5, N8,C5, N8,D5, N4,E5, N4,E5, N8,E5
    defb N8,F5, N4,F5, N4P,E5, N4,0

    defb 0ffh
BGM_C:
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

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


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

A2 equ 1
A2S equ 2
B2 equ 3
C3 equ 4
C3S equ 5
D3 equ 6
D3S equ 7
E3 equ 8
F3 equ 9
F3S equ 10
G3 equ 11
G3S equ 12
A3 equ 13
A3S equ 14
B3 equ 15
C4 equ 16
C4S equ 17
D4 equ 18
D4S equ 19
E4 equ 20
F4 equ 21
F4S equ 22
G4 equ 23
G4S equ 24
A4 equ 25
A4S equ 26
B4 equ 27
C5 equ 28
C5S equ 29
D5 equ 30
D5S equ 31
E5 equ 32
F5 equ 33
F5S equ 34
G5 equ 35

cycles:
defb 15,62 ; A2
defb 7,59 ; A2S
defb 1,56 ; B2
defb 15,52 ; C3
defb 15,49 ; C3S
defb 2,47 ; D3
defb 8,44 ; D3S
defb 0,42 ; E3
defb 10,39 ; F3
defb 7,37 ; F3S
defb 5,35 ; G3
defb 5,33 ; G3S
defb 7,31 ; A3
defb 11,29 ; A3S
defb 0,28 ; B3
defb 7,26 ; C4
defb 15,24 ; C4S
defb 9,23 ; D4
defb 4,22 ; D4S
defb 0,21 ; E4
defb 13,19 ; F4
defb 11,18 ; F4S
defb 10,17 ; G4
defb 10,16 ; G4S
defb 11,15 ; A4
defb 13,14 ; A4S
defb 0,14 ; B4
defb 3,13 ; C5
defb 7,12 ; C5S
defb 12,11 ; D5
defb 2,11 ; D5S
defb 8,10 ; E5
defb 14,9 ; F5
defb 5,9 ; F5S
defb 13,8 ; G5
