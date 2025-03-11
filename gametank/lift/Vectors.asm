ext Startup, NmiHandler, IrqHandler

cseg
defw NmiHandler ; NMI
defw Startup  ; RESET
defw IrqHandler ; IRQ
