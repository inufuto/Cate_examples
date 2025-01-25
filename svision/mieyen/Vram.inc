LcdRam equ $4000
LcdRamTop equ $4600
LcdRamBottom equ $5a00
DmaLengthValue equ (LcdRamBottom-LcdRamTop)/16

VramOrg equ $0C00
VramWidth equ 48
CharHeight equ 6
VramRowSize equ VramWidth*CharHeight
Vram equ VramOrg+2

StatusHeight equ 2
