#include "Stage.h"
#include "Stages.h"

static const Position[] Forts0 = {
	{ 72, 56 },
	{ 24, 88 },
	{ 56, 136 },
};

static const BarrierDef[] Barriers0 = {
	{ 48, 128, 16, 0 },
	{ 32, 80, 16, 1 },
};

static const Position[] Forts1 = {
	{ 40, 40 },
	{ 104, 40 },
	{ 24, 136 },
	{ 88, 136 },
};

static const BarrierDef[] Barriers1 = {
	{ 96, 32, 16, 0 },
	{ 96, 48, 16, 0 },
	{ 16, 128, 16, 0 },
	{ 16, 144, 16, 0 },
	{ 32, 32, 16, 1 },
	{ 48, 32, 16, 1 },
	{ 80, 128, 16, 1 },
	{ 96, 128, 16, 1 },
};

static const Position[] Forts2 = {
	{ 24, 24 },
	{ 104, 56 },
	{ 24, 88 },
	{ 24, 168 },
	{ 104, 168 },
};

static const BarrierDef[] Barriers2 = {
	{ 16, 32, 48, 0 },
	{ 16, 80, 16, 4 },
	{ 16, 96, 16, 4 },
	{ 32, 80, 16, 1 },
	{ 96, 128, 48, 1 },
};

static const Position[] Forts3 = {
	{ 40, 40 },
	{ 104, 40 },
	{ 24, 72 },
	{ 88, 72 },
	{ 104, 120 },
	{ 40, 152 },
	{ 88, 152 },
};

static const BarrierDef[] Barriers3 = {
	{ 16, 32, 48, 0 },
	{ 16, 48, 48, 0 },
	{ 48, 80, 48, 0 },
	{ 32, 144, 64, 0 },
	{ 32, 160, 64, 0 },
};

static const Position[] Forts4 = {
	{ 24, 24 },
	{ 88, 24 },
	{ 56, 40 },
	{ 104, 40 },
	{ 56, 168 },
};

static const BarrierDef[] Barriers4 = {
	{ 16, 64, 96, 0 },
	{ 16, 144, 32, 0 },
	{ 64, 144, 48, 0 },
	{ 16, 176, 96, 0 },
	{ 32, 48, 112, 1 },
	{ 96, 48, 112, 1 },
};

static const Position[] Forts5 = {
	{ 24, 40 },
	{ 104, 40 },
	{ 24, 88 },
	{ 104, 88 },
	{ 24, 152 },
	{ 104, 152 },
};

static const BarrierDef[] Barriers5 = {
	{ 16, 16, 160, 1 },
	{ 32, 16, 160, 1 },
	{ 96, 16, 160, 1 },
	{ 112, 16, 160, 1 },
};

static const Position[] Forts6 = {
	{ 56, 24 },
	{ 72, 72 },
	{ 24, 120 },
	{ 104, 120 },
	{ 72, 152 },
	{ 40, 168 },
};

static const BarrierDef[] Barriers6 = {
	{ 48, 32, 32, 0 },
	{ 16, 112, 96, 0 },
	{ 48, 144, 48, 0 },
	{ 16, 160, 48, 0 },
	{ 32, 16, 112, 1 },
	{ 96, 16, 112, 1 },
};

static const Position[] Forts7 = {
	{ 104, 24 },
	{ 24, 56 },
	{ 24, 120 },
	{ 104, 152 },
	{ 24, 184 },
};

static const BarrierDef[] Barriers7 = {
	{ 16, 16, 96, 0 },
	{ 16, 48, 96, 0 },
	{ 16, 80, 96, 0 },
	{ 16, 112, 96, 0 },
	{ 16, 144, 96, 0 },
	{ 16, 176, 96, 0 },
};

static const Position[] Forts8 = {
	{ 24, 24 },
	{ 104, 24 },
	{ 40, 168 },
	{ 88, 168 },
};

static const BarrierDef[] Barriers8 = {
	{ 16, 16, 32, 0 },
	{ 80, 16, 32, 0 },
	{ 64, 64, 16, 0 },
	{ 48, 112, 16, 0 },
	{ 64, 144, 16, 0 },
	{ 16, 176, 32, 0 },
	{ 80, 176, 32, 0 },
};

static const Position[] Forts9 = {
	{ 40, 40 },
	{ 88, 72 },
	{ 40, 104 },
	{ 88, 136 },
};

static const BarrierDef[] Barriers9 = {
	{ 16, 32, 96, 0 },
	{ 16, 64, 96, 0 },
	{ 16, 96, 96, 0 },
	{ 16, 128, 96, 0 },
	{ 16, 160, 96, 0 },
	{ 32, 16, 160, 1 },
	{ 64, 16, 160, 1 },
	{ 96, 16, 160, 1 },
};

const StageDef[] StageDefs = {
	{ 64, 96, 3, Forts0, 2, Barriers0 },
	{ 64, 96, 4, Forts1, 8, Barriers1 },
	{ 64, 96, 5, Forts2, 5, Barriers2 },
	{ 64, 96, 7, Forts3, 5, Barriers3 },
	{ 64, 96, 5, Forts4, 6, Barriers4 },
	{ 64, 96, 6, Forts5, 4, Barriers5 },
	{ 64, 96, 6, Forts6, 6, Barriers6 },
	{ 64, 96, 5, Forts7, 6, Barriers7 },
	{ 64, 96, 4, Forts8, 7, Barriers8 },
	{ 0, 80, 4, Forts9, 8, Barriers9 },
};
