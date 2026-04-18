Vram equ 8000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight
VramStep equ VramWidth/40

PlaneCount equ 3
PatternSize equ CharHeight*VramStep*PlaneCount
