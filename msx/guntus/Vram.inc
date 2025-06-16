Vram_PatternGenerator equ 0000h
Vram_PatternGenerator2 equ 0800h
Vram_PatternName equ 1800h
Vram_SpriteAttribute equ 1b00h
Vram_PatternName2 equ 1c00h
Vram_Color equ 2000h
Vram_SpriteGenerator equ 3800h

VramWidth equ 32
VramHeight equ 24
CharHeight equ 8
Vram equ Vram_PatternName
SpriteSize equ 32
VramRowSize equ VramWidth

WindowWidth equ VramWidth-6
WindowHeight equ VramHeight
