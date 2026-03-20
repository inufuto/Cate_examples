cseg

; byte ScanKeys();
cseg
ScanKeys_: public ScanKeys_
    ldaa $ff81 ; consume
    ldaa $ff80
rts
