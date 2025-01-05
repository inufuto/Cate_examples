Port_A equ 0f8h
Port_B equ 0f9h
Port_C equ 0fah
Tone_Off equ 3fh

Tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
unitSize equ Channel_Len+1

    dseg
Channels defs unitSize*count
time: defw 0


cseg
InitSound: public InitSound
    push hl | push bc
        ld hl,Channels
        ld b,unitSize*count
        do
            ld (hl),0
            inc hl
        dwnz
        ld hl,0
        ld (time),hl
    pop bc | pop hl
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld bc,(count * 100h) or Port_A   ; b = count; c = port
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
                                ld a,Tone_Off
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
                                ld e,a
                                ld d,0
                                ld hl,cycles
                                add hl,de
                                ld a,(hl)
                                out (c),a
                            else
                                ld a,Tone_Off
                                out (c),a
                            endif
                        endif
                    endif
                    next:
                    inc c
                    ld de,unitSize
                    add ix,de
                dwnz
            pop ix | pop bc | pop hl
            ld de,550/2
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


IsPlaying_: public IsPlaying_
    push hl
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
        if nz
            ld a,1
        endif
    pop hl
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
	defb 11,C4,1,0, 11,E4,1,0
	defb 5,G4,1,0, 11,E4,1,0, 11,F4,1,0
	defb 5,F4,1,0, 11,A4,1,0, 5,C5,1,0
	defb 17,A4,1,0, 31,C5,5,0
	defb 12,0
    defb 0
Sound_Start_: public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret


clear_notes: 
	defb 5,A4,1,0, 5,A4,1,0, 5,G4,1,0, 5,F4,1,0
	defb 5,G4,1,0, 11,A4,1,0, 11,B4,1,0
	defb 5,B4,1,0, 5,A4,1,0, 5,G4,1,0, 5,A4,1,0
	defb 11,B4,1,0, 29,C5,1,0
	defb 24,0
    defb 0
Sound_Clear_: 
    public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret


over_notes: 
	defb 5,C5,1,0, 5,F4,1,0, 5,A4,1,0, 5,E4,1,0
	defb 5,G4,1,0, 5,A4,1,0, 5,B4,1,0, 5,C5,1,0
	defb 31,C5,5,0
	defb 12,0
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
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
	defb 5,C4,1,0, 12,0, 17,E3,1,0
	defb 5,G3,1,0, 6,0, 5,A3,1,0, 12,0
	defb 17,C4,1,0, 5,E3,1,0
	defb 6,0, 5,D3,1,0, 12,0
	defb 17,F3,1,0, 5,A3,1,0
	defb 6,0, 5,G3,1,0, 12,0
	defb 17,B3,1,0, 5,D3,1,0
	defb 6,0, 5,C4,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,A3,1,0, 12,0
	defb 17,C4,1,0, 5,E3,1,0
	defb 6,0, 5,F3,1,0, 12,0
	defb 5,F3,1,0, 5,G3,1,0, 12,0
	defb 5,G3,1,0, 5,C4,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0, 5,C4,1,0, 12,0
	defb 5,C4,1,0, 5,A3,1,0, 12,0
	defb 5,A3,1,0, 5,D3,1,0, 12,0
	defb 5,D3,1,0, 5,G3,1,0, 12,0
	defb 5,G3,1,0, 6,0, 5,F3,1,0, 6,0
	defb 5,F3,1,0, 6,0, 5,G3,1,0, 6,0
	defb 5,G3,1,0, 5,C4,1,0, 12,0
	defb 17,E3,1,0, 5,G3,1,0
	defb 6,0
    defb 0ffh

StartBGM_: public StartBGM_
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

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
        ld hl,0
        ld (Channels+unitSize*1+Channel_Ptr),hl
        ld (Channels+unitSize*2+Channel_Ptr),hl
        ld bc,3*256+Port_A
        ld a,Tone_Off
        do
            out (c),a
            inc c
        dwnz
        ei
    pop bc | pop hl | pop af
ret


D3 equ 1
D3S equ 2
E3 equ 3
F3 equ 4
F3S equ 5
G3 equ 6
G3S equ 7
A3 equ 8
A3S equ 9
B3 equ 10
C4 equ 11
C4S equ 12
D4 equ 13
D4S equ 14
E4 equ 15
F4 equ 16
F4S equ 17
G4 equ 18
G4S equ 19
A4 equ 20
A4S equ 21
B4 equ 22
C5 equ 23
C5S equ 24
D5 equ 25
D5S equ 26
E5 equ 27
F5 equ 28
F5S equ 29
G5 equ 30

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 3 ; D3
defb 6 ; D#3
defb 9 ; E3
defb 12 ; F3
defb 15 ; F#3
defb 18 ; G3
defb 20 ; G#3
defb 23 ; A3
defb 25 ; A#3
defb 27 ; B3
defb 29 ; C4
defb 31 ; C#4
defb 33 ; D4
defb 35 ; D#4
defb 36 ; E4
defb 38 ; F4
defb 39 ; F#4
defb 41 ; G4
defb 42 ; G#4
defb 43 ; A4
defb 44 ; A#4
defb 45 ; B4
defb 46 ; C5
defb 47 ; C#5
defb 48 ; D5
defb 49 ; D#5
defb 50 ; E5
defb 51 ; F5
defb 51 ; F#5
defb 52 ; G5
