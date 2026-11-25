include "Share.inc"

ext HaltSub, ResumeSub
ext Playing

cseg
Play:
    call HaltSub
    ld (MainShareRam+Share_SoundId),a
    ld a,SubCommand_Play | ld (MainShareRam+Share_Command),a
    call ResumeSub
ret

PlayWait:
    call Play
    do
        call HaltSub
        ld a,SubCommand_Nop | ld (MainShareRam+Share_Command),a
        call ResumeSub
        ld a,(Playing)
        or a
    while nz | wend
ret

; void Sound_Loose();
cseg
Sound_Loose_: public Sound_Loose_
    push af
        ld a,SoundId_Loose | call PlayWait
    pop af
ret

; void Sound_Hit();
cseg
Sound_Hit_: public Sound_Hit_
    push af
        ld a,SoundId_Hit | call Play
    pop af
ret

; void Sound_Beep();
cseg
Sound_Beep_: public Sound_Beep_
    push af
        ld a,SoundId_Beep | call PlayWait
    pop af
ret

; void Sound_Start();
cseg
Sound_Start_: public Sound_Start_
    push af
        ld a,SoundId_Start | call PlayWait
    pop af
ret

; void Sound_Clear();
cseg
Sound_Clear_: public Sound_Clear_
    push af
        ld a,SoundId_Clear | call PlayWait
    pop af
ret

; void Sound_GameOver();
cseg
Sound_GameOver_: public Sound_GameOver_
    push af
        ld a,SoundId_GameOver | call PlayWait
    pop af
ret

; void StartBGM();
cseg
StartBGM_: public StartBGM_
    push af
        ld a,SoundId_StartBGM | call Play
    pop af
ret

; void StopBGM();
cseg
StopBGM_: public StopBGM_
    push af
        ld a,SoundId_StopBGM | call Play
    pop af
ret