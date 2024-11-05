include "GameCom.inc"

ext Startup

cseg
defb 08h,20h
defw EntryPoint
defb 03h
defb "TigerDMGC"
defb 24h
defb 0,160
defb "         "
defw 0001h
defb 0a4h
defb 0,0,0

EntryPoint:
    cmp r2,0
    if z
        ; ROM Bank
        mov r MMU1,23h
        mov r MMU3,21h
        mov r MMU4,22h
        jmp t,Startup
        ExitPoint: public ExitPoint
        mov r MMU1,02h
        mov r MMU3,00h
        mov r MMU4,03h
    endif
ret
defs 5
