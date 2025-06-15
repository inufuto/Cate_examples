; I/O Map
DmaController equ 00h ; 8237 DMA Controller

InterruptController equ 20h ;  8259 Interrupt Controller
IntervalTimer equ 40h ;  8254 Timer

Vg230Index equ 26h ;  VG230 Single-Chip PC Platform Index Register
Vg230Data equ 27h ;  VG230 Single-Chip PC Platform Data Register

KeyboardControl equ 61h ; PC/XT Compatible PPIB Keyboard Control Register

MapAddress equ 6ch ; Map Address Register
MapData equ 6eh ; Map Data Register

Rtc equ 80h ; Real Time Clock

NmiMask equ 0a0h ;  PC/XT Compatible NMI Mask Register

ParallelPortControl0 equ 172h ; Parallel Port Control
ParallelPortControl1 equ 27ah ; Parallel Port Control
ParallelPortControl2 equ 37ah ; Parallel Port Control
ParallelPortControl3 equ 3beh ; Parallel Port Control

CgaIndex equ 3d4h ; CGA Index Register
CgaData equ 3d5h ;  CGA Data Register
ModeSelectA equ 3d8h ; Mode Select Register A
ModeSelectB equ 3deh ; Mode Select Register B

; VG230 Indexed Register
BusCycleMode equ 01h ; Bus Cycle Generator Mode Register
BusCycleWait1 equ 02h ; Bus Cycle Generator Wait State Control 1 Register
BusCycleWait2 equ 03h ; Bus Cycle Generator Wait State Control 2 Register
MemoryControl1 equ 04h ; Memory Control 1 Register
MemoryControl2 equ 05h ; Memory Control 2 Register
DisplayBufferStart equ 06h ; Alternate Display Buffer Start Address Register
LcdConfig equ 07h ; LCD Configuration Control Register
KeyMode equ 08h ; Keyboard Mode Register
KeyScanControl equ 09h ; Keyboard Scan Control Register
KeyStatusLow equ 0ah ; Keyboard Return Status Low Register
KeyStatusHigh equ 0bh ; Keyboard Return Status High Register
KeyStatus equ 0ch ;  Keyboard Shift and NMI Status Register
IcuMode equ 0dh ; ICU Mode Register
DmaMode equ 0eh ; DMA Mode Register
SioMode equ 10h ; SIO Mode Register
SioPowerControl equ 11h ; SIO Power Control Register
TimerMode equ 13h ; Timer Mode Register
PioMode equ 18h ; PIO Mode Register
Port1NmiLow equ 1ah ; Port 1 NMI Trap Address Low Register
Port1NmiHigh equ 1bh ; Port 1 NMI Trap Address High Register
Port2NmiLow equ 1ch ; Port 2 NMI Trap Address Low Register
Port2NmiHigh equ 1dh ; Port 2 NMI Trap Address High Register
Port3NmiLow equ 1eh ; Port 3 NMI Trap Address Low Register
Port3NmiHigh equ 1fh ; Port 3 NMI Trap Address High Register
CardMode equ 20h ; PC Card Controller Mode Register
Card0Control equ 21h ; PC Card Slot 0 Control Register
Card0InterruptMask equ 23h ; PC Card Slot 0 Interrupt Mask Register
Card0High equ 24h ; PC Card Slot 0 I/O High Address Register
Card0Low equ 25h ; PC Card Slot 0 I/O Low Address Register
Card0Range equ 26h ; PC Card Slot 0 I/O Address Range Register
Card1Control equ 27h ; PC Card Slot 1 Control Register
Card1InterruptMask equ 29h ; PC Card Slot 1 Interrupt Mask Register
Card1High equ 2ah ; PC Card Slot 1 I/O High Address Register
Card1Low equ 2bh ; PC Card Slot 1 I/O Low Address Register
Card1Range equ 2ch ; PC Card Slot 1 I/O Address Range Register
CardPowerControl equ 2dh ; PC Card Power Control Register
CardActivityTimer equ 2eh ; PC Card Activity Timer Register
BiosTimeBaseLow equ 30h ; BIOS Time Base Low Register
BiosTimeBaseHigh equ 31h ; BIOS Time Base High Register
GpioMode equ 32h ; GPIO Mode Register
GpioControl equ 33h ; GPIO Control Register
TopOfMemory equ 38h ; Top of Memory Register
RtcMode equ 79h ; RTC Mode Register
PmuStatus equ 0c0h ; PMU Status Register
PmuSupply equ 0c1h ; PMU Supply Register
PmuControl equ 0c2h ;  PMU Control Register
PmuMask equ 0c3h ; PMU Activity Mask Register
PmuNmiMask equ 0c4h ;  PMU NMI Mask Register
PmuRange equ 0c5h ; PMU I/O Range (IORNG) Register
PmuPowerOn equ 0c6h ; PMU POWER ON (PWRON) Register
PmuPowerDonw equ 0c7h ; PMU POWER DOZE (PWRDOZE) Register
PmuPowerSleep equ 0c8h ; PMU POWER SLEEP (PWRSLEEP) Register
PmuPowerSuspend equ 0c9h ; PMU POWER SUSPEND (PWRSUSPEND) Register
PmuPolarity equ 0cah ; PMU Polarity Register
PmuDozeTimer equ 0cch ; PMU DOZE Timer Register
PmuSleep equ 0cdh ; PMU SLEEP  Register
PmuSuspendTimer equ 0ceh ; PMU SUSPEND Timer  Register
PmuLcdTimer equ 0cfh ; PMU LCD Timer  Register
PmuLcdSequence equ 0d4h ; PMU LCD Sequence  Register

; CGA
CursorStartRaster equ 0ah ; Cursor Start Raster Register
CursorEndRaster equ 0bh ; Cursor End Raster Register
DisplayStartAddressMsb equ 0ch ;  Display Start Address MSB Register
DisplayStartAddressLsb equ 0dh ;  Display Start Address LSB Register
CursorLocationAddressMsb equ 0eh ;  Cursor Location Address MSB Register
CursorLocationAddressLsb equ 0fh ;  Cursor Location Address LSB Register
LcdDisplayControl equ 0c2h
GrayScale equ 0cbh ; Gray Scale Register
