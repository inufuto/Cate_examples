include "vgszero.inc"
include "Chars.inc"

VramWidth equ 32
VramStep equ 1
VramRowSize equ VramWidth*VramStep

VramBack equ BgNameTable+VramRowSize
VramFront equ FgNameTable+VramRowSize

CharPatternBank equ 2
SpritePatternBank equ 3

CharHeight equ 8
PatternSize equ CharHeight*4

TerrainCharCount equ Char_Terrain1-Char_Terrain0
