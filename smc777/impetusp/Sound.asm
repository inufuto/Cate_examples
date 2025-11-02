ext InitSound777, SoundHandler777, Sound_Fire777, Sound_SmallBang777, Sound_LargeBang777, Sound_Up777
ext Sound_Start777, Sound_GameOver777, StartBGM777, StopBGM777
ext InitSound70, CallSound70, SoundHandler70, Sound_Fire70, Sound_Hit70, Sound_Loose70, Sound_Up70, Sound_Bonus70
ext Sound_Start70, Sound_GameOver70

cseg
InitSound: public InitSound
    in a,(1dh)
    and 04h
    if z
        call InitSound777
        ld hl,SoundHandler777 | ld (SoundHandler+1),hl
        ld hl,Sound_Fire777 | ld (Sound_Fire_+1),hl
        ld hl,Sound_SmallBang777 | ld (Sound_SmallBang_+1),hl
        ld hl,Sound_LargeBang777 | ld (Sound_LargeBang_+1),hl
        ld hl,Sound_Up777 | ld (Sound_Up_+1),hl
        ld hl,Sound_Start777 | ld (Sound_Start_+1),hl
        ld hl,Sound_GameOver777 | ld (Sound_GameOver_+1),hl
        ld hl,StartBGM777 | ld (StartBGM_+1),hl
        ld hl,StopBGM777 | ld (StopBGM_+1),hl
    else
        call InitSound70
        ld hl,SoundHandler70 | ld (SoundHandler+1),hl
        ld hl,CallSound70 | ld (CallSound_+1),hl
        ld hl,Sound_Fire70 | ld (Sound_Fire_+1),hl
        ld hl,Sound_Hit70 | ld (Sound_Hit_+1),hl
        ld hl,Sound_Loose70 | ld (Sound_Loose_+1),hl
        ld hl,Sound_Up70 | ld (Sound_Up_+1),hl
        ld hl,Sound_Start70 | ld (Sound_Start_+1),hl
        ld hl,Sound_GameOver70 | ld (Sound_GameOver_+1),hl
    endif
Dummy:
ret

SoundHandler: public SoundHandler
    jp Dummy
CallSound_: public CallSound_
    jp Dummy
Sound_Fire_: public Sound_Fire_
    jp Dummy
Sound_SmallBang_: public Sound_SmallBang_
    jp Dummy
Sound_LargeBang_: public Sound_LargeBang_
    jp Dummy
Sound_Hit_: public Sound_Hit_
    jp Dummy
Sound_Loose_: public Sound_Loose_
    jp Dummy
Sound_Up_: public Sound_Up_
    jp Dummy
Sound_Start_: public Sound_Start_
    jp Dummy
Sound_GameOver_: public Sound_GameOver_
    jp Dummy
StartBGM_: public StartBGM_
    jp Dummy
StopBGM_: public StopBGM_
    jp Dummy
