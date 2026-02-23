Vram equ 3000h
Attributes equ 2000h
GVram equ 4000h

VramWidth equ 40
VramHeight equ 25
VramLeftTop equ Vram + (VramWidth - 32) / 2
GVramLeftTop equ GVram + (VramWidth - 32) / 2

CharHeight equ 8
PatternSize equ CharHeight*3

Attribute_PCG equ 20h
SpriteRam equ 2000h
