VramData equ 01h
Crtc equ 02h

PpiA equ 0
PpiB equ 1
PpiC equ 2
PpiControl equ 3

Ppi1 equ 04h
Ppi1A equ Ppi1+PpiA
Ppi1B equ Ppi1+PpiB
Ppi1C equ Ppi1+PpiC
Ppi1Control equ Ppi1+PpiControl

Ppi2 equ 08h
Ppi2A equ Ppi2+PpiA
Ppi2B equ Ppi2+PpiB
Ppi2C equ Ppi2+PpiC
Ppi2Control equ Ppi2+PpiControl

VramAddressLow equ Ppi1A
VramAddressHigh equ Ppi1C
