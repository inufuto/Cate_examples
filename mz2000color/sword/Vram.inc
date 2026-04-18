Vram equ 0c000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight

VramStep equ 2
PlaneCount equ 3
PatternSize equ CharHeight*VramStep*PlaneCount
