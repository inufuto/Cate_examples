LCD_X_Size equ $2000
LCD_Y_Size equ $2001
X_Scroll equ $2002
Y_Scroll equ $2003

DmaSource equ $2008
DmaDestination equ $200a
DmaLength equ $200c
DmaControl equ $200d

CH1_Flow equ $2010
CH1_Fhi equ $2011
CH1_Vol_Duty equ $2012
CH1_Length equ $2013
CH2_Flow equ $2014
CH2_Fhi equ $2015
CH2_Vol_Duty equ $2016
CH2_Length equ $2017
CH3_Addrlow equ $2018
CH3_Addrehi equ $2019
CH3_Length equ $201a
CH3_Control equ $201b
CH3_Trigger equ $201c
IRQTimer equ $2023
ResetIRQTimerFlag equ $2024
IRQStatus equ $2027
CH4_Freq_Vol equ $2028
CH4_Length equ $2029
CH4_Control equ $202a

Controller equ $2020
SystemControl equ $2026
