; byte Abs(byte a, byte b);
cseg
Abs_: public Abs_
    sb $0,$1
    if nz
        anc $0,&h80
        if nz
            cmp $0
        endif
    endif
rtn