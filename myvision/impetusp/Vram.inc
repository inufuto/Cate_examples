include "Chars.inc"

Vram_PatternGenerator equ 0000h
Vram_PatternName0 equ 1800h
Vram_PatternName1 equ 1c00h
Vram_SpriteAttribute equ 1b00h
Vram_Color equ 2000h
Vram_SpriteGenerator equ 3800h

VramWidth equ 32
VramHeight equ 24
CharHeight equ 8
Vram equ Vram_PatternName0
SpriteSize equ 32
VramRowSize equ VramWidth

StatusHeight equ 2
WindowHeight equ VramHeight-StatusHeight

TerrainCharCount equ Char_Terrain1-Char_Terrain0
