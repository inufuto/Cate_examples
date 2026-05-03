ext PrintC_

cseg
PrintDigit:
    ai r10,-2 | mov r11,*r10
        clr r1
        do
            inc r1
            s r2,r3
        while oc
        wend
        a r2,r3
        dec r1
        if eq
            ci r4,0
            if eq
                li r1,' ' shl 8
            else
                li r1,'0' shl 8
            endif
        else
            li r4,1
            ai r1,'0'
            swpb r1
        endif
        bl @PrintC_
    mov *r10+,r11
rt


; word PrintNumber5(word address, word w);
cseg
PrintNumber5_: public PrintNumber5_
    ai r10,-2 | mov r11,*r10
    ai r10,-2 | mov r1,*r10
    ai r10,-2 | mov r2,*r10
    ai r10,-2 | mov r3,*r10
    ai r10,-2 | mov r4,*r10
        clr r4
        mov r1,r3
        li r2,10000
        bl @PrintDigit
        li r2,1000
        bl @PrintDigit
        li r2,100
        bl @PrintDigit
        li r2,10
        bl @PrintDigit
        mov r3,r1
        swpb r1
        ai r1,'0' shl 8
        bl @PrintC_
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r11
rt


; word PrintByteNumber3(word address, byte b);
cseg
PrintByteNumber3_: public PrintByteNumber3_
    ai r10,-2 | mov r11,*r10
    ai r10,-2 | mov r1,*r10
    ai r10,-2 | mov r2,*r10
    ai r10,-2 | mov r3,*r10
    ai r10,-2 | mov r4,*r10
        clr r4
        swpb r1
        mov r1,r3
        li r2,100
        bl @PrintDigit
        li r2,10
        bl @PrintDigit
        mov r3,r1
        swpb r1
        ai r1,'0' shl 8
        bl @PrintC_
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r11
rt


; word PrintByteNumber2(word address, byte b);
cseg
PrintByteNumber2_: public PrintByteNumber2_
    ai r10,-2 | mov r11,*r10
    ai r10,-2 | mov r1,*r10
    ai r10,-2 | mov r2,*r10
    ai r10,-2 | mov r3,*r10
    ai r10,-2 | mov r4,*r10
        clr r4
        swpb r1
        mov r1,r3
        li r2,10
        bl @PrintDigit
        mov r3,r1
        swpb r1
        ai r1,'0' shl 8
        bl @PrintC_
    mov *r10+,r4
    mov *r10+,r3
    mov *r10+,r2
    mov *r10+,r1
    mov *r10+,r11
rt
