CharHeight equ 8
PlaneCount equ 4
PatternSegment equ 1060h

VramSegment equ 0c000h
VramOrg equ 0000h
VramWidth equ 70
VramStep equ 2
RowHeight equ CharHeight*4
VramRowSize equ VramWidth*RowHeight
VramLeftX equ (VramWidth-32*VramStep)/2
VramTopY equ (750-RowHeight*23)/2
Vram equ VramOrg+VramWidth*VramTopY+VramLeftX
