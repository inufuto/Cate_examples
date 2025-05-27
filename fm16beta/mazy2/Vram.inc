SubSysSegment equ 0c000h

VramWidth equ 80
VramHeight equ 25
CharHeight equ 8
VramStep equ VramWidth/40
VramRowSize equ VramWidth*CharHeight
PlaneCount equ 3
Vram0 equ 0000h
Vram1 equ 3e80h
