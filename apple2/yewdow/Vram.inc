CharHeight equ 8
Vram0 equ $2000
Vram1 equ Vram0+40
Vram2 equ Vram1+40
VramRowStep equ $80
VramLineStep equ $400
VramBlockStep equ 40-VramRowStep*CharHeight
