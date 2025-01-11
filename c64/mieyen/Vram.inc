VicRam equ $8000
Vram equ VicRam+$2000
VramWidth equ 40
VramHeight equ 25
CharHeight equ 8
VramStep equ CharHeight
VramRowSize equ VramWidth*VramStep

TextMap equ VicRam+$0400
ColorMap equ $d800

SpriteSize equ 64
SpritePatternRam0 equ VicRam+SpriteSize*0
SpritePatternRam1 equ VicRam+SpriteSize*32
