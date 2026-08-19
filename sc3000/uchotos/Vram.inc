Vram_PatternGenerator equ 0000h or 4000h
Vram_PatternName equ 1800h or 4000h
Vram_SpriteAttribute equ 1b00h or 4000h
Vram_Color equ 2000h or 4000h
Vram_SpriteGenerator equ 3800h or 4000h

VramWidth equ 32
VramHeight equ 24
CharHeight equ 8
Vram equ Vram_PatternName
VramRowSize equ VramWidth

StatusHeight equ 2
WindowHeight equ VramHeight-StatusHeight