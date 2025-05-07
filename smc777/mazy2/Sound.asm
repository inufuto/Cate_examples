ext InitSound777, Sound_Beep777, Sound_Get777, Sound_Hit777, Sound_Loose777
ext Sound_Start777, Sound_Clear777, Sound_GameOver777, StartBGM777, StopBGM777
ext InitSound70, Sound_Beep70, Sound_Get70, Sound_Hit70, Sound_Loose70
ext Sound_Start70, Sound_Clear70, Sound_GameOver70, CallSound70

cseg
InitSound: public InitSound
    in a,(1dh)
    and 04h
    if z
        call InitSound777
        ld hl,Sound_Beep777 | ld (Sound_Beep_+1),hl
        ld hl,Sound_Get777 | ld (Sound_Get_+1),hl
        ld hl,Sound_Hit777 | ld (Sound_Hit_+1),hl
        ld hl,Sound_Loose777 | ld (Sound_Loose_+1),hl
        ld hl,Sound_Start777 | ld (Sound_Start_+1),hl
        ld hl,Sound_Clear777 | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOver777 | ld (Sound_GameOver_+1),hl
        ld hl,StartBGM777 | ld (StartBGM_+1),hl
        ld hl,StopBGM777 | ld (StopBGM_+1),hl
    else
        call InitSound70
        ld hl,CallSound70 | ld (CallSound_+1),hl
        ld hl,Sound_Beep70 | ld (Sound_Beep_+1),hl
        ld hl,Sound_Get70 | ld (Sound_Get_+1),hl
        ld hl,Sound_Hit70 | ld (Sound_Hit_+1),hl
        ld hl,Sound_Loose70 | ld (Sound_Loose_+1),hl
        ld hl,Sound_Start70 | ld (Sound_Start_+1),hl
        ld hl,Sound_Clear70 | ld (Sound_Clear_+1),hl
        ld hl,Sound_GameOver70 | ld (Sound_GameOver_+1),hl
    endif
ret
    
Dummy:
ret

CallSound_: public CallSound_
    jp Dummy
Sound_Beep_: public Sound_Beep_
    jp Dummy
Sound_Get_: public Sound_Get_
    jp Dummy
Sound_Hit_: public Sound_Hit_
    jp Dummy
Sound_Loose_: public Sound_Loose_
    jp Dummy
Sound_Start_: public Sound_Start_
    jp Dummy
Sound_Clear_: public Sound_Clear_
    jp Dummy
Sound_GameOver_: public Sound_GameOver_
    jp Dummy
StartBGM_: public StartBGM_
    jp Dummy
StopBGM_: public StopBGM_
    jp Dummy
