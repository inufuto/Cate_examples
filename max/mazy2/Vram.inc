VicRam equ $0000
Vram equ VicRam+$400 ; ~$07ff
VramWidth equ 40
VramHeight equ 25
CharHeight equ 8
VramRowSize equ VramWidth
ColorMap equ $d800

WindowWidth    equ 32
WindowHeight    equ 24-2

StageTop equ 1
VramTop equ Vram+VramRowSize*StageTop
ColorMapTop equ ColorMap+VramRowSize*StageTop

Color_Space equ 1
