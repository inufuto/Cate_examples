
Char.Man.Stop.Left equ 0
Char.Man.Remain equ Char.Man.Stop.Left
Char.Man.Left.0 equ Char.Man.Stop.Left+4
Char.Man.Left.1 equ Char.Man.Left.0+4
Char.Man.Left.2 equ Char.Man.Left.1+4

Char.Man.Stop.Right equ Char.Man.Left.2+4
Char.Man.Right.0 equ Char.Man.Stop.Right+4
Char.Man.Right.1 equ Char.Man.Right.0+4
Char.Man.Right.2 equ Char.Man.Right.1+4

Char.Man.Stop.Up equ Char.Man.Right.2+4
Char.Man.Up.0 equ Char.Man.Stop.Up+4
Char.Man.Up.1 equ Char.Man.Up.0+4
Char.Man.Up.2 equ Char.Man.Up.1+4

Char.Man.Stop.Down equ Char.Man.Up.2+4
Char.Man.Down.0 equ Char.Man.Stop.Down+4
Char.Man.Down.1 equ Char.Man.Down.0+4
Char.Man.Down.2 equ Char.Man.Down.1+4

Char.Chaser equ Char.Man.Down.2+4
Char.Disturber equ Char.Chaser+4
Char.Goal equ Char.Disturber+4
Char.Bang equ Char.Goal+4
Char.Man.Die.2 equ Char.Bang+4
Char.Man.Die.3 equ Char.Man.Die.2+4

Char.Kn.Left equ Char.Man.Die.3+4
Char.Kn.Right equ Char.Kn.Left+1
Char.Kn.Up equ Char.Kn.Right+1
Char.Kn.Down equ Char.Kn.Up+1
Char.Wall equ Char.Kn.Down+1
Char.Space equ Char.Wall+1

Char.Title equ Char.Space+1

Char.Ascii equ Char.Title+4*4
