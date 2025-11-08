include "Chars.inc"

Vram_PatternGenerator equ 0000h
Vram_PatternName0 equ 1800h
Vram_PatternName1 equ 3800h
Vram_SpriteAttribute equ 3f00h

Vram equ Vram_PatternName0
VramWidth equ 32
VramHeight equ 24
VramStep equ 2
VramRowSize equ VramWidth*VramStep
CharHeight equ 8
PlaneCount equ 4
PatternSize equ CharHeight*PlaneCount

TerrainCharCount equ Char_Terrain1-Char_Terrain0
