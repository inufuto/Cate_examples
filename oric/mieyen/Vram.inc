VramWidth equ 40
VramHeight equ 28
VramStep equ VramWidth/40
VramRowSize equ VramWidth*VramStep;

CharHeight equ 8
PatternSize equ CharHeight

PatternRam equ $b400
VramBase equ $bb80
Vram equ VramBase+VramRowSize

Color_Black equ 0
Color_Red equ 1
Color_Green equ 2
Color_Yellow equ 3
Color_Blue equ 4
Color_Magenta equ 5
Color_Cyan equ 6
Color_White equ 7
