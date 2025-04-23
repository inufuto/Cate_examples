ext WaitTimer_

Psg_ToneA equ 0
Psg_ToneB equ 2
Psg_ToneC equ 4
;Psg_Noise equ 6
Psg_Mixer equ 7
Psg_VolumeA equ 8
Psg_VolumeB equ 9
Psg_VolumeC equ 10
;Psg_EnvTime equ 11
;Psg_EnvType equ 13
;Psg_Input1 equ 14
;Psg_Input2 equ 15

MaxVol equ 63

tempo equ 170

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time:
    defw 0


cseg
WRTPSG:
    push bc
        ld bc,0f782h | out (c),c

        ld b,0f4h | out (c),a
        ld bc,0f6c0h | out (c),c
        ld bc,0f600h | out (c),c

        ld b,0f4h | out (c),e
        ld bc,0f680h | out (c),c
        ld bc,0f600h | out (c),c
    pop bc
ret


cseg
InitSound: public InitSound
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

    ld a,Psg_Mixer
    ld e,38h
    call WRTPSG
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
                                add a,Psg_VolumeA
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
                                ld (ix+Channel_Vol),MaxVol
                            else
                                rest:
                                ld (ix+Channel_Vol),0
                            endif
                            EndWriteCycle:
                        endif
                        ld a,c
                        add a,Psg_VolumeA
                        ld e,(ix+Channel_Vol)
                        srl e | srl e
                        call WRTPSG
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
            ld de,500/2
            add hl,de
        endif
        ld (time),hl
    pop de | pop hl
ret

Melody:
    push de
        di
        ld (Channels+Channel_Ptr),hl
        ld a,1
        ld (Channels+Channel_Len),a
        ld e,0
        ld a,Psg_VolumeA
        call WRTPSG
        ei
    pop de
ret

MelodyWait:
    call Melody
    do
        ld hl,(Channels+Channel_Ptr)
        ld a,l
        or h
    while nz | wend
ret 


; void Sound_Loose();
loose_notes:
    defb 1,C4, 0
Sound_Loose_: public Sound_Loose_
    push af | push hl
        ld hl,loose_notes
        call MelodyWait
    pop hl | pop af
ret


; void Sound_Hit();
hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push af | push hl
        ld hl,hit_notes
        call Melody
    pop hl | pop af
ret


; void Sound_Freeze();
freeze_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4
    defb 0 
Sound_Freeze_: public Sound_Freeze_
    push af | push hl
        ld hl,freeze_notes
        call Melody
    pop hl | pop af
ret


; void Sound_Beep();
beep_notes:
    defb 1,A4, 0
Sound_Beep_: public Sound_Beep_
    push af | push hl
        ld hl,beep_notes
        call MelodyWait
    pop hl | pop af
ret


start_notes: 
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N8R+N4,D5
    defb N4,D5, N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push af | push hl
        ld hl,start_notes
        call MelodyWait
    pop hl | pop af
ret

clear_notes: 
    defb N4,C4, N4,E4, N4+N8L,G4, N4,A4 
    defb N8R,A4, N8L,G4, N8R,F4, N8L,G4, N8R,G4, N8L,A4, N8R,B4
    defb N2P,C5, N4,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push af | push hl
        ld hl,clear_notes
        call MelodyWait
    pop hl | pop af
ret

over_notes: 
    defb N8L,C5, N8R,C5, N8L,B4, N8R,B4, N8L,A4, N8R,A4, N8L,G4, N8R,E4
    defb N8L,G4, N8R,G4, N8L,A4, N8R,B4, N2,C5
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push af | push hl
        ld hl,over_notes
        call MelodyWait
    pop hl | pop af
ret


BGM_B:
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N2,D5, N8R,0 ; 3-5
    defb N4,E5, N4,G5, N8L,D5, N8R,C5, N8L,D5, N1,E5, N8R,0 ; 5-6
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,D5, N8R,D5, N8L,D5, N2,E5, N8R,0 ; 7-8
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,G5, N8R,G5, N8L,G5, N2,D5, N8R,0 ; 9-10
    
    defb N4,C5, N4,C5, N4,G4, N4,G4, N8L,E5, N8R,D5, N8L,E5, N2,D5, N8R,0 ; 11-12
    defb N4,E5, N4,G5, N8L,D5, N8R,C5, N8L,D5, N1,E5, N8R,0 ; 13-14
    defb N4,F5, N4,F5, N4,E5, N4,E5, N8L,G5, N8R,G5, N8L,G5, N8R+N4,E5, N4,D5 ; 15-16
    defb N4,C5, N4,G4, N8L,C5, N4,D5, N1,C5, N8R,0 ; 17-18
    
    defb 0ffh

BGM_C:
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,C3, N8L,0, N8R,C3 ; 19
    defb N8L,0, N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,D3, N8L,C3, N8R,D3S ; 20
    defb N8L,E3, N8R,B2, N8L,E3, N8R,0, N4,E3, N8L,0, N4,A2 ; 21-
    defb N8R,A2, N8L,0, N8R,A2, N8L,A2, N8R,0, N8L,A2, N8R,0 ; 22
    defb N8L,F3, N8R,C3, N8L,F3, N8R,0, N4,F3, N8L,0, N4,D3 ; 23-
    defb N8R,D3, N8L,0, N8R,D3, N8L,D3, N8R,0, N8L,D3, N8R,0 ; 24
    defb N8L,F2, N8R,0, N8L,F2, N8R,0, N4,F2, N8L,0, N4,G3 ; 25-
    defb N8R,G3, N8L,0, N8R,D3, N8L,G3, N8R,D3, N8L,G3, N8R,0 ; 26
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,C3, N8L,0, N8R,C3 ; 27
    defb N8L,0, N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,D3, N8L,C3, N8R,D3S ; 28
    defb N8L,E3, N8R,B2, N8L,E3, N8R,0, N4,E3, N8L,0, N4,A2 ; 29-
    defb N8R,A2, N8L,0, N8R,E2, N8L,A2, N8R,E2, N8L,A2, N8R,0 ; 30
    defb N8L,F2, N8R,0, N8L,F2, N8R,0, N4,F2, N8L,0, N4,E2 ; 31-
    defb N8R,E2, N8L,0, N8R,E2, N8L,E2, N8R,0, N8L,E2, N8R,0 ; 32
    defb N8L,C3, N8R,0, N8L,C3, N8R,0, N4,G2, N8L,0, N4,C3 ;33-
    defb N8R,C3, N8L,0, N8R,C3, N8L,C3, N8R,0, N8L,C3, N8R,0 ; 34
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
            ld bc,2*256 or Psg_VolumeB
            do
                ld a,c
                ld e,0
                call WRTPSG
                inc c
            dwnz
        ei
    pop bc | pop hl | pop af
ret


N8 equ 6
N8L equ 8
N8R equ 4
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

cycles:
defw 758 ; E2
defw 715 ; F2
defw 675 ; F#2
defw 637 ; G2
defw 601 ; G#2
defw 568 ; A2
defw 536 ; A#2
defw 506 ; B2
defw 477 ; C3
defw 450 ; C#3
defw 425 ; D3
defw 401 ; D#3
defw 379 ; E3
defw 357 ; F3
defw 337 ; F#3
defw 318 ; G3
defw 300 ; G#3
defw 284 ; A3
defw 268 ; A#3
defw 253 ; B3
defw 238 ; C4
defw 225 ; C#4
defw 212 ; D4
defw 200 ; D#4
defw 189 ; E4
defw 178 ; F4
defw 168 ; F#4
defw 159 ; G4
defw 150 ; G#4
defw 142 ; A4
defw 134 ; A#4
defw 126 ; B4
defw 119 ; C5
defw 112 ; C#5
defw 106 ; D5
defw 100 ; D#5
defw 94 ; E5
defw 89 ; F5
defw 84 ; F#5
defw 79 ; G5
