VramBank equ $e1
Vram equ $2000
VramBankLong equ VramBank*$10000

VramWidth equ 160
VramStep equ 4
CharHeight equ 8
VramRowSize equ VramWidth*CharHeight
VramHeigth equ 25