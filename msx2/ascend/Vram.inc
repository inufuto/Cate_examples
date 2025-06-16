Vram_PatternGenerator equ 0000h
Vram_Color equ 2000h
Vram_PatternName0 equ 4000h
Vram_PatternName1 equ 4400h
Vram_SpriteColor equ 5c00h
Vram_SpriteAttribute equ 5e00h
Vram_SpriteGenerator equ 7800h

VramWidth equ 32
VramHeight equ 24+1
CharHeight equ 8
Vram equ Vram_PatternName0
SpriteSize equ 32
VramRowSize equ VramWidth

VramTop equ Vram+VramRowSize*2
WindowHeight equ VramHeight-2
