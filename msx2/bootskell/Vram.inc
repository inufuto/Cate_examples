Vram_PatternName equ 0000h
Vram_SpriteColor equ 7400h
Vram_SpriteAttribute equ 7600h
Vram_SpriteGenerator equ 7800h
Vram_Pattern equ 6000h

Vram equ Vram_PatternName
CharHeight equ 8
VramStep equ 4
VramWidth equ 32*VramStep
VramHeight equ 24
VramRowSize equ VramWidth*CharHeight
