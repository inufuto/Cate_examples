Port8255 equ 0e0h
Port8255_A equ Port8255+0
Port8255_B equ Port8255+1
Port8255_C equ Port8255+2
Port8255_Mode equ Port8255+3

Port8253 equ 0e4h
Port8253_Ch0 equ Port8253+0
Port8253_Ch1 equ Port8253+1
Port8253_Ch2 equ Port8253+2
Port8253_Mode equ Port8253+3

PortPIO equ 0e8h
PortPIO_A equ 0e8h+0
PortPIO_ModeA equ 0e8h+1
PortPIO_B equ 0e8h+2
PortPIO_ModeB equ 0e8h+3

BackgroundColor equ 0f4h
TextColor equ 0f5h
DisplayPlane equ 0f6h
AccessPlane equ 0f7h