CharHeight equ 8
Vram1 equ $2000
Vram2 equ $4000
VramRowStep equ $80
VramLineStep equ $400
VramBlockStep equ 40-VramRowStep*CharHeight

SpriteWidth equ 2
SpriteHeight equ CharHeight*2
