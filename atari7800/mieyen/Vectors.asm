ext Startup, NmiHandler, IrqHandler

cseg
defb $ff,$87
defw NmiHandler ; NMI
defw Startup  ; RESET
defw IrqHandler ; IRQ
