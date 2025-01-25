include "GameCom.inc"
include "Vram.inc"
include "VVram.inc"

ext pCurrentBackup

PatternY equ 1+32
TopY equ TopMargin+CharHeight*2
Sprites equ 0e600h

Sprite_End equ 13
sprite_x equ 0
sprite_y equ 1
sprite_pattern equ 2
sprite_old0X equ 3
sprite_old0Y equ 4
sprite_old0Pattern equ 5
sprite_old1X equ 6
sprite_old1Y equ 7
sprite_old1Pattern equ 8
unitSize equ 9
InvalidPattern equ 0ffh

movable_x equ 0
movable_y equ 1
movable_sprite equ 2

SpriteWidth equ CharWidth*2
SpriteHeight equ CharHeight*2


; void HideAllSprites();
cseg
HideAllSprites_: public HideAllSprites_
    push r0 | pushw rr8
        movw rr8,Sprites
        mov r0,InvalidPattern
        do
            mov sprite_pattern(rr8),r0
            mov sprite_old0Pattern(rr8),r0
            mov sprite_old1Pattern(rr8),r0
            addw rr8,unitSize
            cmpw rr8,Sprites+unitSize*Sprite_End
        while c|wend
    popw rr8 | pop r0
ret


; void ShowSprite(ptr<Movable> pMovable, byte pattern);
cseg
ShowSprite_: public ShowSprite_
    pushw rr0 | pushw rr8 | pushw rr10
        movw rr10,rr0
        mov r1,movable_sprite(rr10)
        mult rr0,unitSize
        addw rr0,Sprites
        movw rr8,rr0

        mov r0,movable_x(rr10)
        sub r0,8
        mov sprite_x(rr8),r0
        
        mov r0,movable_y(rr10)
        sub r0,8
        mov sprite_y(rr8),r0
        
        mov sprite_pattern(rr8),r3
    popw rr10 | popw rr8 | popw rr0
ret


; void HideSprite(byte sprite);
cseg
HideSprite_: public HideSprite_
    push r0 | pushw rr8
        clr r0
        mult rr0,unitSize
        addw rr0,Sprites
        movw rr8,rr0

        mov r0,InvalidPattern
        mov sprite_pattern(rr8),r0
    popw rr8 | pop r0
ret


; void DrawSprites();
cseg
DrawSprites_: public DrawSprites_
    pushw rr0 | pushw rr8
        mov r0,r LCC
        and r0,40h
        rl r0 | rl r0 | rl r0
        xor r0,02h
        mov r DMVP,r0
        mov r DMDX,SpriteHeight-1
        mov r DMDY,SpriteWidth-1
        mov r DMBR,CharBank
        mov r DMPL,0e4h
        mov r DMPL,0d0h

        movw rr8,Sprites
        mov r0,InvalidPattern
        do
            mov r1,sprite_pattern(rr8)
            cmp r1,InvalidPattern
            if nz
                mov r0,r1
                sll r0 | sll r0 | sll r0 | sll r0
                ; and r0,0f0h
                mov r DMX1,r0
                and r1,0f0h
                add r1,PatternY
                mov r DMY1,r1

                mov r0,sprite_x(rr8)
                add r0,LeftMargin
                mov r DMY2,r0

                mov r0,sprite_y(rr8)
                add r0,TopY
                mov r DMX2,r0

                ; di
                    pushw rr IE0_
                        mov IE0,80h
                        clr r IE1_
                        mov r DMC,82h
                        halt | bclr r IR0_,7
                    popw rr IE0_
                ; ei
                
                mov r1,sprite_pattern(rr8) | mov sprite_old0Pattern(rr8),r1
                mov r1,sprite_x(rr8) | mov sprite_old0X(rr8),r1
                mov r1,sprite_y(rr8) | mov sprite_old0Y(rr8),r1
            endif
            addw rr8,unitSize
            cmpw rr8,Sprites+unitSize*Sprite_End
        while ult|wend
    popw rr8 | popw rr0
ret


; void EraseSprites();
cseg
EraseSprites_: public EraseSprites_
    pushw rr0 | pushw rr2 | pushw rr4 | pushw rr8 | pushw rr10 | pushw rr12
        movw rr12,@pCurrentBackup

        movw rr8,Sprites+unitSize*(Sprite_End-1)
        mov r0,InvalidPattern
        do
            mov r1,sprite_old1Pattern(rr8)
            cmp r1,InvalidPattern
            if nz
                movw rr4,0202h
                
                mov r1,sprite_old1Y(rr8)
                mov r3,r1
                srl r1 | srl r1 | srl r1
                mult rr0,VVramWidth
                movw rr10,rr0
                and r3,07h
                if nz
                    inc r4
                endif

                mov r1,sprite_old1X(rr8)
                mov r3,r1
                srl r1 | srl r1 | srl r1
                clr r0
                addw rr10,rr0
                addw rr10,rr12
                and r3,07h
                if nz
                    inc r5
                endif

                mov r0,0ffh
                do
                    pushw rr10
                        mov r1,r5
                        do
                            mov (rr10)+,r0
                            dec r1
                        while nz|wend
                    popw rr10
                    addw rr10,VVramWidth
                    dec r4
                while nz|wend
            endif
            mov r1,sprite_old0Pattern(rr8)
            cmp r1,InvalidPattern
            if nz
                mov sprite_old1Pattern(rr8),r1
                mov r1,sprite_old0X(rr8) | mov sprite_old1X(rr8),r1
                mov r1,sprite_old0Y(rr8) | mov sprite_old1Y(rr8),r1
            endif
            subw rr8,unitSize
            cmpw rr8,Sprites
        while nc|wend
    popw rr12 | popw rr10 | popw rr8 | popw rr4 | popw rr2 | popw rr0
ret
