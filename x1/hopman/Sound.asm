ext PollVSync_

Port_Psg_Register equ 1c00h
Port_Psg_Out equ 1b00h
Port_Psg_In equ 1b00h

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
; Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10
;Psg_EnvTime equ 11
;Psg_EnvType equ 13

MaxVol equ 63

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
wait defb 0


cseg
InitSound: public InitSound
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
        do
            ld (ix+Channel_Ptr),a
            ld (ix+Channel_Ptr+1),a
            add ix,de
        dwnz
        ld hl,0
        ld (time),hl

        ; ld a,0b8h
        ; ld (mixerValue),a
    pop ix | pop de | pop bc | pop af    
ret


SoundHandler: public SoundHandler
    push af | push hl | push de | push bc | push ix 
        ld a,(Wait)
        or a
        if nz
            dec a
            ld (Wait),a
        endif

        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl
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
                                    ld (ix+Channel_Vol),MaxVol  
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
                dwnz
            pop hl
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop ix | pop bc | pop de | pop hl | pop af
ret

Melody:
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
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
        call PollVSync_
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push af | push hl
        ld hl,bonus_notes
        call Melody
    pop hl | pop af
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push af | push hl
        ld hl,hit_notes
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


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push af | push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl | pop af
ret


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_:
    public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
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
                dec b
                xor a
                out (c),a
            pop bc
            inc c
        dwnz
        ld b,100
        do
            call PollVSync_
        dwnz
    pop bc | pop de | pop hl | pop af
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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

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
