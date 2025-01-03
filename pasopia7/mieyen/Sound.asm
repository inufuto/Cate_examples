Port_Dcsg0 equ 03ah
Port_Dcsg1 equ Port_Dcsg0+1

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

MinVolume equ 63

tempo equ 180

count equ 6
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

    dseg
Channels defs unitSize*count
time: defw 0


cseg
InitSound: public InitSound
    di
        ld hl,Channels
        ld b,unitSize*count
        xor a
        do
            ld (hl),a | inc hl
        dwnz

        ld hl,0
        ld (time),hl
    ei
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                                        _deb: public _deb
                ld ix,Channels
                ld bc,(count * 100h) or Port_Dcsg0   ; b = count; c = port
                ld de,Dcsg_ToneA ; register
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
                                ld a,e
                                or 9fh
                                out (c),a
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
                                push de
                                    ld e,a
                                    ld d,0
                                    ld hl,cycles
                                    add hl,de
                                pop de
                                ld a,e
                                or 80h
                                or (hl)
                                out (c),a
                                inc hl
                                ld a,(hl)
                                out (c),a
                                ld a,e
                                cp Dcsg_ToneC
                                ld (ix+Channel_Vol),d
                            else
                                ld (ix+Channel_Vol),MinVolume
                            endif
                            EndWriteCycle:
                        endif
                        ld a,(ix+Channel_Vol)
                        srl a | srl a
                        or e
                        or 90h
                        out (c),a
                        ld a,(ix+Channel_Vol)
                        cp MinVolume
                        if nz
                            inc a
                            ld (ix+Channel_Vol),a
                        endif
                    endif
                    next:
                    ld a,e
                    add a,20h
                    cp 60h
                    if nc
                        sub 60h
                        inc c
                        ld d,8
                    endif
                    ld e,a
                    push de
                        ld de,unitSize
                        add ix,de
                    pop de
                dwnz
            pop ix | pop bc | pop hl
            ld de,640/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    push af
        di
            ld (Channels+Channel_Ptr),hl
            ld a,1
            ld (Channels+Channel_Len),a
        ei
    pop af
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


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    push hl
        ld hl,stole_notes
        call Melody
    pop hl
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push hl
        ld hl,fire_notes
        call Melody
    pop hl
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push af | push hl
        ld hl,bonus_notes
        call MelodyWait
    pop hl | pop af
ret


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
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
BGM_D1:
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;3  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;4  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,F4 , N8,0, N8,F4  ;5  Dm
    defb N4,G4, N8,0, N8,G4, N8,0, N8,G4 , N8,0, N8,G4  ;6  G

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;7  C
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;8  Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;9  F G
    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;10 C

    defb N4,E4, N8,0, N8,E4, N8,0, N8,E4 , N8,0, N8,E4  ;11 C Am
    defb N4,F4, N8,0, N8,F4, N8,0, N8,G4 , N8,0, N8,G4  ;12 Dm G
    defb N8,0, N8,F4, N8,0, N8,F4, N8,0, N8,G4, N8,0, N8,G4 ;13 F G
    defb N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0, N8,E4, N8,0 ;14 C

    defb 0ffh

BGM_D2:
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;3  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;4  Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;5  Dm
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;6  G

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;7  C
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;8  Am
    defb N4,C4, N8,0, N8,C4, N8,0, N8,D4 , N8,0, N8,D4  ;9  F G
    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;10 C

    defb N4,C4, N8,0, N8,C4, N8,0, N8,C4 , N8,0, N8,C4  ;11 C Am
    defb N4,D4, N8,0, N8,D4, N8,0, N8,D4 , N8,0, N8,D4  ;12 Dm G
    defb N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,D4, N8,0, N8,D4 ;13 F G
    defb N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0, N8,C4, N8,0 ;14 C

    defb 0ffh

BGM_D3:
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;3  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;4  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;5  Dm
    defb N4,B3, N8,0, N8,B3, N8,0, N8,B3 , N8,0, N8,B3  ;6  G

    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;7  C
    defb N4,A3, N8,0, N8,A3, N8,0, N8,A3 , N8,0, N8,A3  ;8  Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;9  F G
    defb N4,G3, N8,0, N8,G3, N8,0, N8,G3 , N8,0, N8,G3  ;10 C

    defb N4,G3, N8,0, N8,G3, N8,0, N8,A3 , N8,0, N8,A3  ;11 C Am
    defb N4,A3, N8,0, N8,A3, N8,0, N8,B3 , N8,0, N8,B3  ;12 Dm G
    defb N8,0, N8,A3, N8,0, N8,A3, N8,0, N8,B3, N8,0, N8,B3 ;13 F G
    defb N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0, N8,G3, N8,0 ;14 C

    defb 0ffh
BGM:
    defw BGM_B,BGM_C,BGM_D1,BGM_D2,BGM_D3


StartBGM_: public StartBGM_
    push af | push hl | push de | push bc | push ix
        di
            ld ix,Channels+unitSize*1
            ld hl,BGM
            ld de,unitSize
            ld b,count-1
            do
                ld a,(hl) | inc hl
                ld (ix+Channel_Start),a
                ld (ix+Channel_Ptr),a
                ld a,(hl) | inc hl
                ld (ix+Channel_Start+1),a
                ld (ix+Channel_Ptr+1),a
                
                ld (ix+Channel_Len),1

                add ix,de
            dwnz
        ei
    pop ix | pop bc | pop de | pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push de | push bc | push ix
        di
            ld hl,Channels
            ld b,unitSize*count
            xor a
            do
                ld (hl),a | inc hl
            dwnz

            ld b,3
            ld a, Dcsg_VolumeA or 8fh
            do
                out (Port_Dcsg0),a
                out (Port_Dcsg1),a
                add a,20h
            dwnz
        ei
    pop ix | pop bc | pop de | pop af
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

cycles:
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
defb 4,5 ; F#5
defb 15,4 ; G5
