ext Startup

cseg
defb 08h,20h
defw EntryPoint
defb 03h
defb "TigerDMGC"
defb 24h
defb 0,160
defb "antiair  "
defw 0001h
defb 0a4h
defb 0,0,0

EntryPoint:
    cmp r2,0
    jmp z,Startup
ret
defs 20h-7
