include "X1.inc"

ext WaitVSyncIn_,WaitVSyncOut_

dseg
tempo equ 220

count equ 3
Ch_Ptr equ 0
Ch_Start equ Ch_Ptr+2
Ch_Len equ Ch_Start+2
Ch_Vol equ Ch_Len+1
unitSize equ Ch_Vol+1

;Wait defb 0
Channels defs unitSize*count
time: defw 0
end_of_dseg: public end_of_dseg


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
        do
            ld (ix+Ch_Ptr),a
            ld (ix+Ch_Ptr+1),a
            add ix,de
        dwnz
        ld hl,0
        ld (time),hl
    pop ix | pop de | pop bc | pop af    
ret


ToneOn:
; in
;   hl : cycle
    push af | push bc
        ld bc,Port_Psg_Register
        ld a,Psg_ToneA
        out (c),a
        dec b
        ld a,l
        out (c),a
        inc b
        ld a,Psg_ToneA+1
        out (c),a
        dec b
        ld a,h
        out (c),a
        inc b
        ld a,Psg_VolumeA
        out (c),a
        dec b
        ld a,15
        out (c),a
    pop bc | pop af
ret

ToneWait: public ToneWait
; in
;   b: length
    do
        push bc
            call WaitVSyncOut_
            call SoundHandler_
            call WaitVSyncIn_
        pop bc
    dwnz
ret

ToneOff:
    ld bc,Port_Psg_Register
    ld a,Psg_VolumeA
    out (c),a
    dec b
    xor a
    out (c),a
ret


Sound_Get_: public Sound_Get_
    push af | push hl | push bc
        ld hl, 283
        call ToneOn
        ld b,2
        call ToneWait
        call ToneOff
    pop bc | pop hl | pop af
ret

Sound_Hit_: public Sound_Hit_
    push af | push hl | push bc
        ld hl, 300
        do
            Sound_Hit_.Loop:
            call ToneOn
            ld b,1
            call ToneWait
            ld bc,-10
            add hl,bc
            ld a,h
            or a
            jr nz,Sound_Hit_.Loop
            ld a,l
            cp 150
        while nz | wend
        call ToneOff
    pop bc | pop hl | pop af
ret


Sound_Miss_: 
    public Sound_Miss_
    push af | push hl | push de | push bc
        ld hl, 150
        do
            Sound_Miss_Loop:
            call ToneOn
            ld b,1
            call ToneWait
            ld bc,10
            add hl,bc
            ld a,h
            or a
            jr z,Sound_Miss_Loop
            ld a,l
            cp low 300
        while c | wend
        call ToneOff
    pop bc | pop de | pop hl | pop af
ret


Sound_Loose_: public Sound_Loose_
    push af | push hl | push de | push bc
        ld hl, 1000
        call ToneOn
        ld b,6
        call ToneWait
        call ToneOff
    pop bc | pop de | pop hl | pop af
ret

SoundHandler_: public SoundHandler_
    ; ld a,(Wait)
    ; or a
    ; if nz
    ;     dec a
    ;     ld (Wait),a
    ; endif

    push hl | push de
        ld hl,(time)
        ld de,-tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,count * 100h ; b = count; c = register
                do
                    ld l,(ix+Ch_Ptr)
                    ld h,(ix+Ch_Ptr+1)
                    ld a,l
                    or h
                    if nz
                        dec (ix+Ch_Len)
                        if z
                            continue:
                            ld a,(hl)
                            or a
                            if z
                                ; end
                                ld (ix+Ch_Ptr),a
                                ld (ix+Ch_Ptr+1),a
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
                                ld l,(ix+Ch_Start)
                                ld h,(ix+Ch_Start+1)
                                jr continue
                            endif
                            dec a
                            ld (ix+Ch_Len),a
                            inc hl
                            ld a,(hl)
                            inc hl
                            ld (ix+Ch_Ptr),l
                            ld (ix+Ch_Ptr+1),h
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
                                pop bc
                                ld (ix+Ch_Vol),15
                            else
                                ld (ix+Ch_Vol),0
                            endif
                        endif
                        ld a,c
                        add a,Psg_VolumeA
                        push bc
                            ld bc,Port_Psg_Register
                            out (c),a
                            dec b
                            ld a,(ix+Ch_Vol)
                            out (c),a
                        pop bc
                        or a
                        if nz
                            dec a
                            ld (ix+Ch_Vol),a
                        endif
                    endif
                    next:
                    inc c
                    ld de,unitSize
                    add ix,de
                dwnz
            pop ix | pop bc | pop hl
            ld de,550
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

MelodyWait:
    ld (Channels+Ch_Ptr),hl
    ld a,1
    ld (Channels+Ch_Len),a
    do
        call WaitVSyncOut_
        call SoundHandler_
        call WaitVSyncIn_
        ld hl,(Channels+Ch_Ptr)
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
Sound_Start_: public Sound_Start_
    push af | push hl | push de | push bc
        ld hl,start_notes
        call MelodyWait
    pop bc | pop de | pop hl | pop af
ret

clear_notes: defb 3,C4, 3,E4, 3,G4, 3,D4, 3,F4, 3,A4, 3,E4, 3,G4, 3,B4, 9,C5,0
Sound_Clear_: public Sound_Clear_
    push af | push hl | push de | push bc
        ld hl,clear_notes
        call MelodyWait
    pop bc | pop de | pop hl | pop af
ret

over_notes: defb 3,C5, 3,G4, 3,E4, 3,C5,  3,B4, 3,G4, 3,E4, 3,B4,  6,A4, 6,B4,  12,C5, 0
Sound_GameOver_: public Sound_GameOver_
    push af | push hl | push de | push bc
        ld hl,over_notes
        call MelodyWait
    pop bc | pop de | pop hl | pop af
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

StartBGM_: public StartBGM_
    push af | push hl
        ld a,1
        ld hl,BGM_B
        ld (Channels+unitSize*1+Ch_Start),hl
        ld (Channels+unitSize*1+Ch_Ptr),hl
        ld (Channels+unitSize*1+Ch_Len),a
        ld hl,BGM_C
        ld (Channels+unitSize*2+Ch_Start),hl
        ld (Channels+unitSize*2+Ch_Ptr),hl
        ld (Channels+unitSize*2+Ch_Len),a
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push de | push bc
        ld hl,0
        ld (Channels+unitSize*1+Ch_Ptr),hl
        ld (Channels+unitSize*2+Ch_Ptr),hl
        ld a,1
        ld (Channels+unitSize*1+Ch_Len),a
        ld (Channels+unitSize*2+Ch_Len),a
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
        call SoundHandler_
    pop bc | pop de | pop hl | pop af
ret


cycles:
    defw 1911 ; C2
    defw 1803 ; C#2
    defw 1702 ; D2
    defw 1607 ; D#2
    defw 1516 ; E2
    defw 1431 ; F2
    defw 1351 ; F#2
    defw 1275 ; G2
    defw 1203 ; G#2
    defw 1136 ; A2
    defw 1072 ; A#2
    defw 1012 ; B2
    defw 955 ; C3
    defw 901 ; C#3
    defw 851 ; D3
    defw 803 ; D#3
    defw 758 ; E3
    defw 715 ; F3
    defw 675 ; F#3
    defw 637 ; G3
    defw 601 ; G#3
    defw 568 ; A3
    defw 536 ; A#3
    defw 506 ; B3
    defw 477 ; C4
    defw 450 ; C#4
    defw 425 ; D4
    defw 401 ; D#4
    defw 379 ; E4
    defw 357 ; F
    defw 337 ; F#4
    defw 318 ; G4
    defw 300 ; G#4
    defw 284 ; A4
    defw 268 ; A#4
    defw 253 ; B4
    defw 238 ; C5

end_of_cseg: public end_of_cseg
