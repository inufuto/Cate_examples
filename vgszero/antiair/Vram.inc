TileBank equ 1
SpriteBank equ 2

CharWidth equ 8
CharHeight equ 8

VramWidth equ 32
VramStep equ 1
VramRowSize equ VramWidth*VramStep
VramBack equ BgNameTable+VramRowSize+VramStep
VramFront equ FgNameTable+VramRowSize+VramStep
VramHeight equ 24
