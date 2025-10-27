Vram equ 0c000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramStep equ 2
VramRowSize equ VramWidth*CharHeight
PlaneCount equ 3

PatternSize equ VramStep*CharHeight*PlaneCount
