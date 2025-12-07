WindowWidth equ 24
WindowHeight equ 17
FrontHeight equ 2
BackHeight equ 24

VramStep equ 3
VramWidth equ 1+VramStep*WindowWidth+1
CharHeight equ 6
VramRowSize equ VramWidth*CharHeight
VramTop equ 0
VramLeft equ 8

HOffset equ 0
VOffset equ 0

Page1 equ $dc00
Page0 equ $bc00
VramFrontOrg equ $b800
VramBackOrg equ $8e00

VramBack equ VramBackOrg+1
VramFront equ VramFrontOrg+1
