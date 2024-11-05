name=battlot

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h Stage.h Chars.h 
Bullet.asm: Bullet.c Bullet.h Sprite.h Stage.h Direction.h Stage.h \
	Robo.h Bullet.h Fort.h Chars.h 
Direction.asm: Direction.c Direction.h 
EnemyRobo.asm: EnemyRobo.c Robo.h Bullet.h Sprite.h Main.h Fort.h \
	Stage.h Direction.h Bullet.h Bang.h Sound.h Chars.h 
Fort.asm: Fort.c Fort.h VVram.h Chars.h Stage.h Robo.h \
	Bullet.h Bang.h Sprite.h Sound.h 
Main.asm: Main.c Main.h Stage.h ScanKeys.h Status.h Sprite.h \
	Vram.h Robo.h Bullet.h Bullet.h Bang.h Fort.h \
	Sound.h 
MyRobo.asm: MyRobo.c Robo.h Bullet.h Sprite.h Direction.h Stage.h \
	ScanKeys.h Fort.h Bang.h Main.h Sound.h Chars.h \
	Vram.h 
Robo.asm: Robo.c Robo.h Bullet.h Direction.h Sprite.h Stage.h \
	Fort.h Bullet.h 
Stage.asm: Stage.c Stage.h Stages.h Main.h Sprite.h VVram.h \
	Chars.h Fort.h Robo.h Bullet.h Bullet.h Bang.h \
	Vram.h 
Stages.asm: Stages.c Stage.h Stages.h 
Status.asm: Status.c Status.h Vram.h Main.h Sprite.h Print.h \
	Chars.h 
Vram.asm: Vram.c Vram.h Sprite.h 
Print.obj: Print.asm 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm GameCom.inc 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
StageA.obj: StageA.asm 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Bang.obj Bullet.obj Direction.obj EnemyRobo.obj Fort.obj Main.obj \
	MyRobo.obj Robo.obj Stage.obj Stages.obj Status.obj Vram.obj \
	Print.obj ScanKeys.obj Sound.obj Sprite.obj StageA.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
