VramOrg equ 3000h
LeftOrgin equ 3
TopOrgin equ 2
VramWidth equ 32
Vram equ VramOrg+LeftOrgin+TopOrgin*VramWidth

PatternRam equ 2000h
Attribute equ 3200h

CharWidth equ 8
CharHeight equ 8
CharPatternSize equ CharHeight

SpriteWidth equ 16
SpriteHeight equ 16
SpritePatternSize equ 2*SpriteHeight