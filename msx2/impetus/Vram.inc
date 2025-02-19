CharHeight equ 8
VramStep equ 4
VramWidth equ 32*VramStep
VramHeight equ 24
VramRowSize equ VramWidth*CharHeight

CharSourceY equ 192
CharVram equ CharSourceY*128
SpriteSourceY equ 192
SpriteVram equ 8000h+SpriteSourceY*128

StatusHeight equ 2