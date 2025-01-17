ext ScanKeys_

ext InitSoundBeep, SoundHandlerBeep, Sound_LooseBeep, Sound_HitBeep, Sound_StoleBeep
ext Sound_FireBeep, Sound_BonusBeep
ext Sound_StartBeep, Sound_ClearBeep, Sound_GameOverBeep, StartBGMBeep, StopBGMBeep
ext InitSound1Opl, InitSound2Opl, SoundHandlerOpl, Sound_LooseOpl, Sound_HitOpl, Sound_StoleOpl
ext Sound_FireOpl, Sound_BonusOpl
ext Sound_StartOpl, Sound_ClearOpl, Sound_GameOverOpl, StartBGMOpl, StopBGMOpl

cseg
Dummy:
ret

InitSound1: public InitSound1
    xor ax,ax | int 10h

    mov bx,Prompt
    do
        mov al,[bx] | inc bx
        or al,al
    while nz
        push bx
            mov ah,0eh | int 10h
        pop bx
    wend

    do
        call ScanKeys_
        test al,30h
    while z | wend
    mov ah,al
    do
        call ScanKeys_
        or al,al
    while nz | wend
    test ah,20h
    if nz
        call InitSoundBeep
        mov word ptr [InitSound2+1],Dummy
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
        call InitSound1Opl
        mov word ptr [InitSound2+1],InitSound2Opl
        mov word ptr [SoundHandler+1],SoundHandlerOpl
        mov word ptr [Sound_Loose_+1],Sound_LooseOpl
        mov word ptr [Sound_Hit_+1],Sound_HitOpl
        mov word ptr [Sound_Stole_+1],Sound_StoleOpl
        mov word ptr [Sound_Fire_+1],Sound_FireOpl
        mov word ptr [Sound_Bonus_+1],Sound_BonusOpl
        mov word ptr [Sound_Start_+1],Sound_StartOpl
        mov word ptr [Sound_Clear_+1],Sound_ClearOpl
        mov word ptr [Sound_GameOver_+1],Sound_GameOverOpl
        mov word ptr [StartBGM_+1],StartBGMOpl
        mov word ptr [StopBGM_+1],StopBGMOpl
    endif
    mov bx,InitSound2
    mov ax,cs
    do
        mov byte ptr[bx+0],0eah ; jmp
        mov [bx+3],ax
        add bx,5
        cmp bx,TableEnd
    while nz | wend
ret
Prompt:
    defb 13,10,' Select Audio (SPACE:OPL2 / ALT:Beep)',0

dseg
InitSound2: public InitSound2
    defs 5
SoundHandler: public SoundHandler
    defs 5
Sound_Loose_: public Sound_Loose_
    defs 5
Sound_Hit_: public Sound_Hit_
    defs 5
Sound_Stole_: public Sound_Stole_
    defs 5
Sound_Fire_: public Sound_Fire_
    defs 5
Sound_Bonus_: public Sound_Bonus_
    defs 5
Sound_Start_: public Sound_Start_
    defs 5
Sound_Clear_: public Sound_Clear_
    defs 5
Sound_GameOver_: public Sound_GameOver_
    defs 5
StartBGM_: public StartBGM_
    defs 5
StopBGM_: public StopBGM_
    defs 5
TableEnd:
