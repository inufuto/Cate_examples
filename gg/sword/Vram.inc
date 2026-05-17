Vram_PatternGenerator equ 0000h
Vram_PatternName equ 3800h
Vram_SpriteAttribute equ 3f00h

VramWidth equ 32
VramHeight equ 24
VramStep equ 2
VramRowSize equ VramWidth*VramStep
Vram equ Vram_PatternName+VramRowSize
CharHeight equ 8
PlaneCount equ 4

StatusHeight equ 2
