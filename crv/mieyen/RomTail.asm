include "Vram.inc"

ext Startup,IrqHandler

cseg
    defw Startup
    defw 0
    defw 0
    defw 0
    defb $02,$e2,$06,$ff,$03,$36,$07,$04
    defw 0
    defw 0
    defw $f808
    defw IrqHandler
