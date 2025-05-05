VramBack equ 8000h
VramFront equ 0a000h

VramWidth equ 40
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight
Offscreen equ VramBack+8000

PlaneCount equ 3
PatternSize equ CharHeight*PlaneCount
PatternRam equ 4000h
