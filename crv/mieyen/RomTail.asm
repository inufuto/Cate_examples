include "Vram.inc"

ext Startup,IrqHandler

cseg
    defw Startup
    defw 0
    defw 0
    defw 0
    defb $00,$e2
    defb Vram_PatternName/$400
    defb Vram_Color/$40
    defb Vram_PatternGenerator/$800
    defb Vram_SpriteAttribute/$80
    defb Vram_SpriteGenerator/$800
    defb $04
    defw 0
    defw 0
    defw $f808
    defw IrqHandler
