Zp.Free equ $00f0

Zp.TmpX0 equ Zp.Free
Zp.TmpX0.low equ Zp.TmpX0
Zp.TmpX0.high equ Zp.TmpX0+1
Zp.TmpX1 equ Zp.TmpX0+2
Zp.TmpX1.low equ Zp.TmpX1
Zp.TmpX1.high equ Zp.TmpX1+1
Zp.Counter0 equ Zp.TmpX1+2
Zp.Counter1 equ Zp.Counter0+1
Zp.X equ Zp.Counter1+1
Zp.Y equ Zp.X+1
Zp.Word equ Zp.Y+1
Zp.Word.low equ Zp.Word
Zp.Word.high equ Zp.Word+1
Zp.Byte equ Zp.Word+2
Zp.Byte2 equ Zp.Byte+1
Zp.Byte3 equ Zp.Byte2+1