Vram0 equ 0000h
Vram1 equ 1000h

VramWidth equ 40
VramHeight equ 25
VramStep equ 4
VramRowSize equ VramWidth*VramStep

CharHeight equ 8
TPlaneCount equ 3
GPlaneCount equ 4

PcgSegment equ 0f100h
TVramSegment equ 0f400h
GVramSegment equ 0c000h

CrtPort equ 170h
GraphPort equ 178h
GraphPort2 equ 270h
