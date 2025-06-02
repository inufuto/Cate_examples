VramBackO equ 1000h
VramFrontO equ 1800h

VramWidth equ 25
VramHeight equ 18
VramStep equ 2
VramRowSize equ 32*VramStep

VramX equ (28-VramWidth)/2
VramY equ (18-VramHeight)/2
VOffset equ VramY*VramRowSize+VramX*VramStep
VramBack equ VramBackO+VOffset
VramFront equ VramFrontO+VOffset

CharHeight equ 8
StatusHeight equ 2
