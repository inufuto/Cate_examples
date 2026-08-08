CGRAM equ &h153C

cseg
    pre ix,address
    ldw $10,(ix+$sx)
    pre ix,$10
    pre iz,CGRAM
    ld $0,6*4
    do
        ldi $1,(iz+$sx)
        sti $1,(ix+$sx)
        sb $0,$sy
    while nz | wend
    gre ix,$10
    pre ix,address
    stw $10,(ix+$sx)
    pst ua,&h54
rtn
address:
    defw &h1cd0
