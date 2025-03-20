include "vgszero.inc"

ext PollVSync_

Tempo equ 180

dseg
Count:
    defb 0
denom:
    defw 0


cseg
InitSound: public InitSound
    xor a
    ld (Count),a
ret


SoundHandler: public SoundHandler
    push hl | push de
        ld hl,(denom)
        ld de,-Tempo
        add hl,de
        if nc
            push af
                ld a,(Count)
                or a
                if nz
                    dec a
                    ld (Count),a
                endif
            pop af
            ld de,600/2
            add hl,de
        endif
        ld (denom),hl
    pop de | pop hl
ret


Wait: ;(a)
    ld (Count),a
    do
        call PollVSync_
        ld a,(Count)
        or a
    while nz | wend
ret


; void WaitSound();
cseg
WaitSound_: public WaitSound_
    push af
        do
            call PollVSync_
            ld a,(Count)
            or a
        while nz | wend
    pop af
ret


; void Sound_Fire();
cseg
Sound_Fire_: public Sound_Fire_
    push af
        ld a,0 | out (PlaySoundEffect),a
    pop af
ret


; void Sound_Beep();
cseg
Sound_Beep_: public Sound_Beep_
    push af
        ld a,4 | out (PlayBGM),a
        ld a,3 | call Wait
    pop af
ret


; void Sound_SmallBang();
cseg
Sound_SmallBang_: public Sound_SmallBang_
    push af
        ld a,1 | out (PlaySoundEffect),a
    pop af
ret


; void Sound_LargeBang();
cseg
Sound_LargeBang_: public Sound_LargeBang_
    push af
        ld a,1 | out (PlaySoundEffect),a
    pop af
ret


; void Sound_Start();
cseg
Sound_Start_: public Sound_Start_
    push af
        ld a,1 | out (PlayBGM),a
        ld a,96 | ld (Count),a
    pop af
ret


; void Sound_Clear();
cseg
Sound_Clear_: public Sound_Clear_
    push af
        ld a,2 | out (PlayBGM),a
        ld a,108 | call Wait
    pop af
ret


; void Sound_GameOver();
cseg
Sound_GameOver_: public Sound_GameOver_
    push af
        ld a,3 | out (PlayBGM),a
        ld a,96 | call Wait
    pop af
ret


; void StartBGM();
cseg
StartBGM_: public StartBGM_
    push af
        ld a,0 | out (PlayBGM),a
    pop af
ret


; void StopBGM();
cseg
StopBGM_: public StopBGM_
    push af
        ld a,2 | out (StopBGM),a
    pop af
ret
