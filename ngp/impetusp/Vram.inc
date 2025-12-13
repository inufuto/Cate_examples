VramFrontOrg equ 9000h
VramBackOrg equ 9800h

VramWidth equ 32
VramStep equ 2
VramRowSize equ VramWidth*VramStep
VramFront equ VramFrontOrg+VramRowSize*0
VramBack equ VramBackOrg+VramRowSize*0

CharHeight equ 8
PatternSize equ 2*CharHeight

WindowWidth equ 20
WindowHeight equ 19

BackVramHeight equ 24
