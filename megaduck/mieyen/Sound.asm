include "MegaDuck.inc"

Tempo equ 180/2
Denom equ 600/2/2
VolumeBits equ 4fh
MaxVolume equ 3fh

Channel_Ptr equ 0
Channel_Len equ 2
Channel_Start equ 3
UnitSize equ 5
MelodyChannel equ 0
BassChannel equ 1
EffectChannel equ 2
ChannelCount equ 3

dseg
Channels: public Channels
Channel0:
ChannelPtr0:
    defw 0
ChannelLen0:
    defb 0
ChannelStart0:
    defw 0
Channel1:
ChannelPtr1:
    defw 0
ChannelLen1:
    defb 0
ChannelStart1:
    defw 0
Channel2:
ChannelPtr2:
    defw 0
ChannelLen2:
    defb 0
ChannelStart2:
    defw 0
time:
    defb 0
envPort:
    defb 0
lowPort:
    defb 0

cseg
Clear:
    ld hl,Channels
    xor a,a
    ldh (rAUD1ENV),a
    ldh (rAUD2ENV),a
    ld b,UnitSize*ChannelCount
    do
        ld (hl+),a
        dec b
    while nz|wend
ret
InitSound: public InitSound
    ld a,8fh | ldh (rAUD1LEN),a
    ldh (rAUD2LEN),a
    ld a,77h | ldh (rAUDVOL),a
    ld a,0bbh | ldh (rAUDTERM),a
    ld a,8bh | ldh (rAUDENA),a

    call Clear
    ld (time),a
    ld (time+1),a
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld a,(time)
        sub a,Tempo
        ld (time),a
        if c
            push bc
                ld hl,Channels
                ld a,rAUD1ENV | ld (envPort),a
                ld a,rAUD1LOW | ld (lowPort),a
                ld b,ChannelCount
                do
                    ld e,(hl) | inc hl ; Ptr
                    ld d,(hl) | dec hl
                    ld a,e | or a,d
                    if nz
                        inc hl | inc hl
                        ld a,(hl) | dec a | ld (hl),a
                        dec hl | dec hl
                        if z
                            continue:
                            ld a,(de) | inc de ; length
                            or a,a
                            if z
                                ld a,(envPort) | ld c,a
                                xor a,a | ldh (c),a
                                ; end
                                ld (hl+),a
                                ld (hl),a | dec hl
                                jr next
                            endif
                            cp a,0ffh
                            if z 
                                ; repeat0
                                inc hl | inc hl | inc hl
                                ld e,(hl) | inc hl
                                ld d,(hl) | dec hl
                                dec hl | dec hl | dec hl
                                ld (hl),e | inc hl
                                ld (hl),d | dec hl
                                jr continue
                            endif
                            ; dec a
                            inc hl | inc hl
                            ld (hl),a ; length
                            dec hl | dec hl
                            ld a,(de) | inc de ; tone
                            ld (hl),e | inc hl
                            ld (hl),d | dec hl
                            or a,a
                            if nz
                                push af
                                    ld a,(envPort) | ld c,a
                                    ld a,VolumeBits | ldh (c),a
                                    ld a,(lowPort) | ld c,a
                                pop af
                                dec a | add a,a
                                add a,low Cycles | ld e,a
                                ld a,high Cycles | adc a,0 | ld d,a
                                ld a,(de) | inc de
                                ldh (c),a | inc c
                                ld a,(de)
                                or a,80h
                                ldh (c),a | dec c
                            endif
                        endif
                    endif
                    next:
                    ld a,rAUD2ENV | ld (envPort),a
                    ld a,rAUD2LOW | ld (lowPort),a
                    ld de,UnitSize | add hl,de
                    dec b
                while nz|wend
            pop bc
            ld a,(time)
            add a,Denom
            ld (time),a
        endif
    pop de | pop hl
ret


Melody:
    di
        ld a,l | ld (ChannelPtr2),a
        ld a,h | ld (ChannelPtr2+1),a
        ld a,1 | ld (ChannelLen2),a
    ei
ret

MelodyWait:
    call Melody
    push af | push hl
        do
            ld a,(ChannelPtr2) | ld l,a
            ld a,(ChannelPtr2+1)
            or a,l
        while nz | wend
    pop hl | pop af
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
Sound_Clear_: public Sound_Clear_
    push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl
ret


over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
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
    defb N8,G3, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G3, N4,0, N8,G3; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G3, N4,0, N8,G3; 12
    defb N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,G3, N8,0, N8,G3
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

    defb 0ffh

StartPart:
    ld (hl),e | inc hl
    ld (hl),d | inc hl
    ld (hl),1 | inc hl
    ld (hl),e | inc hl
    ld (hl),d
ret
StartBGM_: public StartBGM_
    push hl | push de
        di
            ld de,BGM_B
            ld hl,Channel0
            call StartPart
            ld de,BGM_C
            ld hl,Channel1
            call StartPart
        ei
    pop de | pop hl
ret

StopBGM_: public StopBGM_
    push af | push hl | push bc
        di
            call Clear
        ei
    pop bc | pop hl | pop af
ret


N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

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
defw 457 ; E2
defw 547 ; F2
defw 631 ; F#2
defw 711 ; G2
defw 786 ; G#2
defw 856 ; A2
defw 923 ; A#2
defw 986 ; B2
defw 1046 ; C3
defw 1102 ; C#3
defw 1155 ; D3
defw 1205 ; D#3
defw 1253 ; E3
defw 1297 ; F3
defw 1339 ; F#3
defw 1379 ; G3
defw 1417 ; G#3
defw 1452 ; A3
defw 1486 ; A#3
defw 1517 ; B3
defw 1547 ; C4
defw 1575 ; C#4
defw 1602 ; D4
defw 1627 ; D#4
defw 1650 ; E4
defw 1673 ; F4
defw 1694 ; F#4
defw 1714 ; G4
defw 1732 ; G#4
defw 1750 ; A4
defw 1767 ; A#4
defw 1783 ; B4
defw 1798 ; C5
defw 1812 ; C#5
defw 1825 ; D5
defw 1837 ; D#5
defw 1849 ; E5
defw 1860 ; F5
defw 1871 ; F#5
defw 1881 ; G5
