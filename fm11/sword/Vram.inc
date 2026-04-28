Vram equ $0000

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramStep equ VramWidth/40
VramRowSize equ VramWidth*CharHeight

PlaneCount equ 3
CharPatternSize equ CharHeight*VramStep*PlaneCount
SpritePatternSize equ CharHeight*VramStep*(1+PlaneCount)*4