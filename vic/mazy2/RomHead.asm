cseg
    defw RomStart
    defw RomStart
    defb 'A0'
    defb $C3,$C2,$CD ; CBM
RomStart: public RomStart
    jsr $FD8D
    jsr $FD52
    jsr $FDF9
    jsr $E518
    cli