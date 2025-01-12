VramOrg equ $5800
VramWidth equ 40
VramHeight equ 25
CharHeight equ 8
VramStep equ CharHeight
VramRowSize equ VramWidth*VramStep
Vram equ VramOrg+VramRowSize*3
