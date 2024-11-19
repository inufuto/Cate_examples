include "InternalRam.inc"
include "Vram.inc"
include "VVram.inc"

ext VVramBack_, VVramFront_
ext VVramOffset_

Sprite_End equ 23

Sprite_x equ 0
Sprite_y equ 1
Sprite_oldX equ 2
Sprite_oldY equ 3
Sprite_chars equ 4
UnitSize equ 8

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

InvalidY equ 0ffh

dseg
Sprites_: public Sprites_
    defs Sprite_End*UnitSize


; void HideAllSprites()
cseg
HideAllSprites_: public HideAllSprites_
    push
    lp RegisterI|ldm|push
        lidp Sprites_
        lia InvalidY
        lii Sprite_End*UnitSize
        fild
    lp RegisterI|pop|exam
    pop
rtn


cseg
ToSprite:
    exab
        lia low (Sprites_-1) | lp RegisterY | exam
        lia high (Sprites_-1) | lp RegisterY+1 | exam
    exab
    lib 0
    rc|sl|exab|sl|exab ;*2
    rc|sl|exab|sl|exab ;*4
    rc|sl|exab|sl|exab ;*8
    lii 2-1
    lp RegisterY
    adb
rtn

; void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
cseg
ShowSprite_: public ShowSprite_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterX|ldm|push
    lp RegisterX+1|ldm|push
    lp RegisterY|ldm|push
    lp RegisterY+1|ldm|push
    lp Word0|ldm|push
    lp Word0+1|ldm|push
        lp Word0|liq RegisterY
        lii 2-1|mvw

        ix|ixl ; index
        call ToSprite
        dx|dx|dx
        ixl|iys ; x
        ixl|iys ; y
        iy ; oldX
        iy ; oldX

        liq Word0|lp RegisterX
        lii 2-1|mvw
        dx
        ixl|iys ; pChars[0]
        ixl|iys ; pChars[1]
        ixl|iys ; pChars[2]
        ixl|iys ; pChars[3]
    lp Word0+1|pop|exam
    lp Word0|pop|exam
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    lp RegisterX+1|pop|exam
    lp RegisterX|pop|exam
    lp RegisterI|pop|exam
    pop|exab
    pop
rtn


; void HideSprite(byte index) 
cseg
HideSprite_: public HideSprite_
    push
    exab|push|exab
    lp RegisterY|exam|push|exam
    lp RegisterY+1|exam|push|exam
        call ToSprite
        iy
        lia InvalidY | iys
    lp RegisterY+1|pop|exam
    lp RegisterY|pop|exam
    pop|exab
    pop
rtn


; void DrawSprites()
cseg
DrawSprites_: public DrawSprites_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lp RegisterK|ldm|push
    lp RegisterL|ldm|push
    lp RegisterM|ldm|push
    lp RegisterN|ldm|push
    lp RegisterX|ldm|push
    lp RegisterX+1|ldm|push
    lp RegisterY|ldm|push
    lp RegisterY+1|ldm|push
        lii 2-1
        lia low Sprites_ | lp RegisterX | exam
        lia high Sprites_ | lp RegisterX+1 | exam
        lij Sprite_End
        do
            ixl ; y [1
            cpia InvalidY
            if nz
                lp RegisterL|exam|ldm
                exab
                dx|dx ; [-1
                ixl ; x [0
                lp RegisterK|exam|ldm

                lp RegisterX|exam|push|exam
                lp RegisterX+1|exam|push|exam
                    call VVramOffset_
                    lp RegisterX+1|ldm|exab
                    lp RegisterX|ldm
                    push
                        lia high (VVramFront_-1) | lp RegisterY+1 | exam
                        lia low (VVramFront_-1) | lp RegisterY | exam
                    pop
                    adb
                lp RegisterX+1|pop|exam
                lp RegisterX|pop|exam

                ix|ix|ix ; [3
                lia 2|lp RegisterM|exam
                do
                    lp RegisterL|cpim VVramHeight
                    if c
                        lia 2|lp RegisterN|exam
                        do
                            lp RegisterK|cpim VVramWidth
                            if c
                                ixl
                                cpia 0
                                if nz
                                    iys
                                else
                                    iy
                                endif
                            else
                                ix
                                iy
                            endif
                            inck
                            decn
                        while nz|wend
                        deck|deck
                        lia VVramWidth-2
                        lib 0
                        lp RegisterY|adb
                    else
                        ix|ix
                        lia VVramWidth
                        lib 0
                        lp RegisterY|adb
                    endif
                    incl
                    decm
                while nz|wend
                dx|dx|dx|dx|dx|dx|dx|dx
            else
                dx|dx
            endif
            lp RegisterY|liq RegisterX
            mvw
            iy|iy
            ixl|iys
            ixl|iys
            ix|ix|ix|ix|ix|ix|ix

            decj
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


; void EraseSprites();
cseg
EraseSprites_: public EraseSprites_
    push
    exab|push
    lp RegisterI|ldm|push
    lp RegisterJ|ldm|push
    lp RegisterK|ldm|push
    lp RegisterL|ldm|push
    lp RegisterM|ldm|push
    lp RegisterN|ldm|push
    lp RegisterX|ldm|push
    lp RegisterX+1|ldm|push
    lp RegisterY|ldm|push
    lp RegisterY+1|ldm|push
        lii 2-1
        lia low (Sprites_+Sprite_oldX) | lp RegisterX | exam
        lia high (Sprites_+Sprite_oldX) | lp RegisterX+1 | exam
        lij Sprite_End
        do
            ixl ; oldY [3
            cpia InvalidY
            if nz
                lp RegisterL|exam|ldm
                exab
                dx|dx ; [1
                ixl ; x [2
                lp RegisterK|exam|ldm

                lp RegisterX|exam|push|exam
                lp RegisterX+1|exam|push|exam
                    call VVramOffset_
                    lp RegisterX+1|ldm|exab
                    lp RegisterX|ldm
                    push
                        lia high (VVramFront_-1) | lp RegisterY+1 | exam
                        lia low (VVramFront_-1) | lp RegisterY | exam
                    pop
                    adb
                    push
                        lia high (VVramBack_-1) | lp RegisterX+1 | exam
                        lia low (VVramBack_-1) | lp RegisterX | exam
                    pop
                    adb

                    lia 2|lp RegisterM|exam
                    do
                        lp RegisterL|cpim VVramHeight
                        if c
                            lia 2|lp RegisterN|exam
                            do
                                lp RegisterK|cpim VVramWidth
                                if c
                                    ixl
                                    iys
                                else
                                    ix
                                    iy
                                endif
                                inck
                                decn
                            while nz|wend
                            lia VVramWidth-2
                            lib 0
                            lp RegisterY|adb
                            lp RegisterX|adb
                        else
                            ix|ix
                            lia VVramWidth
                            lib 0
                            lp RegisterY|adb
                            lp RegisterX|adb
                        endif
                        incl
                        decm
                    while nz|wend
                                    _deb: public _deb
                lp RegisterX+1|pop|exam
                lp RegisterX|pop|exam
            else
                dx ; [2
            endif
            ix|ix|ix|ix|ix|ix|ix|ix
            decj
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
