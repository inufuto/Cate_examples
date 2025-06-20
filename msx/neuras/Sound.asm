include "BIOS.inc"

Psg_Tone.A equ 0
Psg_Tone.B equ 2
Psg_Tone.C equ 4
Psg_Mixer equ 7
Psg_Volume.A equ 8
Psg_Volume.B equ 9
Psg_Volume.C equ 10
Psg_EnvTime equ 11
Psg_EnvType equ 13
Psg_Input1 equ 14
Psg_Input2 equ 14

    dseg
tempo equ 220

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

Wait defb 0
Channels defs unitSize*count
time: defw 0
end_of_dseg: public end_of_dseg
TempoValue:defw 600 | public TempoValue

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
ret

ToneOn:
; in
;   hl : cycle
    push af
        ld a,Psg_Tone.A
        ld e,l
        call WRTPSG
        ld a,Psg_Tone.A+1
        ld e,h
        call WRTPSG
        ld a,Psg_Volume.A
        ld e,15
        call WRTPSG
    pop af
ret

ToneWait:
; in
;   a: length
    ld (Wait),a
    do
        ld a,(Wait)
        or a
    while nz | wend
ret

ToneOff:
    ld a,Psg_Volume.A
    ld e,0
    call WRTPSG
ret


Sound_Get_: 
    public Sound_Get_
    push af | push hl | push de
        ld hl, 283
        call ToneOn
        ld a,2
        call ToneWait
        call ToneOff
    pop de | pop hl | pop af
ret

Sound_Hit_: 
    public Sound_Hit_
    push af | push hl | push de
        ld hl, 300
        do
            Sound_Hit_Loop:
            call ToneOn
            ld a,1
            call ToneWait
            ld de,-10
            add hl,de
            ld a,h
            or a
            jr nz,Sound_Hit_Loop
            ld a,l
            cp 150
        while nz | wend
        call ToneOff
    pop de | pop hl | pop af
ret


Sound_Miss_: 
    public Sound_Miss_
    push af | push hl | push de
        ld hl, 150
        do
            Sound_Miss_Loop:
            call ToneOn
            ld a,1
            call ToneWait
            ld de,10
            add hl,de
            ld a,h
            or a
            jr z,Sound_Miss_Loop
            ld a,l
            cp 300-256
        while nz | wend
        call ToneOff
    pop de | pop hl | pop af
ret


Sound_Loose_: 
    public Sound_Loose_
    push af | push hl | push de
        ld hl, 1000
        call ToneOn
        ld a,6
        call ToneWait
        call ToneOff
    pop de | pop hl | pop af
ret

SoundHandler2: 
    public SoundHandler2
    ld a,(Wait)
    or a
    if nz
        dec a
        ld (Wait),a
    endif
ret

SoundHandler1: 
    public SoundHandler1
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
                                add a,Psg_Volume.A
                                ld e,0
                                call WRTPSG
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
                                ld e,(hl)
                                call WRTPSG
                                inc hl
                                inc a
                                ld e,(hl)
                                call WRTPSG
                                ld (ix+Channel_Vol),15
                            else
                                ld (ix+Channel_Vol),0
                            endif
                        endif
                        ld a,c
                        add a,Psg_Volume.A
                        ld e,(ix+Channel_Vol)
                        call WRTPSG
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
                dwnz
            pop ix | pop bc | pop hl
            ld de,(TempoValue)
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

MelodyWait:
    di
    ld (Channels+Channel_Ptr),hl
    ld a,1
    ld (Channels+Channel_Len),a
    ei
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 

C2 equ 1
D2 equ 3
E2 equ 5
F2 equ 6
G2 equ 8
A2 equ 10

C4 equ 25
D4 equ 27
E4 equ 29
F4 equ 30
G4 equ 32
A4 equ 34
B4 equ 36
C5 equ 37

start_notes: defb 3,C4, 3,G4, 3,E4, 3,G4, 12,C5, 0
Sound_Start_:
    public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: defb 3,C5, 3,G4, 3,E4, 3,C5,  3,B4, 3,G4, 3,E4, 3,B4,  6,A4, 6,B4,  12,C5, 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B: 
    defb 3,D4, 3,F4, 3,G4
    defb 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4
    defb 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,A4, 3,G4
    defb 12,F4, 12,G4, 18,A4
    defb 3,D4, 3,F4, 3,G4
    defb 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4, 3,A4
    defb 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,G4, 3,A4, 3,G4
    defb 12,F4, 12,G4, 18,F4
    defb 0ffh
BGM_C: 
    defb 9,0
    defb 9,F2, 9,F2, 6,F2
    defb 9,C2, 9,C2, 6,C2
    defb 12,F2, 12,G2, 27,A2
    defb 9,A2, 9,A2, 6,A2
    defb 9,G2, 9,G2, 6,G2
    defb 12,F2, 12,C2, 18,F2
    defb 0ffh

StartBGM_:
    public StartBGM_
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

StopBGM_:
    public StopBGM_
    push af | push hl | push bc
        di
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld bc,2*256 or Psg_Volume.B
        do
            ld a,c
            ld e,0
            call WRTPSG
            inc c
        dwnz
        ei
    pop bc | pop hl | pop af
ret


cycles:
    defw 1710 ; C2
    defw 1614 ; C#2
    defw 1523 ; D2
    defw 1438 ; D#2
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

end_of_cseg: public end_of_cseg
