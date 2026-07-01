ext PanelMap_

; ptr<byte> MapPtr(byte column, byte floor);
cseg
MapPtr_: public MapPtr_
    push dx
        xor dh,dh
        shl dl,1 | shl dl,1 | shl dl,1
        xor ah,ah
        add ax,dx
        add ax,PanelMap_
    pop dx
ret
