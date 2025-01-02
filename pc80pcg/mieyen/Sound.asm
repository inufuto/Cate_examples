ext PollVSync_

Tempo equ 180
Count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Tone equ Channel_Start+2
Channel_Len equ Channel_Tone+2
UnitSize equ Channel_Len+1

Dseg
Channels:
Channel0:
    defs UnitSize
Channel1:
    defs UnitSize
Channel2:
    defs UnitSize
time:
    defw 0
port02Value:
    defw 0


cseg
Prompt:
    defb 12,"How many sound channels(1 or 3)?",0
InitSound: public InitSound
    ld hl,Prompt
    do
        ld a,(hl) | inc hl
        or a
    while nz
        call 257h
    wend
    call 0f75h
    call 257h
    cp '1'
    if z
        ld hl,Handler1
        jr InitSound_1
    endif
    cp '3'
    if z
        ld hl,Handler3
        jr InitSound_1
    endif
    jr InitSound
    InitSound_1:
    ld (SoundHandler_call+1),hl

    xor a | out (02h),a | ld (port02Value),a
    ld a,36h
    ld b,3
    do
        out (0fh),a
        add a,40h
    dwnz

    ld ix,Channels
    ld b,count
    ld de,unitSize
    xor a
    do
        ld (ix+Channel_Ptr),a
        ld (ix+Channel_Ptr+1),a
        ld (ix+Channel_Tone),a
        ld (ix+Channel_Tone+1),a
        add ix,de
    dwnz

    ld hl,0
    ld (time),hl
ret

SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                SoundHandler_call:
                call Handler3
            pop ix | pop bc | pop hl
            ld de,600/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

ToneOff3:
    ld a,b | cpl | ld l,a
    ld a,(port02Value) | and l | out (02h),a | ld (port02Value),a
ret
Handler3:
    ld bc,080ch
    do
        ld l,(ix+Channel_Ptr)
        ld h,(ix+Channel_Ptr+1)
        ld a,l | or h
        if nz
            dec (ix+Channel_Len)
            if z
                continue3:
                ld a,(hl)
                or a
                if z
                    ; end
                    ld (ix+Channel_Ptr),a
                    ld (ix+Channel_Ptr+1),a
                    ld (ix+Channel_Tone),a
                    ld (ix+Channel_Tone+1),a
                    ld a,b | neg | ld l,a
                    call ToneOff3
                    jr next3
                endif
                inc a
                if z 
                    ; repeat
                    ld l,(ix+Channel_Start)
                    ld h,(ix+Channel_Start+1)
                    jr continue3
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
                    ld a,(hl) | inc hl
                    out (c),a
                    ld a,(hl)
                    out (c),a
                    ld a,(port02Value) | or b | out (02h),a | ld (port02Value),a
                else
                    call ToneOff3
                endif
                EndWriteCycle:
            endif
        endif
        next3:
        ld de,unitSize
        add ix,de
        sla b
        ld a,b | cp 10h
        if z
            ld b,40h
        endif
        inc c
        ld a,c
        cp 0fh
    while nz | wend
ret

ToneOn1:
    ld a,l | out (0ch),a
    ld a,h | out (0ch),a
    ld a,08h | out (02h),a
ret
ToneOff1:
    xor a | out (02h),a
ret
Handler1:
    ld ix,Channels
    ld b,2
    do
        ld l,(ix+Channel_Ptr)
        ld h,(ix+Channel_Ptr+1)
        ld a,l
        or h
        if nz
            dec (ix+Channel_Len)                        
            if z
                continue1:
                ld a,(hl)
                or a
                if z
                    ; end
                    ld (ix+Channel_Ptr),a
                    ld (ix+Channel_Ptr+1),a
                    offch:
                    xor a
                    ld (ix+Channel_Tone),a
                    ld (ix+Channel_Tone+1),a
                    ld a,b
                    cp 2 
                    if z
                        ; Channel0
                        ld hl,(Channel1+Channel_Tone)
                        ld a,l | or h
                        if nz
                            call ToneOn1
                            jr next1
                        endif
                    endif
                    call ToneOff1
                    jr next1
                endif
                inc a
                if z 
                    ; repeat
                    ld l,(ix+Channel_Start)
                    ld h,(ix+Channel_Start+1)
                    jr continue1
                endif
                dec a
                ld (ix+Channel_Len),a
                inc hl
                ld a,(hl)
                inc hl
                ld (ix+Channel_Ptr),l
                ld (ix+Channel_Ptr+1),h
                or a
                jr z,offch
                dec a
                add a,a
                ld e,a
                ld d,0
                ld hl,cycles
                add hl,de
                ld a,(hl)
                inc hl
                ld h,(hl)
                ld l,a
                ld (ix+Channel_Tone),l
                ld (ix+Channel_Tone+1),h
                ld a,b
                cp 1
                if z
                    ; Channel1
                    ld a,(ix+Channel_Tone-UnitSize)
                    or (ix+Channel_Tone-UnitSize+1)
                    if nz
                        jr next1
                    endif
                endif
                call ToneOn1
            endif
        endif
        next1:
        ld de,UnitSize
        add ix,de
    dwnz
ret

Melody:
    push af
        di
            ld (Channel0+Channel_Ptr),hl
            ld a,1
            ld (Channel0+Channel_Len),a
        ei
    pop af
ret

MelodyWait:
    call Melody
    push af
        do
            call PollVSync_
            ld hl,(Channel0+Channel_Ptr)
            ld a,l
            or h
        while nz | wend
    pop af
ret 


; void Sound_Loose();
loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push hl
        ld hl,hit_notes
        call Melody
    pop hl
ret


; void Sound_Stole();
stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
Sound_Stole_: public Sound_Stole_
    push hl
        ld hl,stole_notes
        call Melody
    pop hl
ret


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push hl
        ld hl,fire_notes
        call Melody
    pop hl
ret


; void Sound_Bonus();
bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push af | push hl
        ld hl,bonus_notes
        call MelodyWait
    pop hl | pop af
ret


; void Sound_Start();
start_notes:
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret


; void Sound_Clear();
clear_notes:
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


; void Sound_GameOver();
over_notes:
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
ret


BGM_B:
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,D4,1,0
	defb 11,D4,1,0, 5,D4,1,0, 11,E4,1,0
	defb 17,D4,1,0, 36,0
	defb 11,C4,1,0, 11,G4,1,0
	defb 5,C4,1,0, 11,G4,1,0, 11,A4,1,0
	defb 5,A4,1,0, 5,G4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,F4,1,0, 5,E4,1,0, 5,E4,1,0, 11,F4,1,0
	defb 11,F4,1,0, 5,F4,1,0, 11,A4,1,0
	defb 17,G4,1,0, 36,0
	defb 5,E4,1,0, 5,E4,1,0, 5,E4,1,0, 11,E4,1,0
	defb 5,E4,1,0, 11,A4,1,0, 5,D4,1,0
	defb 5,D4,1,0, 5,D4,1,0, 11,D4,1,0
	defb 5,D4,1,0, 11,G4,1,0, 6,0
	defb 5,A4,1,0, 6,0, 5,G4,1,0, 6,0
	defb 5,F4,1,0, 6,0, 5,E4,1,0, 11,D4,1,0
	defb 11,E4,1,0, 23,C4,1,0
    defb 0ffh
BGM_C:
	defb 5,C3,1,0, 12,0, 17,E3,1,0
	defb 5,G3,1,0, 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,D3,1,0, 12,0
	defb 17,F3,1,0, 5,A3,1,0
	defb 6,0, 5,G2,1,0, 12,0
	defb 17,B2,1,0, 5,D3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,A2,1,0, 12,0
	defb 17,C3,1,0, 5,E3,1,0
	defb 6,0, 5,F3,1,0, 12,0
	defb 5,F3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,C3,1,0, 12,0
	defb 5,C3,1,0, 5,A2,1,0, 12,0
	defb 5,A2,1,0, 5,D3,1,0, 12,0
	defb 5,D3,1,0, 5,G2,1,0, 12,0
	defb 5,G2,1,0, 6,0, 5,F2,1,0, 6,0
	defb 5,F2,1,0, 6,0, 5,G2,1,0, 6,0
	defb 5,G2,1,0, 5,C3,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0
    defb 0ffh

StartBGM_: public StartBGM_
    push af | push hl
        ld a,1
        ld hl,BGM_B
        ld (Channel1+Channel_Start),hl
        ld (Channel1+Channel_Ptr),hl
        ld (Channel1+Channel_Len),a
        ld hl,BGM_C
        ld (Channel2+Channel_Start),hl
        ld (Channel2+Channel_Ptr),hl
        ld (Channel2+Channel_Len),a
    pop hl | pop af
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        ld hl,0
        ld (Channel1+Channel_Ptr),hl
        ld (Channel2+Channel_Ptr),hl
        ld (Channel1+Channel_Tone),hl
        ld (Channel2+Channel_Tone),hl
        xor a | out (02h),a | ld (port02Value),a
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
F5S equ 39
G5 equ 40

Cycles:
defw 48539 ; E2
defw 45815 ; F2
defw 43243 ; F#2
defw 40816 ; G2
defw 38525 ; G#2
defw 36363 ; A2
defw 34322 ; A#2
defw 32396 ; B2
defw 30578 ; C3
defw 28861 ; C#3
defw 27242 ; D3
defw 25713 ; D#3
defw 24269 ; E3
defw 22907 ; F3
defw 21621 ; F#3
defw 20408 ; G3
defw 19262 ; G#3
defw 18181 ; A3
defw 17161 ; A#3
defw 16198 ; B3
defw 15289 ; C4
defw 14430 ; C#4
defw 13620 ; D4
defw 12856 ; D#4
defw 12134 ; E4
defw 11453 ; F4
defw 10810 ; F#4
defw 10204 ; G4
defw 9631 ; G#4
defw 9090 ; A4
defw 8580 ; A#4
defw 8099 ; B4
defw 7644 ; C5
defw 7215 ; C#5
defw 6810 ; D5
defw 6428 ; D#5
defw 6067 ; E5
defw 5726 ; F5
defw 5405 ; F#5
defw 5102 ; G5
