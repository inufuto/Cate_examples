include "InternalRam.inc"
include "Vram.inc"
include "VVram.inc"

ext CellMap_

; ptr<byte> CellMapPtr(byte column, byte floor);
cseg
CellMapPtr_: public CellMapPtr_
    push
    exab|push|exab
        rc|sr
        rc|sr
        push
            exab
            lp RegisterX | exam | ldm
            rc|sl ;*2
            adm|ldm ;*3
            lib 0
            rc|sl| exab | sl | exab ;*6
            rc|sl| exab | sl | exab ;*12
            rc|sl| exab | sl | exab ;24
            exam
            exab
            lp RegisterX+1 | exam
        pop
        lib 0
        lp RegisterX | adb
        lia low CellMap_ | lib high CellMap_
        lp RegisterX | adb
    pop|exab
    pop
rtn
