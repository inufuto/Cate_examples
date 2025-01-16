ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push dx
        mov dh,al
        mov al,5
        mul dl
        mov dl,dh
        shr dl,1
        xor dh,dh
        add ax,dx
        add ax,CellMap_
    pop dx
ret
