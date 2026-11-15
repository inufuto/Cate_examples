ActualVram equ 0c000h

VramA equ ActualVram*2
VramWidth equ 32
CharHeight equ 4
AsciiHeight equ 6
VramRowSize equ VramWidth*CharHeight

ActualVramWidth equ VramWidth/2
