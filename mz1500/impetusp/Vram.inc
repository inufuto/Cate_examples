Vram equ 0d400h

VramWidth equ 40
VramHeight equ 25
VramRowSize equ VramWidth

TextVram equ 0d000h
Attributes equ 0d800h
HighVram equ 0dc00h

CharHeight equ 8
PlaneCount equ 3
PatternSize equ CharHeight*PlaneCount
PatternRam equ 0d000h
