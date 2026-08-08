ext InitSound
ext Main_

cseg
    cal InitSound
    cal Main_

    pst ua,&h54
    jp &h33B3
rtn


; void Wait(byte t);
cseg
Wait_: public Wait_
    phsw $1
        do
            ld $1,150
            do
                sb $1,$sy
            while nz | wend
            sb $0,$sy
        while nz | wend
    ppsw $0
rtn