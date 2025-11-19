Vram0 equ 4000h
Vram1 equ 4800h
Vram2 equ 5000h
VramWidth equ 32
CharHeight equ 8
VramRowSize equ VramWidth
Vram equ 0

ColorMap equ 5800h

VramStep equ 1
PatternSize equ CharHeight*VramStep
SpritePatternSize equ CharHeight*2*4
