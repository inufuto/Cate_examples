    cseg

WaitVSyncIn_: public WaitVSyncIn_
    ld bc,1a01h
    do
        in a,(c)
        and 80h
    while nz | wend
ret

WaitVSyncOut_: public WaitVSyncOut_
    ld bc,1a01h
    do
        in a,(c)
        and 80h
    while z | wend
ret
