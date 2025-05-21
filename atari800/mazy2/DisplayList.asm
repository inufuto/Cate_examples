include "Vram.inc"

DLI equ Mode or $80

DisplayList: public DisplayList
    defb $70,$70,$70,$80
    defb $40 or Mode | defw Vram
    defb DLI,Mode,DLI,Mode,DLI,Mode,DLI,Mode
    defb DLI,Mode,DLI,Mode,DLI,Mode,DLI,Mode
    defb DLI,Mode,DLI,Mode,DLI,Mode,DLI,$80
    defb $41 | defw DisplayList
