name=ruptus

all: $(name).bin

cseg=2000-2053,4000-9fff,2054-3fda,3fdc
dseg=0200
zseg=00d0

.c.asm:
	Cate85.exe $*.c

.asm.obj:
	Asm85.exe $*.asm

Bang.asm: Bang.c Bang.h Sprite.h VVram.h Stage.h Chars.h 
Barrier.asm: Barrier.c Barrier.h Stage.h Stages.h VVram.h Chars.h \
	Sprite.h Bang.h Main.h Mover.h Sound.h 
Direction.asm: Direction.c Direction.h 
Enemy.asm: Enemy.c Enemy.h Stage.h Fighter.h VVram.h Sprite.h \
	Chars.h Direction.h Main.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Sound.h 
EnemyBullet.asm: EnemyBullet.c EnemyBullet.h Enemy.h Sprite.h Enemy.h Stage.h \
	VVram.h Chars.h Direction.h Fighter.h Barrier.h Stage.h \
	Fort.h Stage.h 
Fighter.asm: Fighter.c Fighter.h Stage.h Sprite.h VVram.h Chars.h \
	Direction.h ScanKeys.h FighterBullet.h Bang.h Barrier.h Stage.h \
	Fort.h Stage.h Mover.h Item.h Main.h Status.h \
	Sound.h Vram.h Rader.h 
FighterBullet.asm: FighterBullet.c FighterBullet.h Sprite.h Fighter.h Stage.h VVram.h \
	Chars.h Direction.h Enemy.h Main.h Barrier.h Stage.h \
	Fort.h Stage.h Sound.h 
Fort.asm: Fort.c Fort.h Stage.h Stages.h VVram.h Chars.h \
	Bang.h Main.h Mover.h Sound.h Rader.h 
Item.asm: Item.c Item.h Stage.h VVram.h Sprite.h Chars.h \
	Mover.h 
Main.asm: Main.c Main.h ScanKeys.h Stage.h Vram.h Sprite.h \
	VVram.h Fort.h Stage.h Fighter.h Barrier.h Stage.h \
	Star.h Enemy.h FighterBullet.h EnemyBullet.h Enemy.h Status.h \
	Bang.h Item.h Sound.h 
Mover.asm: Mover.c Mover.h 
Rader.asm: Rader.c Rader.h Vram.h VVram.h 
Stage.asm: Stage.c Stage.h Stages.h VVram.h Fighter.h Fort.h \
	Stage.h Barrier.h Stage.h Enemy.h FighterBullet.h Bang.h \
	Sprite.h EnemyBullet.h Enemy.h Item.h 
Stages.asm: Stages.c Stage.h Stages.h 
Star.asm: Star.c Star.h Fighter.h VVram.h Chars.h 
Status.asm: Status.c Status.h Vram.h Stage.h Main.h Chars.h \
	Print.h Sprite.h VVram.h 
Vram.asm: Vram.c Vram.h Chars.h VVram.h Star.h Barrier.h \
	Stage.h Fort.h Stage.h Sprite.h 
VVram.asm: VVram.c VVram.h Chars.h 
Print.obj: Print.asm 
RaderA.obj: RaderA.asm GameCom.inc Vram.inc VVram.inc Chars.inc 
RomChars.obj: RomChars.asm 
RomHead.obj: RomHead.asm GameCom.inc 
ScanKeys.obj: ScanKeys.asm GameCom.inc 
Sound.obj: Sound.asm GameCom.inc 
Sprite.obj: Sprite.asm GameCom.inc Vram.inc VVram.inc 
Startup.obj: Startup.asm GameCom.inc Vram.inc 
Vectors.obj: Vectors.asm 
VramA.obj: VramA.asm GameCom.inc Vram.inc VVram.inc Chars.inc 
VVramA.obj: VVramA.asm VVram.inc 

objects = Vectors.obj RomHead.obj RomChars.obj Startup.obj \
	Bang.obj Barrier.obj Direction.obj Enemy.obj EnemyBullet.obj Fighter.obj \
	FighterBullet.obj Fort.obj Item.obj Main.obj Mover.obj Rader.obj \
	Stage.obj Stages.obj Star.obj Status.obj Vram.obj VVram.obj \
	Print.obj RaderA.obj ScanKeys.obj Sound.obj Sprite.obj VramA.obj \
	VVramA.obj \
	..\..\cate\cate85.lib

_.bin: $(objects) makefile
	LinkBE.exe _.bin $(cseg) $(dseg) $(zseg) $(objects)
	copy _.symbols.txt $(name).symbols.txt /y

$(name).bin: _.bin MakeRom.csx
	dotnet script MakeRom.csx $(name)
