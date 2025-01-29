include "e500.inc"
include "Vram.inc"
include "VVram.inc"

ext VVram_
ext AsciiPattern, CharPattern

dseg
Vram_: public Vram_
    defs VramRowSize*VramHeight
Backup:public Backup
    defs VVramWidth*VVramHeight

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
        mv x,VVram_
        mv i,VVramWidth*VVramHeight
        call Clear
        mv x,Backup
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
        mv il,CharWidth
        do
            mv a,[y++]
            mv [x++],a
            dec il
        while nz | wend
    pops dx | pops cl | pops y | pops il | pops ba
ret


; ptr<byte> Put(ptr<byte> pVram, byte c);
cseg
PatternPtrY:
    mv dh,0
    rc|shl dl|shl dh ;*2
    rc|shl dl|shl dh ;*4
    rc|shl dl|shl dh ;*8
    mv i,dx
    mv y,CharPattern
    add y,i
ret
Put_: public Put_
    pushs a | pushs i | pushs dx
        mv dl,il
        call PatternPtrY

        mv il,8
        do
            mv a,[y++]
            mv [x++],a
            dec i
        while nz | wend
    pops dx | pops i | pops a
ret


; void VVramToVram();
VVramToVram_: public VVramToVram_
    pushu imr
    pushs a | pushs i | pushs x | pushs y | pushs cx | pushs dl | mv [--s],u
        mv u,Backup
        mv x,Vram_
        mv y,VVram_
        mv ch,VVramHeight
        do
            mv cl,VVramWidth
            do
                mv dl,[y++]
                mv a,[u]
                cmp dl,a
                if nz
                    mv [u],dl
                    pushs y
                        call PatternPtrY
                        mv il,8
                        do
                            mv a,[y++]
                            mv [x++],a
                            dec il
                        while nz | wend
                    pops y
                else
                    mv i,8 | add x,i
                endif
                inc u
                dec cl
            while nz | wend
            mv i,VramRowSize-VVramWidth*8
            add x,i

            dec ch
        while nz | wend
    mv u,[s++] | pops dl | pops cx | pops y | pops x | pops i | pops a
    popu imr
ret


; ptr<byte> VramPtr(byte x, byte y);
cseg
YTable:
    defw VramRowSize*0
    defw VramRowSize*1
    defw VramRowSize*2
    defw VramRowSize*3
VramPtr_: public VramPtr_
    pushs ba | pushs i | pushs dx
        rc|shl a
        rc|shl a
        mv dh,a
        mv a,il
        mv il,dh
        add a,a ;*2
        mv x,YTable
        add x,a
        mv ba,[x]
        mv dl,il
        mv dh,0
        mv i,dx
        add ba,i
        mv x,Vram_
        add x,ba
    pops dx | pops i | pops ba
ret


; ptr<byte> BackupPtr(byte x, byte y);
cseg
BackupPtr_: public BackupPtr_
    pushs a | pushs dl
        rc|shr a
        mv dl,a ;x
        mv a,il ;y
        add a,a ;*2
        add a,a ;*4
        add a,a ;*8
        add a,dl
        mv x,Backup
        add x,a
    pops dl | pops a
ret


; void EraseBackup(byte x, byte y);
cseg
EraseBackup_: public EraseBackup_
    pushs a | pushs i | pushs x | pushs cx | pushs dx
        mv ch,1 | mv cl,1

        rc|shr a ; x
        if c
            inc cl
        endif
        
        mv dl,il ;y
        rc|shr dl
        if c
            inc ch
        endif

        mv dh,0
        rc|shl dl|shl dh ;*2
        rc|shl dl|shl dh ;*4
        rc|shl dl|shl dh ;*8
        add dx,a
        mv x,Backup | mv i,dx | add x,i

        do
            pushs x
                mv il,cl
                mv a,0ffh
                do
                    mv [x++],a
                    dec il
                while nz | wend
            pops x
            mv i,VVramWidth | add x,i

            dec ch
        while nz | wend
    pops dx | pops cx | pops x | pops i | pops a
ret


; void DrawSprite(byte x, byte y, byte pattern);
dseg
DrawSprite_@Param2: public DrawSprite_@Param2
DrawSprite_pattern:
    defb 0
cseg
DrawSprite_: public DrawSprite_
    pushs a | pushs i | pushs x | pushs cx | pushs dx
        mv cl,a ;x
        mv ch,il ;y

        mv dl,[DrawSprite_pattern]
        call PatternPtrY

        mv a,ch ;y
        and a,0feh
        mv x,YTable | add x,a
        mv ba,[x]
        mv x,Vram_ | add x,ba
        mv a,cl ;x
        add a,a ;*2
        add a,a ;*4
        add x,a

        test ch,1
        if z
            mv il,7
            do
                mv a,[x]
                and a,80h
                mv ch,a
                mv a,[y++]
                or a,ch
                mv [x++],a
                dec il
            while nz | wend
        else
            mv cl,7
            do
                mv dl,[y++] | mv dh,0
                rc
                shl dl|shl dh
                shl dl|shl dh
                shl dl|shl dh
                shl dl|shl dh
                mv a,[x] | and a,0fh | or a,dl | mv [x],a
                mv i,VramRowSize | add x,i
                mv a,[x] | and a,0f8h | or a,dh | mv [x++],a
                sub x,i
                dec cl
            while nz | wend
        endif
    pops dx | pops cx | pops x | pops i | pops a
ret
