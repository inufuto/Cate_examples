#include "Stage.h"
#include "Stages.h"

static const Position[] Forts0 = {
	{ 56, 40 },
	{ 24, 56 },
	{ 40, 88 },
};

static const BarrierDef[] Barriers0 = {
	{ 32, 80, 16, 0 },
	{ 32, 48, 16, 1 },
};

static const Position[] Forts1 = {
	{ 40, 24 },
	{ 88, 24 },
	{ 24, 88 },
	{ 72, 88 },
};

static const BarrierDef[] Barriers1 = {
	{ 80, 16, 16, 0 },
	{ 80, 32, 16, 0 },
	{ 16, 80, 16, 0 },
	{ 16, 96, 16, 0 },
	{ 32, 16, 16, 1 },
	{ 48, 16, 16, 1 },
	{ 64, 80, 16, 1 },
	{ 80, 80, 16, 1 },
};

static const Position[] Forts2 = {
	{ 24, 24 },
	{ 88, 40 },
	{ 24, 56 },
	{ 24, 104 },
	{ 88, 104 },
};

static const BarrierDef[] Barriers2 = {
	{ 16, 32, 32, 0 },
	{ 16, 48, 16, 4 },
	{ 16, 64, 16, 4 },
	{ 32, 48, 16, 1 },
	{ 80, 80, 32, 1 },
};

static const Position[] Forts3 = {
	{ 40, 24 },
	{ 88, 24 },
	{ 24, 56 },
	{ 72, 56 },
	{ 88, 88 },
	{ 40, 104 },
	{ 72, 104 },
};

static const BarrierDef[] Barriers3 = {
	{ 16, 16, 32, 0 },
	{ 16, 32, 32, 0 },
	{ 32, 48, 48, 0 },
	{ 32, 96, 48, 0 },
	{ 32, 112, 48, 0 },
};

static const Position[] Forts4 = {
	{ 24, 24 },
	{ 40, 24 },
	{ 72, 24 },
	{ 88, 24 },
	{ 40, 104 },
};

static const BarrierDef[] Barriers4 = {
	{ 16, 48, 80, 0 },
	{ 16, 96, 32, 0 },
	{ 64, 96, 32, 0 },
	{ 32, 32, 80, 1 },
	{ 80, 32, 80, 1 },
};

static const Position[] Forts5 = {
	{ 24, 24 },
	{ 72, 24 },
	{ 24, 56 },
	{ 72, 56 },
	{ 24, 104 },
	{ 72, 104 },
};

static const BarrierDef[] Barriers5 = {
	{ 16, 16, 96, 1 },
	{ 32, 16, 96, 1 },
	{ 64, 16, 96, 1 },
	{ 80, 16, 96, 1 },
};

static const Position[] Forts6 = {
	{ 40, 24 },
	{ 56, 56 },
	{ 24, 88 },
	{ 88, 88 },
	{ 56, 104 },
	{ 40, 120 },
};

static const BarrierDef[] Barriers6 = {
	{ 32, 32, 32, 0 },
	{ 16, 80, 64, 0 },
	{ 48, 96, 16, 0 },
	{ 16, 112, 32, 0 },
	{ 32, 16, 80, 1 },
	{ 80, 16, 80, 1 },
};

static const Position[] Forts7 = {
	{ 72, 24 },
	{ 24, 40 },
	{ 24, 88 },
	{ 24, 104 },
	{ 72, 104 },
};

static const BarrierDef[] Barriers7 = {
	{ 16, 16, 64, 0 },
	{ 16, 32, 64, 0 },
	{ 16, 64, 32, 0 },
	{ 64, 64, 16, 0 },
	{ 16, 80, 32, 0 },
	{ 64, 80, 16, 0 },
	{ 16, 96, 64, 0 },
};

static const Position[] Forts8 = {
	{ 24, 24 },
	{ 72, 24 },
	{ 40, 104 },
	{ 72, 104 },
};

static const BarrierDef[] Barriers8 = {
	{ 16, 16, 32, 0 },
	{ 64, 16, 16, 0 },
	{ 48, 48, 16, 0 },
	{ 32, 80, 16, 2 },
	{ 16, 112, 32, 0 },
	{ 64, 112, 16, 0 },
	{ 32, 80, 16, 1 },
};

static const Position[] Forts9 = {
	{ 40, 24 },
	{ 72, 56 },
	{ 40, 72 },
	{ 72, 88 },
};

static const BarrierDef[] Barriers9 = {
	{ 16, 32, 64, 0 },
	{ 16, 48, 64, 0 },
	{ 16, 64, 64, 0 },
	{ 16, 96, 64, 4 },
	{ 16, 112, 64, 4 },
	{ 32, 16, 96, 1 },
	{ 48, 16, 96, 1 },
	{ 80, 96, 16, 1 },
};

const StageDef[] StageDefs = {
	{ 48, 64, 3, Forts0, 2, Barriers0 },
	{ 48, 64, 4, Forts1, 8, Barriers1 },
	{ 48, 64, 5, Forts2, 5, Barriers2 },
	{ 48, 64, 7, Forts3, 5, Barriers3 },
	{ 48, 64, 5, Forts4, 5, Barriers4 },
	{ 48, 64, 6, Forts5, 4, Barriers5 },
	{ 48, 64, 6, Forts6, 6, Barriers6 },
	{ 48, 64, 5, Forts7, 7, Barriers7 },
	{ 48, 64, 4, Forts8, 7, Barriers8 },
	{ 0, 48, 4, Forts9, 8, Barriers9 },
};
