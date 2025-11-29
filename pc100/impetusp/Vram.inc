include "VVram.inc"

VramSegment0 equ 0c000h
VramSegment1 equ 0d000h
VramOrg equ 0000h
VramWidth equ 128
VramHeight equ 32
CharHeight equ 8
VramStep equ 2
VramRowSize equ VramWidth*CharHeight*2
VramLeft equ (90-80)/2
VramTop equ (VramHeight-VVramHeight)/2
Vram equ VramOrg+VramRowSize*VramTop+VramLeft