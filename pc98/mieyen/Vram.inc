VramSegment equ 0a800h
Vram0 equ 0000h
Vram1 equ Vram0+80*200
VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramStep equ VramWidth/40
VramRowSize equ VramWidth*CharHeight
PlaneCount equ 3
