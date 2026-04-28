ShareRam equ $FC80
SubShareRam equ $9f80

Share_Command equ 0
Share_Address equ 1
Share_Char equ 3
Share_Pattern equ 4

SubCommand_None equ 0
SubCommand_Clear equ 1
SubCommand_DrawChar1 equ 2
SubCommand_DrawChar2 equ 3
SubCommand_DrawSprite equ 4
SubCommand_SwitchPage equ 5
SubCommand_DefChar equ 6
SubCommand_DefSprite equ 7
