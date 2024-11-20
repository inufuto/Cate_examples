include "InternalRam.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext CellMap_,LeftX_


; word VVramOffset(byte x, byte y);
cseg
VVramOffset_: public VVramOffset_
    push
    exab|push|exab
        push
            exab
            lp RegisterX | exam | ldm
            rc|sl ;*2
            adm|ldm ;*3
            lib 0
            rc|sl| exab | sl | exab ;*6
            rc|sl| exab | sl | exab ;*12
            rc|sl| exab | sl | exab ;*24
            exam
            exab | lp RegisterX+1 | exam
        pop
        lib 0
        lp RegisterX | adb
    exab|pop|exab
    pop
rtn


; void VVramBackToFront();
cseg
VVramBackToFront_: public VVramBackToFront_
    push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lia low (VVramBack_-1) | lp RegisterX|exam|push
    lia high (VVramBack_-1) | lp RegisterX+1|exam|push
    lia low (VVramFront_-1) | lp RegisterY|exam|push
    lia high (VVramFront_-1) | lp RegisterY+1|exam|push
        lii VVramHeight
        do
            lij VVramWidth
            do
                ixl | iys
                decj
            while nz|wend
            deci
        while nz|wend
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop
rtn


StageTop equ 2
ColumnCount equ 12*8
FloorCount equ 3
FloorHeight equ 4
CellWidth equ 2
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte

Char_Space equ 00h
Char_Floor equ 05h
Char_Needle equ 0eh
Char_Item0 equ 0ch
Char_Item1 equ 0fh
Char_Item2 equ 0ch
Char_Item3 equ 00h

cseg
CellChars:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor,Char_Floor
	; 2
	defb Char_Space,Char_Space
	defb Char_Item0,Char_Item1
	defb Char_Item2,Char_Item3
	defb Char_Floor,Char_Floor
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle,Char_Needle
	defb Char_Floor,Char_Floor

; void MapToVVram();
MapToVVram_: public MapToVVram_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lia 0 | lp RegisterK|exam|push|exam
    lp RegisterL|ldm|push
    lp RegisterM|ldm|push
    lp RegisterN|ldm|push
    lp RegisterX|ldm|push
        lia low(CellMap_-1) | exam
    lp RegisterX+1|ldm|push
        lia high(CellMap_-1) | exam
    lp RegisterY|ldm|push
        lia low(VVramBack_+VVramWidth*StageTop-1) | exam
    lp RegisterY+1|ldm|push
        lia high(VVramBack_+VVramWidth*StageTop-1) | exam

        lidp LeftX_ | ldd
        tsia 1
        if nz
                                                    _deb: public _deb
            deck ; xPos
            dy
        endif
        rc|sr
        lp RegisterL|exam|ldm
        anim 3 ; xMod
        rc|sr
        rc|sr
        lib 0
        lp RegisterX | adb

        lia FloorCount | lp RegisterM | exam
        do
            lp RegisterK|ldm|push
            lp RegisterL|ldm|push
                ixl
                exab
                    lp RegisterL | ldm
                    cpia 0
                exab
                do | while nz
                    rc|sr
                    rc|sr
                    decb
                wend

                exab
                    lia VVramWidth/2+1 | lp RegisterN | exam
                exab
                do
                    push
                    lp RegisterX|exam|push| lia low(CellChars-1) |exam
                    lp RegisterX+1|exam|push| lia high(CellChars-1) |exam
                        ania 3
                        sl | sl | sl ;*8
                        lib 0
                        lp RegisterX | adb

                        lii 4
                        do
                            lij 2
                            do
                                lp RegisterK | cpim VVramWidth
                                if c
                                    ixl
                                    iys
                                else
                                    ix
                                    iy
                                endif
                                inck ; xPos
                                decj
                            while nz|wend
                            deck | deck
                            lia low(VVramWidth-2) | lib high(VVramWidth-2)
                            lp RegisterY | adb

                            deci
                        while nz|wend
                        inck | inck
                        lia low(-VVramWidth*FloorHeight+2) | lib high(-VVramWidth*FloorHeight+2)
                        lp RegisterY | adb
                    
                    lp RegisterX+1|pop|exam
                    lp RegisterX|pop|exam
                    pop

                    rc|sr
                    rc|sr

                    incl ; xMod
                    lp RegisterL | anim 3
                    if z
                        ixl
                    endif

                    decn
                while nz|wend
                lia low(-VVramWidth-2+VVramWidth*FloorHeight)
                lib high(-VVramWidth-2+VVramWidth*FloorHeight)
                lp RegisterY | adb

                lp RegisterL | cpim 0
                if z
                    dx
                endif
                lia low(MapWidth-(VVramWidth/2+1)/ColumnsPerByte-1)
                lib high(MapWidth-(VVramWidth/2+1)/ColumnsPerByte-1)
                lp RegisterX | adb
            lp RegisterL | pop|exam
            lp RegisterK | pop|exam

            decm
        while nz|wend
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterN|pop|exam
    lp RegisterM|pop|exam
    lp RegisterL|pop|exam
    lp RegisterK|pop|exam
    lp RegisterJ|pop|exam
    lp RegisterI|pop|exam
    pop|exab
    pop
rtn
