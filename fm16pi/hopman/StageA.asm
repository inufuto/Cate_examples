ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push dx
        shr al,1 | shr al,1
        mov dh,al
        mov al,32
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,CellMap_
    pop dx
ret
