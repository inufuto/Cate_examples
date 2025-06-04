VramWidth equ 80
VramStep equ 3
CharHeight equ 6
VramRowSize equ VramWidth*CharHeight
VramLeft equ 8
VramTop equ 3

BackgroundOrg equ $9900
Page0Org equ $b800
Page1Org equ $dc00
Background equ BackgroundOrg+1
BackgroundHeight equ 16
Vram equ Background

StatusHeight equ 2
WindowWidth equ 23
WindowHeight equ 14
