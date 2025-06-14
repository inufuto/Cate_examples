include "e500.inc"
include "Vram.inc"
include "VVram.inc"

ext AsciiPattern, CharPattern
ext VVramBack_, VVramFront_

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:public Backup
    defs VVramWidth*VVramHeight
TopRow_: public TopRow_
    defb 0


; void ClearScreen();
cseg
Clear:
    do
        mv [x++],a
        dec i
    while nz | wend
ret
ClearScreen_: public ClearScreen_
    pushs a | pushs i | pushs x
        mv a,0
        mv x,Vram_
        mv i,VramRowSize*VramHeight
        call Clear
        mv x,Backup
        mv i,VVramWidth*VVramHeight
        call Clear
        mv x,VVramBack_
        mv i,VVramWidth*VVramHeight
        call Clear
    pops x | pops i | pops a
jp PresentVram_


; void PresentVram();
cseg
WaitLcd1:
    mv a,[LCD1_STATUS]
ret
WaitLcd2:
    mv a,[LCD2_STATUS]
ret
PresentVram_: public PresentVram_
    pushs a | pushs i | pushs x
        pushu imr
            mv a,0c0h+0 | mv [LCD_COMMAND],a

            mv x,Vram_
            mv a,0
            do
                pushs a
                    or a,0b8h | mv [LCD2_COMMAND],a
                    call WaitLcd2
                    mv a,40h+0 | mv [LCD2_COMMAND],a
                    call WaitLcd2
                    mv il,64
                    do
                        mv a,[x++]
                        mv [LCD2_WRITE],a
                        dec il
                    while nz | wend
                pops a

                pushs a
                    or a,0b8h | mv [LCD1_COMMAND],a
                    call WaitLcd1
                    mv a,40h+0 | mv [LCD1_COMMAND],a
                    call WaitLcd1
                    mv il,56
                    do
                        mv a,[x++]
                        mv [LCD1_WRITE],a
                        dec il
                    while nz | wend
                pops a

                inc a
                cmp a,VramHeight
            while nz | wend
        popu imr
    pops x | pops i | pops a
ret


; ptr<byte> PrintC(ptr<byte> address, byte c);
cseg
CharTable:
        defb " 0123456789ACEFGHIKMNOPRSTUVY"
PrintC_: public PrintC_
    pushs ba | pushs il | pushs y | pushs cl | pushs dx
        mv cl,il
        mv dl,0
        mv il,29
        mv y,CharTable
        do
            mv a,[y++]
            cmp cl,a
            jrz PrintC_break
            inc dl
            dec il
        while nz | wend
        mv dl,0
        PrintC_break:
        mv dh,0
        mv ba,dx
        add ba,ba | add ba,ba
        mv y,AsciiPattern
        add y,ba
        mv il,AsciiWidth
        do
            mv a,[y++]
            mv [x++],a
            dec il
        while nz | wend
    pops dx | pops cl | pops y | pops il | pops ba
ret


; ptr<byte> Put(ptr<byte> pVram, byte c, byte shift);
dseg
Put_@Param2: public Put_@Param2
Put_shift:
    defb 0
cseg
Put_: public Put_
    pushs ba | pushs y | pushs bx | pushs cx | pushs dx
        mv a,[Put_shift]
        mv bh,a
        call MakeMask
        mv a,il
        call Put
    pops dx | pops cx | pops bx | pops y | pops ba
ret
MakeMask:
    mvw dx,0007h
    mv a,bh
    do
        cmp a,0
    while nz
        rc | shl dl | shl dh
        dec a
    wend
ret
Put:
    mv cl,a | mv ch,0
    mv ba,cx
    add ba,ba
    mv y,CharPattern
    add y,ba
    mv a,[y] | and a,0fh
    call WriteByte
    mv a,[y++] | ror a | ror a | ror a | ror a | and a,0fh
    call WriteByte
    mv a,[y] | and a,0fh
    call WriteByte
ret
WriteByte:
    mv cl,a | mv ch,0
    mv a,bh
    do
        cmp a,0
    while nz
        rc | shl cl | shl ch
        dec a
    wend
    mv a,dl
    cmp a,0
    if nz
        xor a,0ffh
        mv bl,[x]
        and a,bl
        or a,cl
        mv [x],a
    endif
    mv a,dh
    cmp a,0
    if nz
        xor a,0ffh
        mv bl,[x+VramRowSize]
        and a,bl
        or a,ch
        mv [x+VramRowSize],a
    endif
    inc x
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pushu imr
    pushs ba | pushs i | pushs x | pushs y | pushs bx | pushs cx | pushs dx | mv [--s],u
        mv u,Backup
        mv x,Vram_
        mv y,VVramFront_+VVramWidth+1
        mv a,[TopRow_]
        cmp a,0
        if nz
            mv ba,VVramWidth
            add y,ba
        endif
        mv bh,0 ; shift
        call MakeMask

        mv ch,WindowHeight
        do
            mv cl,WindowWidth
            do
                mv bl,[y++]
                mv a,[u]
                cmp bl,a
                if nz
                    mv [u],bl
                    mv a,bl
                    pushs y | pushs cx
                        call Put
                    pops cx | pops y
                else
                    inc x | inc x | inc x
                endif
                inc u
                dec cl
            while nz | wend
            inc y | inc y

            mv ba,WindowWidth*3
            sub x,ba

            mv ba,dx
            add ba,ba | add ba,ba | add ba,ba
            mv dx,ba

            mv a,bh
            add a,3
            mv bh,a
            sub a,8
            if nc
                mv bh,a
                call MakeMask
                mv ba,VramRowSize
                add x,ba
            endif
            dec ch
        while nz | wend
    mv u,[s++] | pops dx | pops cx | pops bx | pops y | pops x | pops i | pops ba
    popu imr
ret

; dseg
; Mask_: public Mask_
;     defw 0