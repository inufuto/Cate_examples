Tempo equ 200

Tone0Port equ 0a0h
Tone1Port equ 0a2h
Tone2Port equ 0a4h
Vol0Port equ 0a8h
Vol1Port equ 0a9h
Vol2Port equ 0aah
VolNoisePort equ 0abh

MaxVol equ 63
HighNoise equ 0f0h
LowNoise equ 0f1h
LowNoiseValue equ 100
HighNoiseValue equ LowNoiseValue*2/3


count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
NoiseVol:
    defb 0
time:
    defw 0

cseg
InitSound: public InitSound
    ld a,01h | out (0a6h),a

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


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(time)
        ld de,-Tempo
        add hl,de
        if nc
            push hl | push bc | push ix
                ld ix,Channels
                ld de,Vol0Port or (Tone0Port shl 8) ; d=tone port, e=volume port
                do
                    ld l,(ix+Channel_Ptr) | ld h,(ix+Channel_Ptr+1)
                    ld a,l | or h
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
                                ld c,e
                                xor a
                                out (c),a
                                inc c | inc c | inc c | inc c
                                out (c),a
                                out (VolNoisePort),a
                                out (VolNoisePort+4),a
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
                                ld hl,HighNoiseValue
                                WriteNoise:
                                ld a,l | out (Tone0Port),a
                                ld a,h | out (Tone0Port+1),a
                                ld (ix+Channel_Vol),MaxVol/2 or 80h
                                xor a
                                out (Vol0Port),a
                                out (Vol0Port+4),a
                                jr EndWriteCycle
                            endif
                            cp LowNoise
                            if z
                                ld hl,LowNoiseValue
                                jr WriteNoise
                            endif
                            or a
                            if nz
                                dec a
                                add a,a
                                ld c,a | ld b,0
                                ld hl,cycles | add hl,bc
                                ld c,d
                                ld a,(hl) | inc hl
                                out (c),a | inc c
                                ld a,(hl)
                                out (c),a
                                ld (ix+Channel_Vol),MaxVol
                                xor a
                                out (VolNoisePort),a
                                out (VolNoisePort+4),a
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,(ix+Channel_Vol)
                        ld b,a
                        or a
                        if p
                            ld c,e
                            out (c),a
                            inc c | inc c | inc c | inc c
                            out (c),a
                        else
                            and 1fh | add a,a
                            out (VolNoisePort),a
                            out (VolNoisePort+4),a
                        endif
                        or a
                        if nz
                            dec b
                            ld (ix+Channel_Vol),b
                        endif
                    endif
                    next:
                    ld bc,unitSize
                    add ix,bc
                    
                    inc d | inc d
                    inc e
                    ld a,e | cp Vol0Port+count
                while nz | wend
            pop ix | pop bc | pop hl
            ld de,600/2
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
            ld a,l | or h
        while nz | wend
    pop af
ret 


; void Sound_Fire();
fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push af | push hl
        ld hl,(Channels+Channel_Ptr)
        ld a,l | or h
        if z
            ld hl,fire_notes
            call Melody
        endif
    pop hl | pop af
ret


; void Sound_SmallBang();
smallExplosion_notes:
    defb N1,HighNoise, 0
Sound_SmallBang_: public Sound_SmallBang_
    push hl
        ld hl,smallExplosion_notes
        call Melody
    pop hl
ret


; void Sound_LargeBang();
largeExplosion_notes:
    defb N1,LowNoise, 0
Sound_LargeBang_: public Sound_LargeBang_
    push hl
        ld hl,largeExplosion_notes
        call Melody
    pop hl
ret


; void Sound_Up();
up_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Up_: public Sound_Up_
    push hl
        ld hl,up_notes
        call Melody
    pop hl
ret


; void Sound_Start();
start_notes: 
    defb N8,A4, N4,B4, N4,C5, N4,C5, N8,A4
    defb N4,D5, N4,D5, N8,C5, N4P,D5
    defb N2P,E5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push hl
        ld hl,start_notes
        call MelodyWait
    pop hl
ret

; void Sound_GameOver();
over_notes: 
    defb N4,A4,  N8,E4, N8,A4, N8,G4, N8,F4, N8,E4, N8,D4
    defb N2P,E4, N4,0
    defb 0
Sound_GameOver_: 
    public Sound_GameOver_
    push hl
        ld hl,over_notes
        call MelodyWait
    pop hl
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

; void StartBGM();
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

; void StopBGM();
StopBGM_: public StopBGM_
    push hl | push bc
        di
            ld hl,0
            ld (Channels+unitSize*1+Channel_Ptr),hl
            ld (Channels+unitSize*2+Channel_Ptr),hl
            ld bc,Vol0Port or 800h
            do
                out (c),l
                inc c
            dwnz
        ei
    pop bc | pop hl
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
N16 equ N8/2

cycles:
defw 1516 ; E2
defw 1431 ; F2
defw 1350 ; F#2
defw 1275 ; G2
defw 1203 ; G#2
defw 1135 ; A2
defw 1072 ; A#2
defw 1011 ; B2
defw 955 ; C3
defw 901 ; C#3
defw 850 ; D3
defw 803 ; D#3
defw 757 ; E3
defw 715 ; F3
defw 675 ; F#3
defw 637 ; G3
defw 601 ; G#3
defw 567 ; A3
defw 535 ; A#3
defw 505 ; B3
defw 477 ; C4
defw 450 ; C#4
defw 425 ; D4
defw 401 ; D#4
defw 378 ; E4
defw 357 ; F4
defw 337 ; F#4
defw 318 ; G4
defw 300 ; G#4
defw 283 ; A4
defw 267 ; A#4
defw 252 ; B4
defw 238 ; C5
defw 224 ; C#5
defw 212 ; D5
defw 200 ; D#5
defw 189 ; E5
defw 178 ; F5
defw 168 ; F#5
defw 158 ; G5
