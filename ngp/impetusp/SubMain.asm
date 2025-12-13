include "Sound.inc"

Port_Dcsg equ 4001h

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
HighNoiseValue equ 0e4h
LowNoiseValue equ 0e5h

MinVolume equ 63
Tempo equ 200


ChannelCount equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
UnitSize equ Channel_Vol+1


dseg
SoundCmd: public SoundCmd
    defb 0
SoundChannels: public SoundChannels
    defs UnitSize*ChannelCount
Time:
    defw 0
NoiseVolume:
    defb 0

cseg
    di
    ld sp,SoundCmd
    ld b,0 | do | dwnz

    ld hl,Port_Dcsg
    ld (hl),9fh
    ld (hl),0bfh
    ld (hl),0dfh
    dec hl
    ld (hl),9fh
    ld (hl),0bfh
    ld (hl),0dfh

    ld ix,SoundChannels
    ld b,ChannelCount
    ld de,UnitSize
    xor a
    do
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        add ix,de
    dwnz
    ld hl,0 | ld (Time),hl
    ld a,MinVolume | ld (NoiseVolume),a


    ld a,SoundCmd_none | ld (SoundCmd),a
    Loop:
    ld a,(SoundCmd)
    or a
    if nz
        dec a
        add a,a
        ld l,a | ld h,0
        ld de,JumpTable | add hl,de
        ld a,(hl) | inc hl
        ld h,(hl) | ld l,a
        call CallHl
        xor a | ld (SoundCmd),a
    endif
jp Loop

CallHl:
jp (hl)

defs 12

z80_66h: public z80_66h
    push hl | push de
        ld hl,(Time)
        ld de,-Tempo
        add hl,de
        if nc
            push af | push hl | push bc | push ix
                ld ix,SoundChannels
                ld bc,Dcsg_ToneA or (ChannelCount shl 8) ; b = count; c = register
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
                                ld (Port_Dcsg),a
                                ld (Port_Dcsg-1),a
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
                                push af
                                    ld a,80h | ld (Port_Dcsg),a
                                    ld a,00h | ld (Port_Dcsg),a
                                    ; ld (ix+Channel_Vol),0
                                    ; ld a,9fh
                                    ; ld (Port_Dcsg),a
                                    ; ld (Port_Dcsg-1),a
                                pop af
                                ; ld (Port_Dcsg),a
                                ld (Port_Dcsg-1),a
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
                                ld hl,Cycles
                                add hl,de
                                ld a,c
                                or 80h
                                or (hl)
                                ld (Port_Dcsg),a
                                inc hl
                                ld a,(hl)
                                ld (Port_Dcsg),a
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
                        ld (Port_Dcsg),a
                        ld (Port_Dcsg-1),a
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
                ld (Port_Dcsg),a
                ld (Port_Dcsg-1),a
                ld a,(noiseVolume)
                cp MinVolume
                if nz
                    inc a
                    ld (noiseVolume),a
                endif
            pop ix | pop bc | pop hl | pop af
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
retn

Melody:
    ld (SoundChannels+Channel_Ptr),hl
    ld a,1
    ld (SoundChannels+Channel_Len),a
ret

MelodyWait:
    call Melody
    do
        ld hl,(SoundChannels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 

JumpTable:
    defw Sound_Fire, Sound_SmallBang, Sound_LargeBang, Sound_Up
    defw Sound_Start, Sound_GameOver
    defw StartBGM, StopBGM


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire:
    ld hl,(SoundChannels+Channel_Ptr)
    ld a,l
    or h
    if z
        ld hl,fire_notes
        call Melody
    endif
ret


smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBang:
    ld hl,smallExplosion_notes
    call Melody
ret


largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBang:
    ld hl,largeExplosion_notes
    call Melody
ret


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up:
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
Sound_Start:
    ld hl,start_notes
    call MelodyWait
ret


over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver: 
    ld hl,over_notes
    call MelodyWait
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
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,E3, N8,0, N8,E3, N8,0, N8,E3, N8,0, N8,E3

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F3, N8,F3, N8,0, N4P,E3, N4,0

    defb 0ffh


StartBGM:
    ld a,1
    ld hl,BGM_B
    ld (SoundChannels+unitSize*1+Channel_Start),hl
    ld (SoundChannels+unitSize*1+Channel_Ptr),hl
    ld (SoundChannels+unitSize*1+Channel_Len),a
    ld hl,BGM_C
    ld (SoundChannels+unitSize*2+Channel_Start),hl
    ld (SoundChannels+unitSize*2+Channel_Ptr),hl
    ld (SoundChannels+unitSize*2+Channel_Len),a
ret


StopBGM:
    ld hl,0
    ld (SoundChannels+unitSize*1+Channel_Ptr),hl
    ld (SoundChannels+unitSize*2+Channel_Ptr),hl
    
    ld b,3
    ld a, Dcsg_VolumeB or 8fh
    do
        ld (Port_Dcsg),a
        ld (Port_Dcsg-1),a
        add a,20h
    dwnz
ret


N8 equ 6
N8L equ 8
N8R equ 4
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

G2 equ 1
G2S equ 2
A2 equ 3
A2S equ 4
B2 equ 5
C3 equ 6
C3S equ 7
D3 equ 8
D3S equ 9
E3 equ 10
F3 equ 11
F3S equ 12
G3 equ 13
G3S equ 14
A3 equ 15
A3S equ 16
B3 equ 17
C4 equ 18
C4S equ 19
D4 equ 20
D4S equ 21
E4 equ 22
F4 equ 23
F4S equ 24
G4 equ 25
G4S equ 26
A4 equ 27
A4S equ 28
B4 equ 29
C5 equ 30
C5S equ 31
D5 equ 32
D5S equ 33
E5 equ 34
F5 equ 35
F5S equ 36
G5 equ 37

Cycles:
defb 3,61 ; G2
defb 12,57 ; G2S
defb 8,54 ; A2
defb 7,51 ; A2S
defb 9,48 ; B2
defb 13,45 ; C3
defb 4,43 ; C3S
defb 13,40 ; D3
defb 9,38 ; D3S
defb 6,36 ; E3
defb 5,34 ; F3
defb 6,32 ; F3S
defb 9,30 ; G3
defb 14,28 ; G3S
defb 4,27 ; A3
defb 11,25 ; A3S
defb 4,24 ; B3
defb 14,22 ; C4
defb 10,21 ; C4S
defb 6,20 ; D4
defb 4,19 ; D4S
defb 3,18 ; E4
defb 2,17 ; F4
defb 3,16 ; F4S
defb 4,15 ; G4
defb 7,14 ; G4S
defb 10,13 ; A4
defb 13,12 ; A4S
defb 2,12 ; B4
defb 7,11 ; C5
defb 13,10 ; C5S
defb 3,10 ; D5
defb 10,9 ; D5S
defb 1,9 ; E5
defb 9,8 ; F5
defb 1,8 ; F5S
defb 10,7 ; G5
