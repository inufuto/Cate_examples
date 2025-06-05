name=mazy2

all: $(name).bin

# Physical Address: 40000

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Knife.asm: Knife.c Knife.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Man.h Movable.h Main.h Status.h \
	Sound.h Math.h Monster.h Movable.h Point.h Movable.h 
Main.asm: Main.c Main.h Vram.h Chars.h Status.h ScanKeys.h \
	Stage.h Sound.h Sprite.h Movable.h Man.h Movable.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h 
Man.asm: Man.c Man.h Movable.h Sprite.h Movable.h Stage.h \
	Chars.h ScanKeys.h Knife.h Movable.h Sound.h Vram.h 
Monster.asm: Monster.c Monster.h Movable.h Stages.h Stage.h Sprite.h \
	Movable.h Chars.h Math.h Man.h Movable.h Knife.h \
	Movable.h Sound.h Point.h Movable.h 
Movable.asm: Movable.c Movable.h Stage.h 
Point.asm: Point.c Point.h Movable.h Sprite.h Movable.h Main.h \
	Chars.h 
Stage.asm: Stage.c Stage.h Stages.h Stage.h Main.h Sprite.h \
	Movable.h Vram.h Status.h Man.h Movable.h Chars.h \
	Monster.h Movable.h Knife.h Movable.h Point.h Movable.h \
	VVram.h 
Stages.asm: Stages.c Stage.h Stages.h Stage.h 
Status.asm: Status.c Status.h Vram.h Main.h Print.h Chars.h \
	Sprite.h Movable.h 
Vram.asm: Vram.c Vram.h Sprite.h Movable.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Knife.obj Main.obj Man.obj Monster.obj Movable.obj Point.obj \
	Stage.obj Stages.obj Status.obj Vram.obj Math.obj Print.obj \
	ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
