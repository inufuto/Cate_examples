ext WaitTimer_

WaitSound:
    do
        offiw $80,$01
    repeat
ret


; void Sound_Beep();
cseg
beep_notes:
    defb A4,1
    defb $ff
Sound_Beep_: public Sound_Beep_
    push v | push h | push b
        lxi h,beep_notes
        calt $86
    pop b | pop h | pop v
ret


; void Sound_Get();
cseg
Sound_Get_: public Sound_Get_
    push v | push h | push b
        lxi h,beep_notes
        calt $86
        call WaitSound
    pop b | pop h | pop v
ret


; void Sound_Loose();
cseg
loose_notes:
    defb C4,1
    defb $ff
Sound_Loose_: public Sound_Loose_
    push v | push h | push b
        lxi h,loose_notes
        calt $86
        call WaitSound
    pop b | pop h | pop v
ret


; void Sound_Hit();
cseg
hit_notes:
    defb F4,1, G4,1, A4,1, B4,1, C5,1, D5,1, E5,1, F5,1
    defb $ff
Sound_Hit_: public Sound_Hit_
    push v | push h | push b
        lxi h,hit_notes
        calt $86
    pop b | pop h | pop v
ret


; void Sound_Start();
cseg
start_notes:
    defb C4,9,0,1, G4,9,0,1, E4,9,0,1, G4,9,0,1, C5,42,0,1
    defb $ff
Sound_Start_: public Sound_Start_
    push v | push h | push b
        lxi h,start_notes
        calt $86
        call WaitSound
    pop b | pop h | pop v
ret


; void Sound_Clear();
cseg
clear_notes:
	defb C4,9,0,1, E4,9,0,1, G4,9,0,1, D4,9,0,1, F4,9,0,1, A4,9,0,1, E4,9,0,1, G4,9,0,1
	defb B4,9,0,1, C5,31,0,1
    defb $ff
Sound_Clear_: public Sound_Clear_
    push v | push h | push b
        lxi h,clear_notes
        calt $86
        call WaitSound
    pop b | pop h | pop v
ret


; void Sound_GameOver();
cseg
over_notes:
	defb C5,9,0,1, G4,9,0,1, E4,9,0,1, C5,9,0,1, B4,9,0,1, G4,9,0,1, E4,9,0,1, B4,9,0,1
	defb A4,20,0,1, B4,20,0,1, C5,42,0,1
    defb $ff
Sound_GameOver_: public Sound_GameOver_
    push v | push h | push b
        lxi h,over_notes
        calt $86
        call WaitSound
    pop b | pop h | pop v
ret



C4 equ 1
C4S equ 2
D4 equ 3
D4S equ 4
E4 equ 5
F4 equ 6
F4S equ 7
G4 equ 8
G4S equ 9
A4 equ 10
A4S equ 11
B4 equ 12
C5 equ 13
C5S equ 14
D5 equ 15
D5S equ 16
E5 equ 17
F5 equ 18
F5S equ 19
G5 equ 20
