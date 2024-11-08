include "VVram.inc"

; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    pushw rr2
        mult rr2,VVramWidth
        clr r0
        addw rr0,rr2
        addw rr0,VVram
    popw rr2
ret


ext Ground_, GroundY_, dotOffset_
ext Tiles_

TileSize equ 4
GroundWidth equ VVramWidth/TileSize
GroundHeight equ (VVramHeight+TileSize*2-1)/TileSize

; void DrawGround();
cseg
DrawGround_: public DrawGround_
    pushw rr0 | pushw rr2 | pushw rr4 | pushw rr8 | pushw rr10 | pushw rr12 | pushw rr14
        mov r1,@dotOffset_
        mult rr0,16
        addw rr0,Tiles_
        movw rr14,rr0 ; pTileBase

        movw rr8,VVram ; pVVram

        mov r1,@GroundY_
        mov r2,r1 ; yPos
        do
            btst r1,80h
        while nz
            subw rr8,VVramWidth
            inc r1
        wend

        movw rr10,Ground_
        do
            mov r3,GroundWidth
            do
                mov r0,(rr10)+
                clr r1
                srl r0 | rrc r1
                addw rr0,rr14
                movw rr12,rr0
                
                mov r4,TileSize
                do
                    cmp r2,VVramHeight
                    if c
                        mov r5,TileSize
                        do
                            mov r1,(rr12)+
                            mov (rr8)+,r1
                            dec r5
                        while nz|wend
                        addw rr8,VVramWidth-TileSize
                    else
                        addw rr12,TileSize
                        addw rr8,VVramWidth
                    endif
                    inc r2
                    dec r4
                while nz|wend
                addw rr8,TileSize-VVramWidth*TileSize
                sub r2,TileSize

                dec r3
            while nz|wend
            addw rr8,VVramWidth*TileSize-TileSize*GroundWidth

            add r2,TileSize
            cmp r2,VVramHeight
        while c|wend
    popw rr14 | popw rr12 | popw rr10 | popw rr8 | popw rr4 | popw rr2 | popw rr0
ret
