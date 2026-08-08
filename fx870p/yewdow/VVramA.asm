include "VVram.inc"

ext CellMap_
ext VVram_

MapWidth equ 12
MapHeight equ 7
MapWidthPerByte equ 8/4

Cell_Wall equ &h1
Cell_Rock equ &h2
Cell_Arrow equ &h4
Cell_NullArrow equ &hc


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public	VVramPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        biuw $10 ;*24
        ld $12,$0
        ld $13,$sx
        adw $10,$12
        ldw $12,VVram_
        adw $10,$12
    ppsw $12
rtn


; void MapToVVram();
cseg
WallChars:
    defb &he0, &hb0, &hd0, &h70
RockChars:
    defb &h10, &hc0, &hf0, &hf0
ArrowChars:
	defb &h60, &h80, &h20, &h80, &ha0, &h40, &ha0, &h00
	defb &h60, &h40, &h80, &h80, &hc0, &hc0, &h20, &h00
MapToVVram_: public MapToVVram_
    phsm $6,7
    phsm $17,8
        ldw $10,CellMap_
        ldw $12,VVram_
        ld $2,MapHeight
        do
            ld $3,MapWidth/MapWidthPerByte
            do
                ld $1,($10) | adw $10,$sy
                ld $4,MapWidthPerByte
                do
                    ld $0,$1
                    an $0,&h0f
                    sbc $0,Cell_Wall
                    if z
                        ldw $14,WallChars
                        jr vput2
                    endif
                    sbc $0,Cell_Rock
                    if z
                        ldw $14,RockChars
                        jr vput2
                    endif
                    an $0,&h0c
                    sbc $0,Cell_Arrow
                    if z
                        ld $16,$1
                        an $16,3
                        ad $16,$16 | ad $16,$16
                        ld $17,$sx
                        ldw $14,ArrowChars
                        adw $14,$16
                        vput2:
                        ldw $16,VVramWidth-2
                        ld $5,2
                        do
                            ld $6,2
                            do
                                ld $0,($14) | adw $14,$sy
                                st $0,($12) | adw $12,$sy
                                sb $6,$sy
                            while nz | wend
                            adw $12,$16
                            sb $5,$sy
                        while nz | wend
                        jr next
                    endif
                    ld $0,$sx
                    ldw $16,VVramWidth-2
                    ld $5,2
                    do
                        ld $6,2
                        do
                            st $0,($12) | adw $12,$sy
                            sb $6,$sy
                        while nz | wend
                        adw $12,$16
                        sb $5,$sy
                    while nz | wend
                    next:
                    ldw $16,2-VVramWidth*2 | adw $12,$16

                    bid $1 | bid $1 | bid $1 | bid $1
                    sb $4,$sy
                while nz | wend
                sb $3,$sy
            while nz | wend
            ldw $16,VVramWidth | adw $12,$16
            sb $2,$sy
        while nz | wend
    ppsm $10,8
    ppsm $0,7
rtn














