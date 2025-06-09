VramFrontOrg equ 9000h
VramBackOrg equ 9800h

VramWidth equ 32
VramStep equ 2
VramRowSize equ VramWidth*VramStep
VramFront equ VramFrontOrg+VramRowSize*0
VramBack equ VramBackOrg+VramRowSize*0
