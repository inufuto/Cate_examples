ext PrintC_

zseg
zeroVisible:
    defb 0
value:
    defw 0

cseg
PrintDigitB:
    mv cl,0
    mv a,(<value)
    do
        sub a,il
    while nc
        inc cl
    wend
    add a,il
    mv (<value),a
    mv a,cl
    cmp a,0
    if z
        cmp (<zeroVisible),0
        if nz
            mv a,'0'
        else
            mv a,' '
        endif
    else
        mv (<zeroVisible),1
        add a,'0'
    endif
    mv il,a
    call PrintC_
ret

; word PrintByteNumber2(word vram, byte b);
PrintByteNumber2_: public PrintByteNumber2_
    pushs a | pushs il | pushs cl
        mv (<zeroVisible),0
        mv (<value),il
        mv il,10 | call PrintDigitB
        mv a,(<value) | add a,'0' | mv il,a
        call PrintC_
    pops cl | pops il | pops a
ret


; word PrintByteNumber3(word vram, byte b);
PrintByteNumber3_: public PrintByteNumber3_
    pushs a | pushs il | pushs cl
        mv (<zeroVisible),0
        mv (<value),il
        mv il,100 | call PrintDigitB
        mv il,10 | call PrintDigitB
        mv a,(<value) | add a,'0' | mv il,a
        call PrintC_
    pops cl | pops il | pops a
ret



PrintDigitW:
    mv cl,0
    mv ba,(<value)
    do
        sub ba,i
    while nc
        inc cl
    wend
    add ba,i
    mv (<value),ba
    mv a,cl
    cmp a,0
    if z
        cmp (<zeroVisible),0
        if nz
            mv a,'0'
        else
            mv a,' '
        endif
    else
        mv (<zeroVisible),1
        add a,'0'
    endif
    mv il,a
    call PrintC_
ret


; word PrintNumber5(word vram, word w);
PrintNumber5_: public PrintNumber5_
    pushs ba | pushs i | pushs cl
        mv (<zeroVisible),0
        mv (<value),i
        mv i,10000 | call PrintDigitW
        mv i,1000 | call PrintDigitW
        mv i,100 | call PrintDigitW
        mv i,10 | call PrintDigitW
        mv a,(<value) | add a,'0' | mv il,a
        call PrintC_
    pops cl | pops i | pops ba
ret
