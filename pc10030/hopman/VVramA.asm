include "VVram.inc"
include "Vram.inc"
include "Chars.inc"

ext VVram_
ext CellMap_,LeftX_,DotOffset_

ColumnCount equ 16*8
FloorCount equ 5
FloorHeight equ 4
ColumnsPerByte equ 4
MapWidth equ ColumnCount/ColumnsPerByte


; ptr<byte> VVramPtr(byte x, byte y);
cseg
VVramPtr_: public VVramPtr_
    push dx
        mov dh,al
        mov al,VVramWidth
        mul dl
        mov dl,dh
        xor dh,dh
        add ax,dx
        add ax,VVram_
    pop dx
ret


CellChars0:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight0,Char_Item_TopRight_Space0
	defb Char_Item_BottomLeft_Item_BottomRight0,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle0,Char_Needle_Needle0
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars2:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Space2
	defb Char_Floor_Floor0,Char_Floor_Space2
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor2
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Space2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor2
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Space2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle2
	defb Char_Space,Char_Space_Floor2
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight2,Char_Item_TopRight_Space2
	defb Char_Item_BottomLeft_Item_BottomRight2,Char_Space_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle2,Char_Needle_Needle2
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars4:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Space4
	defb Char_Floor_Floor0,Char_Floor_Space4
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor4
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Space4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft4
	defb Char_Space,Char_Space_Floor4
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Item_BottomLeft4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle4
	defb Char_Space,Char_Space_Floor4
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight4,Char_Item_TopRight_Space4
	defb Char_Item_BottomLeft_Item_BottomRight4,Char_Space_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle4,Char_Needle_Needle4
	defb Char_Floor_Floor0,Char_Floor_Floor0
CellChars6:
	; 0
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	; 1
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space6
	; 2
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight6,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight6,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Space6
	; 3
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle6,Char_Needle_Space6
	defb Char_Floor_Floor0,Char_Floor_Space6
	; 4
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Floor6
	; 5
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 6
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight6,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight6,Char_Space
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 7
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle6,Char_Needle_Space6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 8
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft6
	defb Char_Space,Char_Space_Item_BottomLeft6
	defb Char_Space,Char_Space_Floor6
	; 9
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft6
	defb Char_Space,Char_Space_Item_BottomLeft6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 10
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight6,Char_Space_Item_TopLeft6
	defb Char_Item_BottomLeft_Item_BottomRight6,Char_Space_Item_BottomLeft6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 11
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Item_TopLeft6
	defb Char_Needle_Needle6,Char_Needle_Item_BottomLeft6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 12
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle6
	defb Char_Space,Char_Space_Floor6
	; 13
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space_Needle6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 14
	defb Char_Space,Char_Space
	defb Char_Item_TopLeft_Item_TopRight6,Char_Space
	defb Char_Item_BottomLeft_Item_BottomRight6,Char_Space_Needle6
	defb Char_Floor_Floor0,Char_Floor_Floor0
	; 15
	defb Char_Space,Char_Space
	defb Char_Space,Char_Space
	defb Char_Needle_Needle6,Char_Needle_Needle6
	defb Char_Floor_Floor0,Char_Floor_Floor0

; void MapToVVram();
dseg
pCharTable:
    defw 0
cseg
MapToVVram_: public MapToVVram_
    push ax | push bx | push cx | push dx | push si | push di
        mov al,[DotOffset_]
        and al,7
        mov ah,8*16
        mul ah
        add ax,CellChars0
        mov [pCharTable],ax

        mov al,[LeftX_]
        shr al,1
        mov cl,al
        and cl,3 ; bit count

        shr al,1 | shr al,1
        xor ah,ah
        add ax,CellMap_
        mov si,ax
        
        mov di,VVram_+VVramWidth*StageTop
        ; mov al,
        ; do
        ;     mov byte ptr[di],Char_Space | inc di
        ;     dec al
        ; while nz | wend

        xor ch,ch ; xPos
        mov al,[LeftX_]
        and al,1
        if nz
            dec di
            dec ch
        endif

        mov bh,FloorCount
        do
            push cx
                mov dx,[si] | inc si | inc si
                mov al,cl
                or al,al
                do | while nz
                    shr dx,1 | shr dx,1
                    dec al
                wend
                mov bl,VVramWidth/2+1
                do
                    push bx | push si
                        mov al,dl
                        and al,0fh
                        mov ah,8
                        mul ah
                        add ax,[pCharTable]
                        mov si,ax

                        mov bh,FloorHeight
                        do
                            mov bl,2
                            do
                                mov al,[si] | inc si
                                cmp ch,VVramWidth ; xPos
                                if c
                                    mov [di],al
                                endif
                                inc di
                                inc ch ; xPos

                                dec bl
                            while nz | wend
                            sub ch,2 ; xPos
                            add di,VVramWidth-2
                            
                            dec bh
                        while nz | wend
                        add ch,2 ; xPos
                        add di,-VVramWidth*FloorHeight+2
                    pop si | pop bx
                    shr dx,1 | shr dx,1
                    
                    inc cl
                    and cl,3
                    if z
                        mov dh,[si] | inc si
                        xor cl,cl
                    endif
                    dec bl
                while nz | wend
                add di,-VVramWidth-2+VVramWidth*FloorHeight

                or cl,cl
                if z
                    dec si
                endif
                add si,MapWidth-(VVramWidth/2+1)/ColumnsPerByte-2
            pop cx
            dec bh
        while nz | wend
    pop di | pop si | pop dx | pop cx | pop bx | pop ax
ret
