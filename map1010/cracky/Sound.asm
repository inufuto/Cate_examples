ext WaitTimer_, PollVSync_

Port_Psg_Register equ 0c1h
Port_Psg_Out equ 0c0h
; Port_Psg_In equ 0a2h

Psg_Tone_A equ 0
Psg_Tone_B equ 2
Psg_Tone_C equ 4
Psg_Noise equ 6
; Psg_Mixer equ 7
Psg_Volume_A equ 8
Psg_Volume_B equ 9
Psg_Volume_C equ 10
; Psg_EnvTime equ 11
; Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 15

MaxVol equ 63

tempo equ 160

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

    dseg
Channels defs unitSize*count
time: defw 0


; void InitSound();
cseg
InitSound_: public InitSound_
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

    ; ld a,0b8h
    ; ld (mixerValue),a
ret


ToneOn:
; in
;   hl : cycle
    push af
        ld a,Psg_Tone_A
        out (Port_Psg_Register),a
        ld a,l
        out (Port_Psg_Out),a
        ld a,Psg_Tone_A+1
        out (Port_Psg_Register),a
        ld a,h
        out (Port_Psg_Out),a
        ld a,Psg_Volume_A
        out (Port_Psg_Register),a
        ld a,15
        out (Port_Psg_Out),a
    pop af
ret


ToneOff:
    ld a,Psg_Volume_A
    out (Port_Psg_Register),a
    xor a
    out (Port_Psg_Out),a
ret


Sound_Loose_: public Sound_Loose_
    push af | push hl | push de
        ld hl, 1000
        call ToneOn
        ld a,6
        call WaitTimer_
        call ToneOff
    pop de | pop hl | pop af
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl | push bc | push ix
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
                                add a,Psg_Volume_A
                                out (Port_Psg_Register),a
                                xor a
                                out (Port_Psg_Out),a
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
                                out (Port_Psg_Register),a
                                ld a,(hl)
                                inc hl
                                out (Port_Psg_Out),a
                                ld a,e
                                inc a
                                out (Port_Psg_Register),a
                                ld a,(hl)
                                out (Port_Psg_Out),a
                                ld (ix+Channel_Vol),MaxVol
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_Volume_A
                        out (Port_Psg_Register),a
                        ld a,(ix+Channel_Vol)
                        srl a | srl a
                        out (Port_Psg_Out),a
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
            pop ix | pop bc | pop hl
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    ; di
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
    ld a,Psg_Volume_A
    out (Port_Psg_Register),a
    xor a
    out (Port_Psg_Out),a
    ; ei
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


start_notes: 
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N1,C5
    defb 0
Sound_Start_:
    public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: 
    defb N8,C4, N8,E4, N8,G4, N8,D4, N8,F4, N8,A4, N8,E4, N8,G4, N8,B4, N4P,C5,0       
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: 
    defb N8,C5, N8,C5, N8,G4, N8,G4, N8,A4, N8,A4, N8,B4, N8,B4
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
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,D5, N4,F5
    defb N8,F5, N8,E5, N8,C5, N4,C5, N4,D5
    defb N8,0, N8,C5, N8,C5, N8,C5, N8,C5, N4,G4, N4,C5
    defb N8,C5, N8,D5, N8,C5, N4,D5, N4,E5
    defb N4,F5, N4,F5, N4,E5, N4,E5
    defb N4,D5, N8,D5, N4,E5, N8,E5, N8,D5, N8,C5
    defb N4,C5, N4,C5, N8,D5, N4,D5, N4P,C5, N2P,0
    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0 ; 5
    defb N8,G2, N4,0, N4P,B2, N8,D3, N8,0 ; 6
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0 ; 8
    defb N8,F2, N4,0, N4P,A2, N8,C3, N8,0 ; 9
    defb N8,D3, N4,0, N4P,E3, N8,A3, N8,0 ; 10
    defb N8,F2, N4,0, N8,F2, N8,G2, N8,0, N8,B2, N8,D3 ; 11
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0 ; 12
    defb 0ffh

StartBGM_: public StartBGM_
    push af | push hl
        ; di
        ld a,1
        ld hl,BGM_B
        ld (Channels+unitSize*1+Channel_Start),hl
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*1+Channel_Len),a
        ld hl,BGM_C
        ld (Channels+unitSize*2+Channel_Start),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Len),a
        ; ei
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        ; di
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld a,1
        ld (Channels+unitSize*1+Channel_Len),a
        ld (Channels+unitSize*2+Channel_Len),a
        ld bc,2*256 or Psg_Volume_B

        do
            ld a,c
            out (Port_Psg_Register),a
            xor a
            out (Port_Psg_Out),a
            inc c
        dwnz
        ; ei
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

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defw 1514 ; E2
defw 1429 ; F2
defw 1349 ; F2S
defw 1273 ; G2
defw 1201 ; G2S
defw 1134 ; A2
defw 1070 ; A2S
defw 1010 ; B2
defw 954 ; C3
defw 900 ; C3S
defw 849 ; D3
defw 802 ; D3S
defw 757 ; E3
defw 714 ; F3
defw 674 ; F3S
defw 636 ; G3
defw 600 ; G3S
defw 567 ; A3
defw 535 ; A3S
defw 505 ; B3
defw 477 ; C4
defw 450 ; C4S
defw 424 ; D4
defw 401 ; D4S
defw 378 ; E4
defw 357 ; F4
defw 337 ; F4S
defw 318 ; G4
defw 300 ; G4S
defw 283 ; A4
defw 267 ; A4S
defw 252 ; B4
defw 238 ; C5
defw 225 ; C5S
defw 212 ; D5
defw 200 ; D5S
defw 189 ; E5
defw 178 ; F5
