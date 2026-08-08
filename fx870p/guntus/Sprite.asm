include "Vram.inc"
include "VVram.inc"

ext VVramOffset_
ext VVramFront_, VVramBack_

SpriteCount equ 18
InvalidY equ &h80

Sprite_x equ 0
Sprite_y equ Sprite_x+1
Sprite_chars equ Sprite_y+1
Sprite_oldX equ Sprite_chars+4
Sprite_oldY equ Sprite_oldX+1
Sprite_unitSize equ Sprite_oldY+1

Movable_x equ 0
Movable_y equ Movable_x+1
Movable_sprite equ Movable_y+1


dseg
Sprites_: public Sprites_
    defs Sprite_unitSize*SpriteCount


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    phsw $1
    phsm $13,4
        ldw $10,Sprites_
        ldw $12,Sprite_unitSize
        ld $0,InvalidY
        ld $1,SpriteCount
        do
            pre iz,$10
            st $0,(iz+Sprite_y)
            st $0,(iz+Sprite_oldY)
            adw $10,$12
            sb $1,$sy
        while nz | wend
    ppsm $10,4
    ppsw $0
rtn


cseg
PtrZ:
    phsw $1
    phsw $11
        biu $0 ;*2
        biu $0 ;*4
        biu $0 ;*8
        ld $1,$sx
        ldw $10,Sprites_ | adw $0,$10
        pre iz,$0
    ppsw $10
    ppsw $0
rtn


; void ShowSprite(byte index, byte x, byte y, ptr<byte> pChars);
cseg
ShowSprite_: public ShowSprite_
    phsw $1
        cal PtrZ
        sti $1,(iz+$sx) ; x
        sti $2,(iz+$sx) ; y
        pre ix,$16
        ld $1,4
        do
            ldi $0,(ix+$sx) | sti $0,(iz+$sx) ; c
            sb $1,$sy
        while nz | wend
    ppsw $0
rtn


; void HideSprite(byte index);
HideSprite_: public HideSprite_
    phsw $1
        cal PtrZ
        ld $0,InvalidY | st $0,(iz+Sprite_y)
    ppsw $0
rtn


; void EraseSprites();
cseg
EraseSprites_: public EraseSprites_
    phsm $5,6
    phsm $15,6
        pre ix,Sprites_
        ld $2,SpriteCount
        do
            ld $0,(ix+Sprite_oldX)
                            sbc (ix+Sprite_x),$0
                            if nz
                                _deb:public _deb
                                nop
                            endif
            ld $1,(ix+Sprite_oldY)
            sbc $1,InvalidY
            if nz
                sbc $1,VVramHeight
                if c
                    cal VVramOffset_
                    ldw $12,VVramBack_ | adw $12,$10
                    ldw $14,VVramFront_ | adw $14,$10
                    ld $3,2
                    do
                        sbc $1,VVramHeight
                        if c
                            ld $4,2
                            do
                                sbc $0,VVramWidth
                                if c
                                    ld $5,($12)
                                    st $5,($14)
                                endif
                                adw $12,$sy
                                adw $14,$sy
                                ad $0,$sy
                                sb $4,$sy
                            while nz | wend
                            ldw $10,VVramWidth-2 | adw $12,$10 | adw $14,$10
                            sb $0,2
                        else
                            ldw $10,VVramWidth | adw $12,$10 | adw $14,$10
                        endif
                        ad $1,$sy
                        sb $3,$sy
                    while nz | wend
                endif
            endif
            ldd $5,(ix+Sprite_unitSize)
            sb $2,$sy
        while nz | wend
    ppsm $10,6
    ppsm $0,6
rtn


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    phsm $5,6
    phsm $13,4
        pre ix,Sprites_
        ld $2,SpriteCount
        do
            ldi $0,(ix+$sx) ; x
            ldi $1,(ix+$sx) ; y
            sbc $1,InvalidY
            if nz
                sbc $1,VVramHeight
                if c
                    cal VVramOffset_
                    ldw $12,VVramFront_ | adw $10,$12
                    
                    ld $3,2
                    do
                        sbc $1,VVramHeight
                        if c
                            ld $4,2
                            do
                                ldi $5,(ix+$sx)
                                sbc $0,VVramWidth
                                if c
                                    sbc $5,$sx
                                    if nz
                                        st $5,($10)
                                    endif
                                endif
                                adw $10,$sy
                                ad $0,$sy
                                sb $4,$sy
                            while nz | wend
                            ldw $12,VVramWidth-2 | adw $10,$12
                            sb $0,2
                        else
                            ldd $5,(ix+2)
                            ldw $12,VVramWidth | adw $10,$12
                        endif
                        ad $1,$sy
                        sb $3,$sy
                    while nz | wend
                    sb $1,2
                endif
            else
                ldd $5,(ix+4)
            endif
            sti $0,(ix+$sx) ; oldX
            sti $1,(ix+$sx) ; oldY
            sb $2,$sy
        while nz | wend
    ppsm $10,4
    ppsm $0,6
rtn