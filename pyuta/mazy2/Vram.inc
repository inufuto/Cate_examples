Vram_PatternGenerator equ >0000
Vram_PatternName equ >1800
Vram_SpriteAttribute equ >1b00
Vram_Color equ >2000
Vram_SpriteGenerator equ >3800
Vram_PatternName2 equ >1c00
Vram_PatternGenerator2 equ >0800

VramWidth equ 32
VramHeight equ 24
CharHeight equ 8
Vram equ Vram_PatternName
SpriteSize equ 32
VramRowSize equ VramWidth

Sprites equ >1b80
CellMap equ >1bbc
Man equ >1c02
Monsters equ >1c0a
Knives equ >1c6a
Points equ >1c82
