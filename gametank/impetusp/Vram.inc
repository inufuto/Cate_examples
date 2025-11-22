include "VVram.inc"

WindowHeight equ VVramHeight-1

CharWidth equ 4
CharHeight equ 4
AsciiHeight equ 6
SpriteWidth equ 8
SpriteHeight equ 8
VramOrg equ $4000
VramWidth equ 128
VramHeight equ 128
VramVisibleHeight equ CharHeight*WindowHeight
VramTopY equ (VramHeight-VramVisibleHeight)/2
Vram equ VramOrg ;+VramWidth*VramTopY

CharPageY equ VramHeight
BackgroundTop equ Vram+VramWidth*AsciiHeight*2