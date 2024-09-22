include "mz2000.inc"
include "Vram.inc"

; void PlotMarker(word vram, word bytes);
PlotMarker_: public PlotMarker_
    push af | push hl | push de | push bc
        ld a,2
        di
            do
                out (AccessPlane),a
                ex af,af'
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
                ex af,af'
                inc a
                cp 4
            while nz | wend
            xor a
            out (AccessPlane),a
        ei
    pop bc | pop de | pop hl | pop af
ret
