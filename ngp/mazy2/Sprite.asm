include "ngp.inc"
include "Vram.inc"

ext CharColors

SpriteVram equ 8800h
SpritesPalette equ 8c00h
AttributeValue equ 10h
MaxSpriteCount equ 64

SpriteCount equ 15
InvaldY equ 160

Sprite_char equ 0
Sprite_x equ 1
Sprite_y equ 2
UnitSize equ 3

Movable_x equ 0
Movable_y equ 1
Movable_sprite equ 2

dseg
Sprites: public Sprites
    defs UnitSize*SpriteCount
FirstIndex:
    defs 1
pFirst:
    defs 2
Update1:
    jp UpdateMono

cseg
InitSprites: public InitSprites
    ld a,(Version)
    or a,a
    if z
        ld xwa,UpdateMono
    else
        ld xwa,UpdateColor
    endif
    ld (Update1+1),xwa

    ld (FirstIndex),0
    ldw (pFirst),Sprites
; ret


; void HideAllSprites();
HideAllSprites_: public HideAllSprites_
    push b | push xhl
        ld xhl,Sprites
        ld b,SpriteCount
        do
            ld (xhl+Sprite_y),InvaldY
            add hl,UnitSize
        dwnz b
    pop xhl | pop b
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
ShowSprite_: public ShowSprite_
    push b | push xhl
        ld l,(xwa+Movable_sprite)
        mul hl,UnitSize
        add hl,Sprites  
        ld qhl,0
        ld b,(xwa+Movable_x) |  ld (xhl+Sprite_x),b
        ld b,(xwa+Movable_y) |  ld (xhl+Sprite_y),b
        ld (xhl+Sprite_char),c
    pop xhl | pop b
ret


; void HideSprite(byte index);
HideSprite_: public HideSprite_
    push xwa
        mul wa,UnitSize
        add wa,Sprites
        ld qwa,0
        ld (xwa+Sprite_y),InvaldY
    pop xwa
ret


cseg
UpdateMono:
    ld l,h
    and l,10h
    sll 1,l
    or l,AttributeValue
    and d,0fh

    ld (xiy+),a
    ld (xiy+),l
    ld (xiy+),b
    ld (xiy+),c
ret
UpdateColor:
    ld l,h
    and l,0fh

    ld (xiy+),a
    ld (xiy+),AttributeValue
    ld (xiy+),b
    ld (xiy+),c
    ld (xiz+),l
ret
UpdateSprites: public UpdateSprites
    push wa | push bc| push de | push xhl | push xix | push xiy | push xiz
        ld qix,0
        ld xiy,SpriteVram
        ld xiz,SpritesPalette
        ld w,(FirstIndex)
        ld ix,(pFirst)
        ld de,SpriteCount
        do
            ld c,(xix+Sprite_y)
            cp c,InvaldY
            if nz
                add c,8*2 ;y

                ld a,(xix+Sprite_char)
                ld l,a | xor h,h
                add hl,CharColors
                ld h,(xhl)

                ld b,(xix+Sprite_x)
            
                call Update1
                inc 1,a
                add b,8
                call Update1
                inc 1,a
                sub b,8 | add c,8
                call Update1
                inc 1,a
                add b,8
                call Update1

                inc 1,d
                cp d,MaxSpriteCount/4
                jr nc,break
            endif
            add xix,UnitSize
            inc 1,w
            cp w,SpriteCount
            if z
                xor w,w
                ld xix,Sprites
            endif
        dwnz e
        do
            ld b,4*4
            do
                ld (xiy+),0
            dwnz b
            inc 1,d
            cp d,MaxSpriteCount/4
        while c wend
        break:
        
        ld w,(FirstIndex)
        ld ix,(pFirst)
        add xix,UnitSize
        inc 1,w
        cp w,SpriteCount
        if z
            xor w,w
            ld xix,Sprites
        endif
        ld (FirstIndex),w
        ld (pFirst),ix
    pop xiz | pop xiy | pop xix | pop xhl | pop de | pop bc | pop wa
ret
