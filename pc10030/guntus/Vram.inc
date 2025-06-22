VramSegment0 equ 0c000h
VramSegment1 equ 0d000h
VramOrg equ 0000h
VramWidth equ 128
VramHeight equ 32
CharHeight equ 8
VramStep equ 2
VramRowSize equ VramWidth*CharHeight*2
Vram equ VramOrg+VramWidth*56+5
PlaneCount equ 4

WindowWidth equ 32
WindowHeight equ 25
