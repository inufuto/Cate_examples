Port_Psg_Register equ 0FFFDh
Port_Psg_Out equ 0BFFDh
Port_Psg_In equ 0FFFDh

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

MaxVol equ 63
HighNoise equ 0f0h
LowNoise equ 0f1h

LowNoiseValue equ 63
HighNoiseValue equ 55   ;LowNoiseValue*2/3

tempo equ 200


dseg

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

;Wait defb 0
Channels: public Channels
    defs unitSize*count
time: defw 0
mixerValue: defb 0
shootingTone: defw 0


; bool IsPsgAvailable()
cseg
IsPsgAvailable_: public IsPsgAvailable_
    push bc
        ld bc,Port_Psg_Register
        ld a,Psg_Mixer
        out (c),a
        ld bc,Port_Psg_Out
        ld a,3fh
        out (c),a
        ld bc,Port_Psg_Register
        ld a,Psg_Mixer
        out (c),a
        ld bc,Port_Psg_In
        in a,(c)
        cp 3fh
        if z
            ld a,1
        else
            xor a
        endif
    pop bc
ret

; void InitSound();
cseg
InitSoundPsg: public InitSoundPsg
    push af | push bc | push de | push ix
        ld de,Psg_VolumeA
        ld a,count
        do
            ld bc,Port_Psg_Register
            out (c),e
            ld bc,Port_Psg_Out
            out (c),d
            inc e
            dec a
        while nz | wend

        ld bc,Port_Psg_Register
        ld a,Psg_Mixer
        out (c),a
        ld bc,Port_Psg_Out
        ld a,3fh
        out (c),a

        
        xor a
        ld ix,Channels
        ld b,count
        ld de,unitSize
        do
            ld (ix+Channel_Ptr),a
            ld (ix+Channel_Ptr+1),a
            ; ld (ix+Channel_Start),a
            ; ld (ix+Channel_Start+0),a
            ; ld (ix+Channel_Len),1
            ; ld (ix+Channel_Vol),a
            add ix,de
        dwnz
        ld hl,0
        ld (time),hl
        ld (shootingTone),hl

        ld a,0b8h
        ld (mixerValue),a
    pop ix | pop de | pop bc | pop af    
ret


SoundHandlerPsg: public SoundHandlerPsg
    push af | push hl | push de | push bc | push ix 
        ld hl,(shootingTone)
        ld a,l
        or h
        if nz
            ld a,Psg_ToneA
            ld bc,Port_Psg_Register
            out (c),a
            ld a,l
            ld bc,Port_Psg_Out
            out (c),a
            ld a,Psg_ToneA+1
            ld bc,Port_Psg_Register
            out (c),a
            ld a,h
            ld bc,Port_Psg_Out
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
                ld bc,Port_Psg_Out
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
                                    ld bc,Port_Psg_Out
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
                                    ld bc,Port_Psg_Out
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
                                    ld bc,Port_Psg_Register
                                    out (c),a
                                    ld a,e
                                    ld bc,Port_Psg_Out
                                    out (c),a
                                pop bc
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
                                push bc
                                    ld bc,Port_Psg_Register
                                    out (c),a
                                    ld bc,Port_Psg_Out
                                    ld a,(hl)
                                    out (c),a
                                    inc hl
                                    ld bc,Port_Psg_Register
                                    ld a,e
                                    inc a
                                    out (c),a
                                    ld bc,Port_Psg_Out
                                    ld a,(hl)
                                    out (c),a
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
                                    ld bc,Port_Psg_Register
                                    out (c),a
                                    ld a,e
                                    ld bc,Port_Psg_Out
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
                            ld bc,Port_Psg_Out
                            ld a,(ix+Channel_Vol)
                            srl a | srl a
                            out (c),a
                        pop bc
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
                exx
            pop hl
            ld de,500/2
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
        ld bc,Port_Psg_Out
        out (c),a
    pop bc
ret

MelodyWait:
    call Melody
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


Sound_FirePsg: public Sound_FirePsg
    push af| push hl | push de | push bc
        ld hl,(Channels++Channel_Ptr)
        ld a,l
        or h
        if z
            di
                ; ld hl,0
                ; ld (Channels++Channel_Ptr),hl
                ld hl, 150
                ld (shootingTone),hl
                ld a,Psg_VolumeA
                ld bc,Port_Psg_Register
                out (c),a
                ld a,15
                ld bc,Port_Psg_Out
                out (c),a
                ld a,(mixerValue)
                and 0f8h
                or 08h
                ld (mixerValue),a
                ld e,a
                ld a,Psg_Mixer
                ld bc,Port_Psg_Register
                out (c),a
                ld a,e
                ld bc,Port_Psg_Out
                out (c),a
            ei
        endif
    pop bc | pop de | pop hl | pop af
ret


smallExplosion_notes:
    defb 12,HighNoise, 0
Sound_SmallBangPsg: public Sound_SmallBangPsg
    push af | push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl | pop af
ret


largeExplosion_notes:
    defb 24,LowNoise, 0
Sound_LargeBangPsg: public Sound_LargeBangPsg
    push af | push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl | pop af
ret


up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_UpPsg: public Sound_UpPsg
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
Sound_StartPsg: public Sound_StartPsg
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
Sound_GameOverPsg: public Sound_GameOverPsg
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
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2
    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2

    defb N4,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N4,F2, N8,0, N8,F2, N8,0, N8,F2, N8,0, N8,F2
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,E2, N8,0, N8,E2, N8,0, N8,E2, N8,0, N8,E2

    defb N4,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N4,G2, N8,0, N8,G2, N8,0, N8,G2, N8,0, N8,G2
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    defb N4,C3, N8,0, N8,C3, N8,0, N8,C3, N8,0, N8,C3
    
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,D3, N8,D3, N8,0, N8,D3, N8,0, N8,D3, N8,0, N8,D3
    defb N8,A2, N8,A2, N8,0, N8,A2, N8,0, N8,A2, N8,0, N8,A2
    defb N8,F2, N8,F2, N8,0, N4P,E2, N4,0

    defb 0ffh


StartBGMPsg: public StartBGMPsg
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

StopBGMPsg: public StopBGMPsg
    push af | push hl | push de | push bc
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld (Channels+unitSize*1+Channel_Start),hl
        ld (Channels+unitSize*2+Channel_Start),hl
        ld a,1
        ld (Channels+unitSize*1+Channel_Len),a
        ld (Channels+unitSize*2+Channel_Len),a
        ld bc,2*256 or Psg_VolumeB
        do
            ld a,c
            push bc
                ld bc,Port_Psg_Register
                out (c),a
                ld bc,Port_Psg_Out
                xor a
                out (c),a
            pop bc
            inc c
        dwnz
    pop bc | pop de | pop hl | pop af
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
defw 1345 ; E2
defw 1269 ; F2
defw 1198 ; F2S
defw 1131 ; G2
defw 1067 ; G2S
defw 1007 ; A2
defw 951 ; A2S
defw 897 ; B2
defw 847 ; C3
defw 799 ; C3S
defw 754 ; D3
defw 712 ; D3S
defw 672 ; E3
defw 634 ; F3
defw 599 ; F3S
defw 565 ; G3
defw 533 ; G3S
defw 503 ; A3
defw 475 ; A3S
defw 448 ; B3
defw 423 ; C4
defw 399 ; C4S
defw 377 ; D4
defw 356 ; D4S
defw 336 ; E4
defw 317 ; F4
defw 299 ; F4S
defw 282 ; G4
defw 266 ; G4S
defw 251 ; A4
defw 237 ; A4S
defw 224 ; B4
defw 211 ; C5
defw 199 ; C5S
defw 188 ; D5
defw 178 ; D5S
defw 168 ; E5
defw 158 ; F5
defw 149 ; F5S
defw 141 ; G5
