include "VVram.inc"

ext VVram_
ext CellMap_
ext LineRed_

MapWidth equ VVramWidth/2
MapHeight equ VVramHeight/2

Cell_Wall equ &h10
Cell_Item equ &h20
Cell_Mask equ &hf0

Char_Space equ &h00
Char_Block equ &hf0

Char_Line equ 1
Char_Line_Normal equ 1
Char_Line_RightBottom equ 1
Char_Line_LeftBottom equ 2
Char_Line_RightTop equ 3
Char_Line_LeftTop equ 4
Char_Line_Left equ 5
Char_Line_Right equ 6
Char_Line_Top equ 7
Char_Line_Bottom equ 8
Char_Line_Red equ 9


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


; ptr<byte> CellMapPtr(byte x, byte y);
cseg
CellMapPtr_: public	CellMapPtr_
    phsw $13
        ld $10,$1
        biu $10 ;*2
        ad $10,$1 ;*3
        ld $11,$sx
        biuw $10 ;*6
        biuw $10 ;*12
        ld $12,$0
        ld $13,$sx
        adw $10,$12
        ldw $12,CellMap_
        adw $10,$12
    ppsw $12
rtn


; void MapToVVram();
cseg
LineBytes:
	defb	&h60, &h40, &h20, &h60, &h40, &h20, &h20, &h40
	defb	&h70, &hd0, &hb0, &he0, &hc0, &h30, &ha0, &h50
ItemBytes:
    defb	&h60, &h90, &h90, &h60
LineChars:
    defb Char_Space, Char_Space, Char_Space, Char_Space ; none
    defb Char_Line_Bottom, Char_Space, Char_Line_Top, Char_Space ; left
    defb Char_Space, Char_Line_Bottom, Char_Space, Char_Line_Top ; right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_Top, Char_Line_Top ; left right
    defb Char_Line_Right, Char_Line_Left, Char_Space, Char_Space ; top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_Top, Char_Space ; top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Space, Char_Line_Top ; top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_Top, Char_Line_Top ; top left right
    defb Char_Space, Char_Space, Char_Line_Right, Char_Line_Left ; bottom
    defb Char_Line_Bottom, Char_Space, Char_Line_RightTop, Char_Line_Left ; bottom left
    defb Char_Space, Char_Line_Bottom, Char_Line_Right, Char_Line_LeftTop ; bottom right
    defb Char_Line_Bottom, Char_Line_Bottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom left right
    defb Char_Line_Right, Char_Line_Left, Char_Line_Right, Char_Line_Left ; bottom top
    defb Char_Line_RightBottom, Char_Line_Left, Char_Line_RightTop, Char_Line_Left ; bottom top left
    defb Char_Line_Right, Char_Line_LeftBottom, Char_Line_Right, Char_Line_LeftTop ; bottom top right
    defb Char_Line_RightBottom, Char_Line_LeftBottom, Char_Line_RightTop, Char_Line_LeftTop ; bottom top left right
MapToVVram_: public MapToVVram_
    phsm $5,6
    phsm $15,6
        pre ix,LineRed_ | ld $1,(ix+$sx)

        ldw $12,VVram_
        pre ix,CellMap_
        ld $2,MapHeight
        do
            ld $3,MapWidth
            do
                ldi $0,(ix+$sx)
                sbc $0,Cell_Wall
                if z
                    ld $0,Char_Block
                    ld $4,2
                    do
                        ld $5,2
                        do
                            st $0,($12)
                            adw $12,$30
                            sb $5,$sy
                        while nz | wend
                        ldw $10,VVramWidth-2 | adw $12,$10
                        sb $4,$sy
                    while nz | wend
                    jr nextCell
                endif
                sbc $0,Cell_Item
                if z
                    pre iz,ItemBytes
                    ld $4,2
                    do
                        ld $5,2
                        do
                            ldi $0,(iz+$sx)
                            st $0,($12)
                            adw $12,$30
                            sb $5,$sy
                        while nz | wend
                        ldw $10,VVramWidth-2 | adw $12,$10
                        sb $4,$sy
                    while nz | wend
                    jr nextCell
                endif
                an $0,&h0f
                ld $14,$0
                biu $14 | biu $14
                ld $15,$sx
                ldw $10,LineChars | adw $14,$10
                pre iz,$14
                ld $4,2
                do
                    ld $5,2
                    do
                        ldi $0,(iz+$sx)
                        sbc $0,$sx
                        if nz
                                                _deb: public _deb
                            sbc $1,$sx
                            if nz
                                ad $0,Char_Line_Red-Char_Line_Normal
                            endif
                            ld $14,$0
                            ld $15,$sx
                            ldw $10,LineBytes-1 | adw $14,$10
                            ld $0,($14)
                        endif
                        st $0,($12)
                        adw $12,$30
                        sb $5,$sy
                    while nz | wend
                    ldw $10,VVramWidth-2 | adw $12,$10
                    sb $4,$sy
                while nz | wend
                nextCell:
                ldw $10,VVramWidth*2-2 | sbw $12,$10
                sb $3,$sy
            while nz | wend
            ldw $10,VVramWidth | adw $12,$10
            sb $2,$sy
        while nz | wend
    ppsm $10,6
    ppsm $0,6
rtn
