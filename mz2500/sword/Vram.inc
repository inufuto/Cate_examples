Vram0 equ 0e000h
Vram1 equ 0e400h
VramWidth equ 40
VramHeight equ 25
VramStep equ 1
CharHeight equ 8
VramRowSize equ VramWidth*VramStep
PlaneCount equ 3

CRTPort equ 0f4h    
GraphPort equ 0bch

PCGAddress equ 0c000h
