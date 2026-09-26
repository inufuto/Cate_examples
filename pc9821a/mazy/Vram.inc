CharWidth equ 8
CharHeight equ 8

VramOrg equ 0000h
VramWidth equ 80
VramHeight equ 28
VramRowSize equ VramWidth*CharHeight
Vram equ VramOrg+(30-VramHeight)*VramRowSize/2

SpriteWidth equ 16
SpriteHeight equ 16
