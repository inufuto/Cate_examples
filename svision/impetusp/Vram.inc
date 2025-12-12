VramOrg equ $4000
VramWidth equ 48
VramStep equ 2
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight
Vram equ VramOrg+VramRowSize*0
