Vram0 equ 9800h
Vram1 equ 9c00h
VramWidth equ 32
VramHeight equ 32
VramStep equ 1
VramRowSize equ VramWidth*VramStep

ObjSource equ 0c000h

CharRam0 equ 9000h
CharRam1 equ 8800h
SpriteRam equ 8000h
CharHeight equ 8
PlaneCount equ 2

WindowWidth equ 20+2
StatusHeight equ 2
StageTop equ 2
