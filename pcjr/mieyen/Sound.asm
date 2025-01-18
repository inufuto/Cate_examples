DcsgPort equ 0c0h

Dcsg_ToneA equ 00h
Dcsg_VolumeA equ 10h
Dcsg_ToneB equ 20h
Dcsg_VolumeB equ 30h
Dcsg_ToneC equ 40h
Dcsg_VolumeC equ 50h
Dcsg_NoiseControl equ 60h
Dcsg_NoiseVolume equ 70h

MinVolume equ 63

tempo equ 180

count equ 3
Channel_Ptr equ 0
Channel_Start equ Channel_Ptr+2
Channel_Len equ Channel_Start+2
Channel_Vol equ Channel_Len+1
unitSize equ Channel_Vol+1

dseg
Channels: public Channels
    defs unitSize*count
time:
    defw 0


cseg
InitSound: public InitSound
    mov word ptr[time],0
    call StopBGM_
ret


SoundHandler: public SoundHandler
    mov ax,[time]
    sub ax,tempo
    if c
        push ax | push bx | push dx | push si
            mov si,Channels
            mov dx,(count * 100h) or Dcsg_ToneA   ; dh = count; dl = register
            do
                mov bx,[si+Channel_Ptr]
                or bx,bx
                if nz
                    dec byte ptr[si+Channel_Len]
                    if z
                        continue:
                        mov al,[bx]
                        or al,al
                        if z
                            ; end
                            mov word ptr[si+Channel_Ptr],0
                            mov al,dl
                            or al,9fh
                            out DcsgPort,al
                            jmp next
                        endif
                        inc al
                        if z 
                            ; repeat
                            mov bx,[si+Channel_Start]
                            jmp continue
                        endif
                        dec al
                        mov [si+Channel_Len],al
                        inc bx
                        mov al,[bx] | inc bx
                        mov [si+Channel_Ptr],bx
                        or al,al
                        if nz
                            add al,al
                            xor ah,ah
                            add ax,cycles
                            push bx
                                mov bx,ax
                                mov al,dl
                                or al,80h
                                or al,[bx]
                                out DcsgPort,al
                                inc bx
                                mov al,[bx]
                                out DcsgPort,al
                                cmp dl,Dcsg_ToneC
                                if z
                                    mov al,4
                                else
                                    xor al,al
                                endif
                            pop bx
                            mov [si+Channel_Vol],al
                        else
                            mov byte ptr [si+Channel_Vol],MinVolume
                        endif
                        EndWriteCycle:
                    endif
                    mov al,[si+Channel_Vol]
                    shr al,1 | shr al,1
                    or al,dl
                    or al,90h
                    out DcsgPort,al
                    mov al,[si+Channel_Vol]
                    cmp al,MinVolume
                    if nz
                        inc al
                        mov [si+Channel_Vol],al
                    endif
                endif
                next:
                add dl,20h
                add si,unitSize
                
                dec dh
            while nz | wend
        pop si | pop dx | pop bx | pop ax
        add ax,600/2
    endif
    mov [time],ax
ret


Melody:
    cli
        mov [Channels+unitSize*0+Channel_Ptr],bx
        mov byte ptr [Channels+unitSize*0+Channel_Len],1
    sti
ret

MelodyWait:
    call Melody
    do
        cmp word ptr [Channels+unitSize*0+Channel_Ptr],0
    while nz | wend
ret 


loose_notes:
    defb 1,A3, 0
Sound_Loose_: public Sound_Loose_
    push bx
        mov bx,loose_notes
        call MelodyWait
    pop bx
ret


hit_notes:
    defb 1,F4, 1,G4, 1,A4, 1,B4, 1,C5, 1,D5, 1,E5, 1,F5
    defb 0 
Sound_Hit_: public Sound_Hit_
    push bx
        mov bx,hit_notes
        call Melody
    pop bx
ret


stole_notes:
    defb 1,F5, 1,E5, 1,D5, 1,C5, 1,B4, 1,A4, 1,G4, 1,F4, 0
    defb 0 
Sound_Stole_: public Sound_Stole_
    push bx
        mov bx,stole_notes
        call Melody
    pop bx
ret


fire_notes:
    defb 1,F5, 1,D5S, 1,C5S, 1,B4, 1,A4, 1,G5, 0
Sound_Fire_: public Sound_Fire_
    push bx
        mov bx,fire_notes
        call Melody
    pop bx
ret


bonus_notes:
    defb 1,C4, 1, C4S, 1,D4, 1,F4, 1,A4, 1,C5, 0
Sound_Bonus_: public Sound_Bonus_
    push bx
        mov bx,bonus_notes
        call Melody
    pop bx
ret


start_notes: 
    defb N4,C4, N4,E4, N8,G4, N4,E4, N4,F4
    defb N8,F4, N4,A4, N8,C5, N4P,A4 
    defb N2P,C5, N4,0
    defb 0
Sound_Start_: public Sound_Start_
    push bx
        mov bx,start_notes
        call MelodyWait
    pop bx
ret

clear_notes: 
    defb N8,A4, N8,A4, N8,G4, N8,F4, N8,G4, N4,A4, N4,B4
    defb N8,B4, N8,A4, N8,G4, N8,A4, N4,B4, N8+N2,C5, N2,0
    defb 0
Sound_Clear_: public Sound_Clear_
    push bx
        mov bx,clear_notes
        call MelodyWait
    pop bx
ret

over_notes: 
    defb N8,C5, N8,F4, N8,A4, N8,E4,  N8,G4, N8,A4, N8,B4, N8,C5
    defb N2P,C5, N4,0
    defb 0
Sound_GameOver_: public Sound_GameOver_
    push bx
        mov bx,over_notes
        call MelodyWait
    pop bx
ret


BGM_B:
    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,D4, N4,D4, N8,D4, N4,E4, N4P,D4
    defb N2P,0

    defb N4,C4, N4,G4, N8,C4, N4,G4, N4,A4
    defb N8,A4, N8,G4, N8,G4, N8,F4, N8,F4, N8,E4, N8,E4
    defb N4,F4, N4,F4, N8,F4, N4,A4, N4P,G4
    defb N2P,0

    defb N8,E4, N8,E4, N8,E4, N4,E4, N8,E4, N4,A4
    defb N8,D4, N8,D4, N8,D4, N4,D4, N8,D4, N4,G4
    defb N8,0, N8,A4, N8,0, N8,G4, N8,0, N8,F4, N8,0, N8,E4
    defb N4,D4, N4,E4, N2,C4

    defb 0ffh
BGM_C:
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 3
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 4
    defb N8,D3, N4,0, N4P,F3, N8,A3, N8,0; 5
    defb N8,G3, N4,0, N4P,B2, N8,D3, N8,0; 6

    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 7
    defb N8,A2, N4,0, N4P,C3, N8,E3, N8,0; 8
    defb N8,F3, N4,0, N8,F3, N8,G3, N4,0, N8,G3; 9
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 10

    defb N8,C3, N4,0, N8,C3, N8,A2, N4,0, N8,A2; 11
    defb N8,D3, N4,0, N8,D3, N8,G3, N4,0, N8,G3; 12
    defb N8,0, N8,F3, N8,0, N8,F3, N8,0, N8,G3, N8,0, N8,G3
    defb N8,C3, N4,0, N4P,E3, N8,G3, N8,0; 14

    defb 0ffh

StartBGM_: public StartBGM_
    push ax | push bx
        cli
            mov al,1
            mov bx,BGM_B
            mov [Channels+unitSize*1+Channel_Start],bx
            mov [Channels+unitSize*1+Channel_Ptr],bx
            mov [Channels+unitSize*1+Channel_Len],al
            mov bx,BGM_C
            mov [Channels+unitSize*2+Channel_Start],bx
            mov [Channels+unitSize*2+Channel_Ptr],bx
            mov [Channels+unitSize*2+Channel_Len],al
        sti
    pop bx | pop ax
ret

StopBGM_: public StopBGM_

    push ax | push cx
        cli
            xor ax,ax
            mov [Channels+unitSize*1+Channel_Ptr],ax
            mov [Channels+unitSize*2+Channel_Ptr],ax
            mov cl,3
            mov al,Dcsg_VolumeB or 8fh
            do
                out DcsgPort,al
                add al,20h
                dec cl
            while nz | wend
        sti
    pop cx | pop ax
ret


A2 equ 1
A2S equ 2
B2 equ 3
C3 equ 4
C3S equ 5
D3 equ 6
D3S equ 7
E3 equ 8
F3 equ 9
F3S equ 10
G3 equ 11
G3S equ 12
A3 equ 13
A3S equ 14
B3 equ 15
C4 equ 16
C4S equ 17
D4 equ 18
D4S equ 19
E4 equ 20
F4 equ 21
F4S equ 22
G4 equ 23
G4S equ 24
A4 equ 25
A4S equ 26
B4 equ 27
C5 equ 28
C5S equ 29
D5 equ 30
D5S equ 31
E5 equ 32
F5 equ 33
F5S equ 34
G5 equ 35

N8 equ 6
N8P equ N8*3/2
N4 equ N8*2
N4P equ N4*3/2
N2 equ N4*2
N2P equ N2*3/2
N1 equ N2*2

cycles:
defb 8,63 ; A2
defb 15,59 ; A#2
defb 9,56 ; B2
defb 7,53 ; C3
defb 7,50 ; C#3
defb 9,47 ; D3
defb 15,44 ; D#3
defb 6,42 ; E3
defb 0,40 ; F3
defb 12,37 ; F#3
defb 10,35 ; G3
defb 10,33 ; G#3
defb 12,31 ; A3
defb 15,29 ; A#3
defb 4,28 ; B3
defb 11,26 ; C4
defb 3,25 ; C#4
defb 12,23 ; D4
defb 7,22 ; D#4
defb 3,21 ; E4
defb 0,20 ; F4
defb 14,18 ; F#4
defb 13,17 ; G4
defb 13,16 ; G#4
defb 14,15 ; A4
defb 15,14 ; A#4
defb 2,14 ; B4
defb 5,13 ; C5
defb 9,12 ; C#5
defb 14,11 ; D5
defb 3,11 ; D#5
defb 9,10 ; E5
defb 0,10 ; F5
defb 7,9 ; F#5
defb 14,8 ; G5
