include "Chars.inc"

Vram0 equ 9800h
Vram1 equ 9c00h
VramWidth equ 32
VramHeight equ 32
VramStep equ 1
VramRowSize equ VramWidth*VramStep

CharRam0 equ 9000h
CharRam1 equ 8800h
SpriteRam equ 8000h
ObjSource equ 0c000h

CharHeight equ 8
PlaneCount equ 2
PatternSize equ CharHeight*PlaneCount

WindowWidth equ 20
WindowHeight equ 18
StatusHeight equ 2

TerrainCharCount equ Char_Terrain1-Char_Terrain0
