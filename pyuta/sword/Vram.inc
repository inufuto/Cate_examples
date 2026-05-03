Vram_PatternGenerator equ >0000
Vram_PatternName equ >1800
Vram_SpriteAttribute equ >1b00
Vram_Color equ >2000
Vram_SpriteGenerator equ >3800

VramWidth equ 32
VramHeight equ 24
CharHeight equ 8
Vram equ Vram_PatternName
SpriteSize equ 32
VramRowSize equ VramWidth

StatusHeight equ 2

Sprites equ >1b80
Balls equ >1bbc
Man equ >1bd4
Sword equ >1bdb
Monsters equ >1bde
Points equ >1c02
OneUp equ >1c12
StageMap equ >1c15
