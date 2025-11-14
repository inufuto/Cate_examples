VicRam equ $8000
Vram equ VicRam+$400 ; ~$07ff
VramWidth equ 40
VramHeight equ 25
CharHeight equ 8
VramStep equ 1
VramRowSize equ VramWidth*VramStep

PatternRam equ VicRam+$800; ~$0fff
ColorMap equ $d800

SpriteSize equ 64
