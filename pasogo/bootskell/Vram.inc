VramSegment equ 0b800h
VramOrg equ 0000h
VramWidth equ 80
VramHeight equ 25
VramStep equ 1
CharHeight equ 8
Vram equ VramOrg+VramWidth*5
VramRowSize equ VramWidth*2
