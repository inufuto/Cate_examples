include "VVram.inc"

CharWidth equ 4
CharHeight equ 4
AsciiHeight equ 6
SpriteWidth equ 8
SpriteHeight equ 8
VramOrg equ $4000
VramWidth equ 128
VramHeight equ 128
VramVisibleHeight equ CharHeight*VVramHeight
VramTopY equ (VramHeight-VramVisibleHeight)/2
Vram equ VramOrg+VramWidth*VramTopY

CharPageY equ VramHeight
VramTop equ Vram