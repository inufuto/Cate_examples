PitPort equ 20h
PpiPort equ 30h
Ls244Port equ 40h
CrtControlPort equ 50h

GGdcParamPort equ 60h
GGdcCmdPort equ GGdcParamPort+1
GGdcStatusPort equ GGdcParamPort

TGdcParamPort equ 70h
TGdcCmdPort equ TGdcParamPort+1
TGdcStatusPort equ TGdcParamPort

ResetCmd equ 00h
SyncCmd equ 0fh
WDatCmd equ 20h
PitchCmd equ 47h
CursCmd equ 49h
MaskCmd equ 4ah
CCharCmd equ 4bh
FigsCmd equ 4ch
VSyncCmd equ 6fh
PRamCmd equ 70h
