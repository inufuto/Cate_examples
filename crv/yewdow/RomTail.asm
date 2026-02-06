include "Vram.inc"

ext Startup,IrqHandler

cseg
    defw Startup
    defw 0
    defw 0
    defw 0
    defb $00,$e2,$06,$80,$00,$36,$07,$00
    defw 0
    defw 0
    defw $f808
    defw IrqHandler
