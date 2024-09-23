include "mz2000.inc"
include "Vram.inc"

; void PlotMarker(word vram, word bytes);
PlotMarker_: public PlotMarker_
    push af | push hl | push de | push bc
        ld bc,VramWidth
        exx
            ld b,2
        exx
        do
            ld a,e
            xor (hl) 
            ld (hl),a
            inc hl
            ld a,d
            xor (hl) 
            ld (hl),a
            dec hl
            add hl,bc
            exx
                dec b
            exx
        while nz | wend
        ld bc,-VramWidth*2
        add hl,bc
    pop bc | pop de | pop hl | pop af
ret
