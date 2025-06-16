Vram_PatternGenerator equ 0000h
Vram_PatternName equ 1800h
Vram_Color equ 2000h
Vram_SpriteGenerator equ 3800h
Vram_SpriteAttribute equ 1b00h

Vram equ Vram_PatternName
VramWidth equ 32
VramHeight equ 24
VramStep equ 1
CharHeight equ 8
VramRowSize equ VramWidth*VramStep
SpriteSize equ 32

VramTopLeft equ Vram
VVramWidth equ VramWidth
VVramHeight equ VramHeight
