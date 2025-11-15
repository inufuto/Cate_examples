include "Chars.inc"

Vram0 equ $0000
Vram1 equ $0400
CharPatternRam equ $1000
SpritePatternRam equ $2000
CharHeight equ 8
PlaneCount equ 4

VramWidth equ 32
VramHeight equ 26
VramStep equ 1
VramRowSize equ VramWidth*VramStep

CharPatternSize equ CharHeight*PlaneCount

TerrainCharCount equ Char_Terrain1-Char_Terrain0
