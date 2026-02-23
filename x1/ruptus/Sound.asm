Port_Psg_Register equ 1c00h
Port_Psg_Out equ 1b00h
Port_Psg_In equ 1b00h

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10
;Psg_EnvTime equ 11
;Psg_EnvType equ 13

HighNoise equ 0f0h
LowNoise equ 0f1h

HighNoiseValue equ 11
LowNoiseValue equ 27

tempo equ 180


dseg

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

;Wait defb 0
Channels defs unitSize*count
time: defw 0
mixerValue: defb 0
shootingTone: defw 0
PrevSync: defb 0


; void InitSound();
cseg
InitSound_: public InitSound_
    push af | push bc | push de | push ix
        ld bc,Port_Psg_Register
        ld a,Psg_Mixer
        out (c),a
        dec b
        ld a,38h
        out (c),a

        ld ix,Channels
        ld b,count
        ld de,unitSize
        xor a
        ld (PrevSync),a
        do
            ld (ix+Channel_Ptr),a
            ld (ix+Channel_Ptr+1),a
            add ix,de
        dwnz
        ld hl,0
        ld (time),hl
        ld (shootingTone),hl

        ld a,0b8h
        ld (mixerValue),a
    pop ix | pop de | pop bc | pop af    
ret

; void CallSound();
CallSound_: public CallSound_
    push bc
        ld bc,1a01h
        in a,(c)
        and 80h
        if nz
            ld a,(PrevSync)
            or a
            call z,SoundHandler
            ld a,80h
        endif
        ld (PrevSync),a
    pop bc
ret

SoundHandler:
    push af | push hl | push de | push bc | push ix 
        ld hl,(shootingTone)
        ld a,l
        or h
        if nz
            ld a,Psg_ToneA
            ld bc,Port_Psg_Register
            out (c),a
            ld a,l
            dec b
            out (c),a
            ld a,Psg_ToneA+1
            inc b
            out (c),a
            ld a,h
            dec b
            out (c),a
            ld de,15
            add hl,de
            ld a,h
            or a
            jr z,highzero
            ld a,l
            cp 300-256
            if nc
                ld a,Psg_VolumeA
                ld bc,Port_Psg_Register
                out (c),a
                xor a
                dec b
                out (c),a
                ld l,0
            endif
            highzero:
            ld (shootingTone),hl
        endif

        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl
                exx
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
                                push bc
                                    ld bc,Port_Psg_Register
                                    add a,Psg_VolumeA
                                    out (c),a
                                    dec b
                                    xor a
                                    out (c),a
                                pop bc
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
                                push bc
                                    ld bc,Port_Psg_Register
                                    ld a,Psg_Noise
                                    out (c),a
                                    ld a,e
                                    dec b
                                    out (c),a
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
                                    inc b
                                    out (c),a
                                    ld a,e
                                    dec b
                                    out (c),a
                                pop bc
                                ld (ix+Channel_Vol),15
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
                                push bc
                                    ld bc,Port_Psg_Register
                                    out (c),a
                                    dec b
                                    ld a,(hl)
                                    out (c),a
                                    inc hl
                                    inc b
                                    ld a,e
                                    inc a
                                    out (c),a
                                    dec b
                                    ld a,(hl)
                                    out (c),a
                                    ld (ix+Channel_Vol),15
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
                                    inc b
                                    out (c),a
                                    ld a,e
                                    dec b
                                    out (c),a
                                pop bc
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_VolumeA
                        push bc
                            ld bc,Port_Psg_Register
                            out (c),a
                            dec b
                            ld a,(ix+Channel_Vol)
                            out (c),a
                        pop bc
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
                exx
            pop hl
            ld de,600
            add hl,de
        endif
        ld (time),hl
    pop ix | pop bc | pop de | pop hl | pop af
ret

Melody:
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
    ld hl,0
    ld (shootingTone),hl
    ld a,Psg_VolumeA
    push bc
        ld bc,Port_Psg_Register
        out (c),a
        xor a
        dec b
        out (c),a
    pop bc
ret

MelodyWait:
    call Melody
    do
        call CallSound_
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 

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


Sound_Fire_: public Sound_Fire_
    push af| push hl | push de | push bc
        di
            ld hl,0
            ld (Channels++Channel_Ptr),hl

            ld hl, 150
            ld (shootingTone),hl
            ld a,Psg_VolumeA
            ld bc,Port_Psg_Register
            out (c),a
            ld a,15
            dec b
            out (c),a
            ld a,(mixerValue)
            and 0f8h
            or 08h
            ld (mixerValue),a
            ld e,a
            ld a,Psg_Mixer
            inc b
            out (c),a
            ld a,e
            dec b
            out (c),a
        ei
    pop bc | pop de | pop hl | pop af
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
    defb 3,A4, 3,G4, 3,A4, 6,C5, 3,E5, 12,D5,  3,0, 6,C5, 3,C5, 6,D5
    defb 0
Sound_Start_:
    public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: 
    defb 3,E4, 3,G4, 3,C5, 3,A4, 3,0, 3,A4, 3,0, 3,G4,  3,0, 3,G4, 3,0, 3,G4, 3,0, 3,G4, 6,A4
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: 
    defb 3,E4, 3,E4, 3,G4, 6,E4, 3,C5, 3,B4, 3,A4,  3,G4, 3,A4, 3,0, 6,A4, 3,G4, 6,A4
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B: 
    defb 3,A4, 3,A4, 3,C5, 3,A4, 3,C5, 6,A4, 3,0,  3,G4, 6,G4, 6,G4, 3,G4, 6,A4
    defb 3,A4, 3,A4, 3,C5, 3,A4, 3,C5, 6,D5, 3,0,  3,E5, 6,E5, 6,E5, 3,D5, 6,E5
    defb 3,A4, 3,A4, 3,C5, 3,A4, 3,C5, 6,A4, 3,0,  3,G4, 6,G4, 6,G4, 3,G4, 6,A4
    defb 3,A4, 3,A4, 3,C5, 3,A4, 3,C5, 6,D5, 3,0,  3,E5, 6,E5, 6,E5, 3,D5, 6,E5
    defb 3,D5, 3,D5, 3,D5, 6,D5, 3,C5, 6,D5,  3,D5, 3,D5, 3,D5, 6,D5, 3,C5, 6,D5
    defb 3,A4, 3,A4, 3,A4, 6,A4, 3,G4, 6,A4,  3,A4, 3,A4, 3,A4, 6,A4, 3,G4, 6,A4
    defb 3,D5, 3,D5, 3,D5, 6,D5, 3,C5, 6,D5,  3,D5, 3,D5, 3,D5, 6,D5, 3,C5, 6,D5
    defb 3,E5, 3,E5, 6,E5, 3,D5, 9,E5,  3,F5, 6,F5, 15,E5
    defb 0ffh
BGM_C:
    defb 6,F2, 3,0, 3,F2, 3,0, 3,F2, 3,0, 3,F2,  6,C2, 3,0, 3,C2, 3,0, 3,C2, 3,0, 3,C2
    defb 6,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2,  6,E2, 3,0, 3,E2, 3,0, 3,E2, 3,0, 3,E2
    defb 6,F2, 3,0, 3,F2, 3,0, 3,F2, 3,0, 3,F2,  6,C2, 3,0, 3,C2, 3,0, 3,C2, 3,0, 3,C2
    defb 6,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2,  6,E2, 3,0, 3,E2, 3,0, 3,E2, 3,0, 3,E2
    defb 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0,  3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0
    defb 3,A2, 3,0, 3,A2, 3,0, 3,A2, 3,0, 3,A2, 3,0,  3,A2, 3,0, 3,A2, 3,0, 3,A2, 3,0, 3,A2, 3,0
    defb 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0,  3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0, 3,D2, 3,0
    defb 3,A2, 3,0, 3,A2, 3,0, 3,E2, 3,0, 3,E2, 3,0,  3,C3, 3,B2, 3,0, 12,A2, 3,0
    defb 0ffh


StartBGM_: public StartBGM_
    push af | push hl
        ld a,1
        ld hl,BGM_B
        ld (Channels+unitSize*1+Channel_Start),hl
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*1+Channel_Len),a
        ld hl,BGM_C
        ld (Channels+unitSize*2+Channel_Start),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Len),a
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push de | push bc
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld a,1
        ld (Channels+unitSize*1+Channel_Len),a
        ld (Channels+unitSize*2+Channel_Len),a
        ld bc,2*256 or Psg_VolumeB
        do
            ld a,c
            push bc
                ld bc,Port_Psg_Register
                out (c),a
                dec b
                xor a
                out (c),a
            pop bc
            inc c
        dwnz
        call SoundHandler
    pop bc | pop de | pop hl | pop af
ret


cycles:
    defw 1911 ; C2
    defw 1803 ; C2S
    defw 1702 ; D2
    defw 1607 ; D2S
    defw 1516 ; E2
    defw 1431 ; F2
    defw 1351 ; F2S
    defw 1275 ; G2
    defw 1203 ; G2S
    defw 1136 ; A2
    defw 1072 ; A2S
    defw 1012 ; B2
    defw 955 ; C3
    defw 901 ; C3S
    defw 851 ; D3
    defw 803 ; D3S
    defw 758 ; E3
    defw 715 ; F3
    defw 675 ; F3S
    defw 637 ; G3
    defw 601 ; G3S
    defw 568 ; A3
    defw 536 ; A3S
    defw 506 ; B3
    defw 477 ; C4
    defw 450 ; C4S
    defw 425 ; D4
    defw 401 ; D4S
    defw 379 ; E4
    defw 357 ; F4
    defw 337 ; F4S
    defw 318 ; G4
    defw 300 ; G4S
    defw 284 ; A4
    defw 268 ; A4S
    defw 253 ; B4
    defw 238 ; C5
    defw 225 ; C5S
    defw 212 ; D5
    defw 200 ; D5S
    defw 189 ; E5
    defw 178 ; F5
