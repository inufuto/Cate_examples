MainShareRam equ 0f800h
SubShareRam equ 2000h

CharHeight equ 8
PlaneCount equ 3
PatternSize equ 2*CharHeight*PlaneCount

Share_Command equ 0
Share_Address equ 1
Share_Char equ 3
Share_SoundId equ Share_Char
Share_Pattern equ 4

Share_KeyCode equ Share_Pattern + 2*CharHeight*PlaneCount
Share_JoystickValue equ Share_KeyCode + 1
Share_TimerCount equ Share_JoystickValue + 1
Share_Playing equ Share_TimerCount + 1

SubCommand_Nop equ 1
SubCommand_Clear equ 2
SubCommand_DefChar equ 3
SubCommand_DrawChar1 equ 4
SubCommand_DrawChar2 equ 5
SubCommand_ResetTimerCount equ 6
SubCommand_Play equ 7

Keys_Left equ 01h
Keys_Right equ 02h
Keys_Up equ 04h
Keys_Down equ 08h
Keys_Dir equ 0fh
Keys_Button0 equ 10h
Keys_Button1 equ 20h

SoundId_Loose equ 0
SoundId_Hit equ 1
SoundId_Beep equ 2
SoundId_Up equ 3
SoundId_Start equ 4
SoundId_Clear equ 5
SoundId_GameOver equ 6
SoundId_StartBGM equ 7
SoundId_StopBGM equ 8