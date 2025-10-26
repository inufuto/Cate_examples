Port_DcsgL equ 0f2h
Port_DcsgR equ 0f3h
Port_DcsgC equ 0e9h

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

ChannelCount equ 6
Offset_Ptr equ 0
Offset_Start equ Offset_Ptr+2
Offset_Len equ Offset_Start+2
Offset_Vol equ Offset_Len+1
UnitSize equ Offset_Vol+1

dseg
Channels:
    defs UnitSize*ChannelCount
time:
    defw 0
noiseVolume:
    defb 0

EffectChannel equ Channels+UnitSize*0
MelodyChannel equ Channels+UnitSize*3
BassChannel equ Channels+UnitSize*1


cseg

InitSound: public InitSound
    di
        ld ix,Channels
        ld de,UnitSize
        ld b,ChannelCount
        xor a
        do
            ld (ix+Offset_Ptr),a
            ld (ix+Offset_Ptr+1),a
            add ix,de
        dwnz
        ld hl,0
        ld (time),hl

        ld a,MinVolume
        ld (noiseVolume),a
    ei
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,Port_DcsgL or (Dcsg_ToneA shl 8)  ; b=register,c=port
                do
                    ld l,(ix+Offset_Ptr)
                    ld h,(ix+Offset_Ptr+1)
                    ld a,l | or h
                    if nz
                        dec (ix+Offset_Len)
                        if z
                            continue:
                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Offset_Ptr),a
                                ld (ix+Offset_Ptr+1),a
                                ld a,b
                                or 9fh
                                out (c),a
                                jr next
                            endif
                            inc a
                            if z 
                                ; repeat
                                ld l,(ix+Offset_Start)
                                ld h,(ix+Offset_Start+1)
                                jr continue
                            endif
                            dec a
                            ld (ix+Offset_Len),a
                            inc hl
                            ld a,(hl)
                            inc hl
                            ld (ix+Offset_Ptr),l
                            ld (ix+Offset_Ptr+1),h
                            cp HighNoise
                            if z
                                ld a,HighNoiseValue 
                                WriteNoise:
                                out (Port_DcsgC),a
                                xor a
                                ld (noiseVolume),a
                                ld (ix+Offset_Vol),MinVolume
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
                                ld a,b
                                or 80h
                                or (hl)
                                out (c),a
                                inc hl
                                ld a,(hl)
                                out (c),a
                                ld a,b
                                cp Dcsg_ToneC
                                if z 
                                    ld a,4
                                else
                                    xor a
                                endif
                                ld (ix+Offset_Vol),a
                            else
                                ld (ix+Offset_Vol),MinVolume
                            endif
                            EndWriteCycle:
                        endif
                        ld a,(ix+Offset_Vol)
                        srl a | srl a
                        or b
                        or 90h
                        out (c),a
                        ld a,(ix+Offset_Vol)
                        cp MinVolume
                        if nz
                            inc a
                            ld (ix+Offset_Vol),a
                        endif
                    endif
                    next:
                    ld de,UnitSize
                    add ix,de

                    ld a,b
                    add a,20h
                    cp 60h
                    if nc
                        ld a,Dcsg_ToneA
                        inc c
                    endif
                    ld b,a
                    ld a,c
                    cp Port_DcsgR+1
                while c | wend
                ld a,(noiseVolume)
                srl a | srl a
                or Dcsg_NoiseVolume or 80h
                out (Port_DcsgC),a
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
    push af
        di
            ld (EffectChannel+Offset_Ptr),hl
            ld a,1
            ld (EffectChannel+Offset_Len),a
        ei
    pop af
ret

MelodyWait:
    call Melody
    push af
        do
            ld hl,(EffectChannel+Offset_Ptr)
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
        ld hl,(EffectChannel+Offset_Ptr)
        ld a,l | or a
        if z
            ld hl,fire_notes
            call Melody
        endif
    pop hl | pop af
ret


; void Sound_SmallBang();
smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push af | push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl | pop af
ret


; void Sound_LargeBang();
largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push af | push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl | pop af
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push af | push hl
        ld hl,up_notes
        call Melody
    pop hl | pop af
ret


; void Sound_Start();
start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


; void Sound_GameOver();
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
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
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,C3S ;3
    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3 ;4
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,G3S ;5
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2 ;6

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,E3 ;7
    defb N4,F3, N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,F3S ;8
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3 ;9
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3 ;10

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,A2S ;11
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3 ;12
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3 ;13
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3 ;14
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,C3S ;15
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,G3S ;16
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2 ;17
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0 ;18

    defb 0ffh

BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;4  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;5  Em
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;6  Am
    
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;8  F
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;9  G
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;10  Em

    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;11  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;12  G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;13  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;14  C

    defb N8,E4, N8,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;15  Am
    defb N8,F4, N8,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;16  Dm
    defb N8,E4, N8,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;17  Am
    defb N8,F4, N8,F4, N8,0, N4P,G4, N4,0  ;18  F Em

    defb 0ffh

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;4  Dm
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;5  Em
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;6  Am
    
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  F
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;9  G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10  Em

    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;11  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12  G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;13  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;14  C

    defb N8,C4, N8,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;15  Am
    defb N8,D4, N8,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;16  Dm
    defb N8,C4, N8,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;17  Am
    defb N8,C4, N8,C4, N8,0, N4P,E4, N4,0  ;18  F Em

    defb 0ffh

BGM_D3:
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;3  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;5  Em
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;6  Am

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;7  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  F
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;9  G
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;10  Em

    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;11  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;12  G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;13  C
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;14  C

    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;15  Am
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;16  Dm
    defb N8,A3, N8,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;17  Am
    defb N8,A3, N8,A3, N8,0, N4P,B3, N4,0  ;18  F Em

    defb 0ffh

BGM:
    defw 0,BGM_C,BGM_D2
    defw BGM_B,BGM_D1,BGM_D3


StartBGM_: public StartBGM_
    push af | push hl
        di
            ld ix,Channels
            ld hl,BGM
            ld bc,1 or (ChannelCount shl 8)
            do
                ld e,(hl) | inc hl
                ld d,(hl) | inc hl
                ld a,e | or d
                if nz
                    ld (ix+Offset_Start),e
                    ld (ix+Offset_Start+1),d
                    ld (ix+Offset_Ptr),e
                    ld (ix+Offset_Ptr+1),d
                    ld (ix+Offset_Len),c
                endif
                ld de,UnitSize | add ix,de
            dwnz
        ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
            ld ix,Channels
            ld de,UnitSize            
            ld bc,ChannelCount shl 8
            do
                ld (ix+Offset_Start),c
                ld (ix+Offset_Start+1),c
                ld (ix+Offset_Ptr),c
                ld (ix+Offset_Ptr+1),c
                add ix,de
            dwnz

            ld c,Port_DcsgL
            do
                ld b,ChannelCount/2
                ld a, Dcsg_VolumeA or 8fh
                do
                    out (c),a
                    add a,20h
                dwnz
                inc c
                ld a,c
                cp Port_DcsgR+1
            while nz | wend
        ei
    pop bc | pop hl | pop af
ret

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

N8 equ 6
N8L equ 8
N8R equ 4
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2
N16 equ N8/2

cycles:
    defb 6,63 ; A2
    defb 13,59 ; A2S
    defb 7,56 ; B2
    defb 4,53 ; C3
    defb 4,50 ; C3S
    defb 7,47 ; D3
    defb 13,44 ; D3S
    defb 4,42 ; E3
    defb 14,39 ; F3
    defb 11,37 ; F3S
    defb 9,35 ; G3
    defb 9,33 ; G3S
    defb 11,31 ; A3
    defb 14,29 ; A3S
    defb 3,28 ; B3
    defb 10,26 ; C4
    defb 2,25 ; C4S
    defb 11,23 ; D4
    defb 6,22 ; D4S
    defb 2,21 ; E4
    defb 15,19 ; F4
    defb 13,18 ; F4S
    defb 12,17 ; G4
    defb 12,16 ; G4S
    defb 13,15 ; A4
    defb 15,14 ; A4S
    defb 1,14 ; B4
    defb 5,13 ; C5
    defb 9,12 ; C5S
    defb 13,11 ; D5
    defb 3,11 ; D5S
    defb 9,10 ; E5
    defb 15,9 ; F5
    defb 6,9 ; F5S
    defb 14,8 ; G5
