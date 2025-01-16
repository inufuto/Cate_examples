ext OpnAvailable

ext InitSoundBeep, SoundHandlerBeep, Sound_LooseBeep, Sound_HitBeep, Sound_StoleBeep
ext Sound_FireBeep, Sound_BonusBeep
ext Sound_StartBeep, Sound_ClearBeep, Sound_GameOverBeep, StartBGMBeep, StopBGMBeep
ext InitSoundOpn, SoundHandlerOpn, Sound_LooseOpn, Sound_HitOpn, Sound_StoleOpn
ext Sound_FireOpn, Sound_BonusOpn
ext Sound_StartOpn, Sound_ClearOpn, Sound_GameOverOpn, StartBGMOpn, StopBGMOpn

cseg
Dummy:
ret

cseg
InitSound: public InitSound
    call InitSoundOpn
    cmp byte ptr [OpnAvailable],0
    if z
        call InitSoundBeep
        mov word ptr [SoundHandler+1],SoundHandlerBeep
        mov word ptr [Sound_Loose_+1],Sound_LooseBeep
        mov word ptr [Sound_Hit_+1],Sound_HitBeep
        mov word ptr [Sound_Stole_+1],Sound_StoleBeep
        mov word ptr [Sound_Fire_+1],Sound_FireBeep
        mov word ptr [Sound_Bonus_+1],Sound_BonusBeep
        mov word ptr [Sound_Start_+1],Sound_StartBeep
        mov word ptr [Sound_Clear_+1],Sound_ClearBeep
        mov word ptr [Sound_GameOver_+1],Sound_GameOverBeep
        mov word ptr [StartBGM_+1],StartBGMBeep
        mov word ptr [StopBGM_+1],StopBGMBeep
    else
        mov word ptr [SoundHandler+1],SoundHandlerOpn
        mov word ptr [Sound_Loose_+1],Sound_LooseOpn
        mov word ptr [Sound_Hit_+1],Sound_HitOpn
        mov word ptr [Sound_Stole_+1],Sound_StoleOpn
        mov word ptr [Sound_Fire_+1],Sound_FireOpn
        mov word ptr [Sound_Bonus_+1],Sound_BonusOpn
        mov word ptr [Sound_Start_+1],Sound_StartOpn
        mov word ptr [Sound_Clear_+1],Sound_ClearOpn
        mov word ptr [Sound_GameOver_+1],Sound_GameOverOpn
        mov word ptr [StartBGM_+1],StartBGMOpn
        mov word ptr [StopBGM_+1],StopBGMOpn
    endif
ret

cseg
SoundHandler: public SoundHandler
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Loose_: public Sound_Loose_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Hit_: public Sound_Hit_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Stole_: public Sound_Stole_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Fire_: public Sound_Fire_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Bonus_: public Sound_Bonus_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Start_: public Sound_Start_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_Clear_: public Sound_Clear_
    defb 0eah
    defw Dummy
    defw 0060h
Sound_GameOver_: public Sound_GameOver_
    defb 0eah
    defw Dummy
    defw 0060h
StartBGM_: public StartBGM_
    defb 0eah
    defw Dummy
    defw 0060h
StopBGM_: public StopBGM_
    defb 0eah
    defw Dummy
    defw 0060h
