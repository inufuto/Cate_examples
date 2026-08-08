include "Vram.inc"
include "VVram.inc"

ext VVramPtr_
ext LeftX_

SpriteCount equ 10
InvalidY equ &h80

Sprite_x equ 0
Sprite_y equ Sprite_x+1
Sprite_chars equ Sprite_y+1
Sprite_unitSize equ Sprite_chars+4

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
        ldw $10,Sprites_+Sprite_y
        ldw $12,Sprite_unitSize
        ld $0,InvalidY
        ld $1,SpriteCount
        do
            st $0,($10)
            adw $10,$12
            sb $1,$sy
        while nz | wend
    ppsm $10,4
    ppsw $0
rtn


cseg
PtrZ:
    phsw $15
        ld $1,$0
        biu $0 ;*2
        ad $0,$1 ;*3
        biu $0 ;*6
        ld $1,$sx
        ldw $14,Sprites_ | adw $0,$14
        pre iz,$0
    ppsw $14
rtn


; void ShowSprite(ptr<Movable> pMovable, ptr<byte> pChars);
cseg
ShowSprite_: public ShowSprite_
    phsw $1
        pre ix,$10
        ld $0,(ix+Movable_sprite)
        cal PtrZ
        ldi $0,(ix+$sx) | sti $0,(iz+$sx) ; x
        ldi $0,(ix+$sx) | sti $0,(iz+$sx) ; y
        pre ix,$12
        ld $1,4
        do
            ldi $0,(ix+$sx) | sti $0,(iz+$sx) ; c
            sb $1,$sy
        while nz | wend
    ppsw $0
rtn


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    phsm $3,4
    phsm $15,6
        pre ix,LeftX_ | ld $3,(ix+$sx)
        ldw $12,Sprites_
        ldw $14,Sprite_unitSize
        ld $2,SpriteCount
        do
            pre ix,$12
            ld $1,(ix+Sprite_y)
            sbc $1,InvalidY
            if nz
                ld $0,(ix+Sprite_x)
                sb $0,$3
                jr c,DrawSprites_skip
                sbc $0,VVramWidth-1
                if c
                    sbc $1,VVramHeight
                    if c
                        cal VVramPtr_
                        pre iz,$10
                        ld $0,(ix+Sprite_chars+0) | st $0,(iz+0)
                        ld $0,(ix+Sprite_chars+1) | st $0,(iz+1)
                        sbc $1,VVramHeight-1
                        if c
                            ld $0,(ix+Sprite_chars+2) | st $0,(iz+VVramWidth+0)
                            ld $0,(ix+Sprite_chars+3) | st $0,(iz+VVramWidth+1)
                        endif
                    endif
                endif
                DrawSprites_skip:
            endif
            adw $12,$14
            ad $1,$sy
            sb $2,$sy
        while nz | wend
    ppsm $10,6
    ppsm $0,4
rtn
