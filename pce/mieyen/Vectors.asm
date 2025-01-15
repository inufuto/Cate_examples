ext Startup, VHandler, THandler

cseg
Return:
rti

defw Return ; IRQ2
defw VHandler ; IRQ1
defw THandler ; TIRQ
defw Return ; NMI
defw Startup  ; RESET