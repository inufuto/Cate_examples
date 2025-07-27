Vram equ 8000h
VramWidth equ 80
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight

PatternSize equ CharHeight*3*2

AsciiCount equ 64
AsciiPatternRam equ 1000h
PatternRam equ AsciiPatternRam+2*CharHeight*AsciiCount
