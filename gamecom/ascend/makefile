name=ascend

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00c0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Actor.asm: Actor.c Movable.h Actor.h Stage.h Block.h Sprite.h \
	Movable.h Man.h 
Block.asm: Block.c Movable.h Sprite.h Movable.h Actor.h Block.h \
	Chars.h Stage.h Stages.h Vram.h Man.h VVram.h 
Fire.asm: Fire.c Movable.h Sprite.h Movable.h Actor.h Fire.h \
	Chars.h Math.h Main.h Stage.h Man.h VVram.h 
Main.asm: Main.c Main.h ScanKeys.h Vram.h Sound.h Status.h \
	Movable.h Actor.h Stage.h Sprite.h Movable.h Man.h \
	Fire.h Monster.h Print.h 
Man.asm: Man.c Movable.h Sprite.h Movable.h Actor.h Man.h \
	Stage.h Chars.h ScanKeys.h VVram.h Block.h Sound.h \
	Main.h Fire.h Status.h 
Monster.asm: Monster.c Movable.h Sprite.h Movable.h Actor.h Monster.h \
	Chars.h Math.h Main.h Stage.h Man.h VVram.h 
Movable.asm: Movable.c Movable.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Chars.h Status.h \
	Movable.h Actor.h Man.h Sprite.h Movable.h Stage.h \
	Fire.h Monster.h Block.h Math.h VVram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Movable.h \
	Print.h Chars.h 
Vram.asm: Vram.c Vram.h VVram.h Sprite.h Movable.h 
Math.obj: Math.asm 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc 
VVramA.obj: VVramA.asm VVram.inc VVram.inc Chars.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Actor.obj Block.obj Fire.obj Main.obj Man.obj Monster.obj \
	Movable.obj Stage.obj Stages.obj Status.obj Vram.obj Math.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
