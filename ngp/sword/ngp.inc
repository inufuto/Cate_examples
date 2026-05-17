Sound_Enable equ 0b8h
Z80_Enable equ 0b9h
Z80_Nmi equ 0bah

ControllerStatus equ 6f82h
Version equ 6f91h
VerticalBlankingInterrupt equ 6fcch

SoundRam equ 7000h

WBA.H equ 8002h ; Window Horizontal Origin
WBA.V equ 8003h ; Window Vertical Origin
WSI.H equ 8004h ; Window X Size
WSI.V equ 8005h ; Window Y Size
PO.H equ 8020h ; Position Offset Horizontal
PO.V equ 8020h ; Position Offset Vertical
S1SO.H equ 8032h ; Scroll Plane 1 X Scroll Offset
S1SO.V equ 8033h ; Scroll Plane 1 Y Scroll Offset
S2SO.H equ 8034h ; Scroll Plane 2 X Scroll Offset
S2SO.V equ 8035h ; Scroll Plane 2 Y Scroll Offset

MonoPalette equ 8100h
ColorPalette equ 8200h
BackgroundColorPalette equ 83e0h

ModeSelectionRegister equ 87e2h
