KBD equ $C000
KBDSTRB equ $C010
SPKR equ $C030
TXTCLR equ $C050
TXTSET equ $C051
MIXCLR equ $C052
MIXSET equ $C053
TXTPAGE1 equ $C054
TXTPAGE2 equ $C055
LORES equ $C056
HIRES equ $C057
PB0 equ $C061
PB1 equ $C062

PREAD equ $FB1E

VramBlockStep equ 40
Vram0 equ $2000
Vram1 equ Vram0+VramBlockStep
Vram2 equ Vram1+VramBlockStep
VramRowStep equ $80
VramLineStep equ $400
