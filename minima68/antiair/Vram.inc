VramOrg equ $f000
VramWidth equ 32
VramHeight equ 26
VramStep equ 1
VramRowSize equ VramWidth*VramStep
Vram equ VramOrg+VramRowSize*0

CharPatternRam equ $d000
CharWidth equ 4
CharHeight equ 8

SpritePatternRam equ $e000
SpriteWidth equ CharWidth*2
SpriteHeight equ CharHeight*2
SpriteAttributeRam equ $f800
MaxSpriteCount equ 32

PaletteRam equ $ff00
ColorCount equ 16

WindowWidth equ VramWidth
WindowTop equ 2
WindowHeight equ VramHeight-WindowTop-1
