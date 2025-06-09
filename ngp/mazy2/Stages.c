#include "Stage.h"
#include "Stages.h"

static const byte[] Stairs00 = {
	(5 << 4) | 2,
	(2 << 4) | 4,
};

static const byte[] Monsters00 = {
	(3 << 4) | 0, 0x02,
	(5 << 4) | 0, 0x01,
	(4 << 4) | 1, 0x02,
	(4 << 4) | 3, 0x01,
};

static const byte[] Knives00 = {
	(1 << 4) | 0,
	(0 << 4) | 4,
};

static const byte[] Monsters01 = {
	(0 << 4) | 4, 0x00,
	(3 << 4) | 4, 0x02,
};

static const byte[] Knives01 = {
	(4 << 4) | 0,
	(1 << 4) | 2,
};

static const Floor[] Floors0 = {
	{
		{
			0x25, 0x06, 
			0x58, 0x05, 
			0xec, 0x0d, 
			0xa1, 0x0c, 
			0xbb, 0x0e, 
		},
		2, Stairs00,
		4, Monsters00,
		2, Knives00,
	},
	{
		{
			0x28, 0x0c, 
			0x61, 0x06, 
			0x5d, 0x06, 
			0x71, 0x0c, 
			0xfa, 0x0e, 
		},
		0, nullptr,
		2, Monsters01,
		2, Knives01,
	},
};
static const byte[] Stairs10 = {
	(5 << 4) | 0,
	(0 << 4) | 1,
	(5 << 4) | 3,
	(0 << 4) | 4,
	(3 << 4) | 4,
};

static const byte[] Monsters10 = {
	(0 << 4) | 0, 0x01,
	(4 << 4) | 2, 0x02,
};

static const byte[] Knives10 = {
	(3 << 4) | 0,
	(2 << 4) | 3,
};

static const byte[] Monsters11 = {
	(1 << 4) | 1, 0x02,
	(2 << 4) | 1, 0x02,
	(5 << 4) | 1, 0x00,
};

static const Floor[] Floors1 = {
	{
		{
			0xb0, 0x0e, 
			0x1b, 0x04, 
			0x71, 0x07, 
			0xa5, 0x0d, 
			0xeb, 0x0e, 
		},
		5, Stairs10,
		2, Monsters10,
		2, Knives10,
	},
	{
		{
			0x32, 0x05, 
			0x61, 0x04, 
			0x55, 0x0d, 
			0xe5, 0x05, 
			0xeb, 0x0e, 
		},
		0, nullptr,
		3, Monsters11,
		0, nullptr,
	},
};
static const byte[] Stairs20 = {
	(2 << 4) | 0,
	(4 << 4) | 4,
};

static const byte[] Monsters20 = {
	(1 << 4) | 0, 0x01,
	(4 << 4) | 0, 0x01,
	(3 << 4) | 1, 0x02,
	(3 << 4) | 4, 0x02,
};

static const byte[] Knives20 = {
	(1 << 4) | 2,
	(2 << 4) | 4,
};

static const byte[] Stairs21 = {
	(4 << 4) | 0,
	(1 << 4) | 2,
	(3 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters21 = {
	(3 << 4) | 0, 0x02,
	(3 << 4) | 2, 0x02,
	(2 << 4) | 4, 0x02,
};

static const byte[] Knives21 = {
	(4 << 4) | 3,
};

static const byte[] Monsters22 = {
	(2 << 4) | 1, 0x01,
	(3 << 4) | 2, 0x02,
	(2 << 4) | 3, 0x02,
	(0 << 4) | 4, 0x02,
};

static const byte[] Knives22 = {
	(4 << 4) | 4,
};

static const Floor[] Floors2 = {
	{
		{
			0xa4, 0x0e, 
			0x19, 0x06, 
			0xec, 0x04, 
			0x26, 0x0d, 
			0xfa, 0x0e, 
		},
		2, Stairs20,
		4, Monsters20,
		2, Knives20,
	},
	{
		{
			0x54, 0x0d, 
			0xe9, 0x04, 
			0x8c, 0x07, 
			0x69, 0x0e, 
			0xfa, 0x0e, 
		},
		4, Stairs21,
		3, Monsters21,
		1, Knives21,
	},
	{
		{
			0x64, 0x06, 
			0x19, 0x06, 
			0xe5, 0x0e, 
			0x25, 0x06, 
			0xba, 0x0f, 
		},
		0, nullptr,
		4, Monsters22,
		1, Knives22,
	},
};
static const byte[] Stairs30 = {
	(5 << 4) | 1,
	(3 << 4) | 2,
	(5 << 4) | 2,
	(2 << 4) | 4,
	(4 << 4) | 4,
};

static const byte[] Monsters30 = {
	(3 << 4) | 0, 0x02,
	(2 << 4) | 2, 0x01,
};

static const byte[] Knives30 = {
	(3 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Stairs31 = {
	(0 << 4) | 0,
	(1 << 4) | 0,
	(3 << 4) | 0,
	(3 << 4) | 1,
	(2 << 4) | 2,
	(0 << 4) | 3,
	(3 << 4) | 3,
	(5 << 4) | 4,
};

static const byte[] Monsters31 = {
	(1 << 4) | 1, 0x02,
	(0 << 4) | 4, 0x02,
	(1 << 4) | 4, 0x02,
};

static const byte[] Monsters32 = {
	(3 << 4) | 2, 0x00,
};

static const byte[] Knives32 = {
	(5 << 4) | 2,
};

static const Floor[] Floors3 = {
	{
		{
			0xc9, 0x0c, 
			0x64, 0x0e, 
			0x15, 0x0e, 
			0x65, 0x04, 
			0xfb, 0x0f, 
		},
		5, Stairs30,
		2, Monsters30,
		2, Knives30,
	},
	{
		{
			0x9e, 0x06, 
			0x9c, 0x0d, 
			0xe2, 0x0e, 
			0x55, 0x04, 
			0xee, 0x0f, 
		},
		8, Stairs31,
		3, Monsters31,
		0, nullptr,
	},
	{
		{
			0xe9, 0x06, 
			0xa6, 0x04, 
			0x45, 0x0f, 
			0x95, 0x04, 
			0xbe, 0x0f, 
		},
		0, nullptr,
		1, Monsters32,
		1, Knives32,
	},
};
static const byte[] Stairs40 = {
	(5 << 4) | 2,
	(0 << 4) | 3,
};

static const byte[] Monsters40 = {
	(4 << 4) | 0, 0x01,
	(3 << 4) | 1, 0x02,
	(3 << 4) | 4, 0x02,
	(4 << 4) | 4, 0x02,
	(5 << 4) | 4, 0x02,
};

static const byte[] Knives40 = {
	(3 << 4) | 2,
};

static const byte[] Stairs41 = {
	(5 << 4) | 0,
	(0 << 4) | 4,
};

static const byte[] Monsters41 = {
	(4 << 4) | 3, 0x02,
};

static const byte[] Knives41 = {
	(4 << 4) | 1,
};

static const byte[] Stairs42 = {
	(0 << 4) | 3,
	(4 << 4) | 4,
};

static const byte[] Monsters42 = {
	(1 << 4) | 2, 0x02,
	(3 << 4) | 4, 0x01,
};

static const byte[] Knives42 = {
	(4 << 4) | 2,
};

static const byte[] Monsters43 = {
	(2 << 4) | 0, 0x01,
	(1 << 4) | 2, 0x02,
};

static const byte[] Knives43 = {
	(5 << 4) | 2,
};

static const Floor[] Floors4 = {
	{
		{
			0x26, 0x04, 
			0xe8, 0x05, 
			0xea, 0x0f, 
			0x61, 0x0c, 
			0xae, 0x0e, 
		},
		2, Stairs40,
		5, Monsters40,
		1, Knives40,
	},
	{
		{
			0x42, 0x04, 
			0xd7, 0x05, 
			0xce, 0x07, 
			0xe9, 0x0e, 
			0xbb, 0x0e, 
		},
		2, Stairs41,
		1, Monsters41,
		1, Knives41,
	},
	{
		{
			0x85, 0x0e, 
			0x49, 0x06, 
			0x9b, 0x07, 
			0x31, 0x06, 
			0xeb, 0x0e, 
		},
		2, Stairs42,
		2, Monsters42,
		1, Knives42,
	},
	{
		{
			0x52, 0x06, 
			0xa4, 0x04, 
			0x69, 0x0f, 
			0x29, 0x06, 
			0xeb, 0x0e, 
		},
		0, nullptr,
		2, Monsters43,
		1, Knives43,
	},
};
static const byte[] Stairs50 = {
	(0 << 4) | 0,
	(3 << 4) | 0,
	(5 << 4) | 0,
	(1 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters50 = {
	(3 << 4) | 1, 0x01,
	(0 << 4) | 2, 0x02,
	(0 << 4) | 3, 0x02,
	(3 << 4) | 3, 0x02,
};

static const byte[] Knives50 = {
	(2 << 4) | 3,
};

static const byte[] Stairs51 = {
	(4 << 4) | 0,
	(0 << 4) | 2,
	(3 << 4) | 2,
	(1 << 4) | 3,
};

static const byte[] Monsters51 = {
	(1 << 4) | 0, 0x02,
	(2 << 4) | 0, 0x01,
	(4 << 4) | 3, 0x00,
};

static const byte[] Knives51 = {
	(0 << 4) | 3,
};

static const byte[] Stairs52 = {
	(3 << 4) | 0,
	(5 << 4) | 0,
	(5 << 4) | 2,
	(5 << 4) | 4,
};

static const byte[] Monsters52 = {
	(1 << 4) | 0, 0x02,
	(1 << 4) | 2, 0x02,
	(3 << 4) | 3, 0x00,
	(3 << 4) | 4, 0x00,
};

static const byte[] Knives52 = {
	(2 << 4) | 0,
};

static const byte[] Monsters53 = {
	(0 << 4) | 2, 0x02,
	(4 << 4) | 2, 0x02,
	(3 << 4) | 4, 0x02,
};

static const byte[] Knives53 = {
	(3 << 4) | 1,
};

static const Floor[] Floors5 = {
	{
		{
			0x31, 0x07, 
			0x91, 0x0e, 
			0xa5, 0x06, 
			0x55, 0x0d, 
			0xaf, 0x0e, 
		},
		5, Stairs50,
		4, Monsters50,
		1, Knives50,
	},
	{
		{
			0xe1, 0x0e, 
			0x89, 0x06, 
			0x5e, 0x0e, 
			0x39, 0x0c, 
			0xea, 0x0e, 
		},
		4, Stairs51,
		3, Monsters51,
		1, Knives51,
	},
	{
		{
			0x78, 0x0e, 
			0x9a, 0x04, 
			0x5c, 0x0f, 
			0x85, 0x0d, 
			0xee, 0x0e, 
		},
		4, Stairs52,
		4, Monsters52,
		1, Knives52,
	},
	{
		{
			0xe0, 0x0c, 
			0x45, 0x04, 
			0xf9, 0x0f, 
			0x31, 0x05, 
			0xea, 0x0e, 
		},
		0, nullptr,
		3, Monsters53,
		1, Knives53,
	},
};
static const byte[] Stairs60 = {
	(1 << 4) | 1,
	(3 << 4) | 1,
	(5 << 4) | 1,
	(1 << 4) | 2,
};

static const byte[] Monsters60 = {
	(3 << 4) | 3, 0x02,
	(2 << 4) | 4, 0x02,
	(5 << 4) | 4, 0x02,
};

static const byte[] Stairs61 = {
	(0 << 4) | 0,
	(3 << 4) | 2,
	(5 << 4) | 2,
	(3 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters61 = {
	(0 << 4) | 4, 0x02,
	(1 << 4) | 4, 0x02,
};

static const byte[] Stairs62 = {
	(5 << 4) | 0,
	(5 << 4) | 1,
	(3 << 4) | 3,
};

static const byte[] Monsters62 = {
	(0 << 4) | 1, 0x02,
};

static const byte[] Knives62 = {
	(5 << 4) | 3,
};

static const byte[] Stairs63 = {
	(3 << 4) | 2,
	(1 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters63 = {
	(0 << 4) | 0, 0x02,
	(2 << 4) | 1, 0x02,
	(1 << 4) | 2, 0x02,
	(4 << 4) | 3, 0x02,
};

static const byte[] Monsters64 = {
	(3 << 4) | 0, 0x00,
};

static const byte[] Knives64 = {
	(3 << 4) | 1,
};

static const Floor[] Floors6 = {
	{
		{
			0x22, 0x06, 
			0xdd, 0x0d, 
			0x4c, 0x06, 
			0x98, 0x04, 
			0xea, 0x0f, 
		},
		4, Stairs60,
		3, Monsters60,
		0, nullptr,
	},
	{
		{
			0x11, 0x05, 
			0xdd, 0x0d, 
			0xc5, 0x0c, 
			0xc5, 0x0c, 
			0xee, 0x0e, 
		},
		5, Stairs61,
		2, Monsters61,
		0, nullptr,
	},
	{
		{
			0xa1, 0x0e, 
			0xc5, 0x0c, 
			0xe5, 0x0e, 
			0xc5, 0x0c, 
			0xee, 0x0e, 
		},
		3, Stairs62,
		1, Monsters62,
		1, Knives62,
	},
	{
		{
			0xa2, 0x0e, 
			0x4c, 0x0c, 
			0xd6, 0x06, 
			0x5c, 0x04, 
			0xee, 0x0f, 
		},
		3, Stairs63,
		4, Monsters63,
		0, nullptr,
	},
	{
		{
			0xa8, 0x06, 
			0xcc, 0x05, 
			0xe4, 0x06, 
			0x69, 0x0c, 
			0xee, 0x0e, 
		},
		0, nullptr,
		1, Monsters64,
		1, Knives64,
	},
};
static const byte[] Stairs70 = {
	(5 << 4) | 0,
	(3 << 4) | 4,
};

static const byte[] Monsters70 = {
	(4 << 4) | 0, 0x01,
	(4 << 4) | 3, 0x02,
};

static const byte[] Knives70 = {
	(4 << 4) | 4,
};

static const byte[] Stairs71 = {
	(5 << 4) | 2,
	(0 << 4) | 4,
};

static const byte[] Monsters71 = {
	(2 << 4) | 0, 0x02,
	(3 << 4) | 1, 0x02,
	(1 << 4) | 2, 0x02,
};

static const byte[] Stairs72 = {
	(0 << 4) | 1,
	(3 << 4) | 4,
};

static const byte[] Monsters72 = {
	(0 << 4) | 0, 0x02,
	(3 << 4) | 1, 0x00,
	(0 << 4) | 2, 0x02,
	(5 << 4) | 4, 0x00,
};

static const byte[] Knives72 = {
	(4 << 4) | 0,
	(3 << 4) | 3,
};

static const byte[] Stairs73 = {
	(4 << 4) | 1,
	(0 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters73 = {
	(3 << 4) | 1, 0x02,
	(3 << 4) | 3, 0x02,
};

static const byte[] Monsters74 = {
	(1 << 4) | 0, 0x02,
	(1 << 4) | 2, 0x02,
	(0 << 4) | 3, 0x02,
	(5 << 4) | 3, 0x02,
};

static const byte[] Knives74 = {
	(2 << 4) | 2,
};

static const Floor[] Floors7 = {
	{
		{
			0x90, 0x0c, 
			0x05, 0x07, 
			0xb9, 0x0c, 
			0x69, 0x06, 
			0xfa, 0x0e, 
		},
		2, Stairs70,
		2, Monsters70,
		1, Knives70,
	},
	{
		{
			0x26, 0x0e, 
			0xb1, 0x06, 
			0x62, 0x0d, 
			0x96, 0x06, 
			0xba, 0x0e, 
		},
		2, Stairs71,
		3, Monsters71,
		0, nullptr,
	},
	{
		{
			0x68, 0x06, 
			0xab, 0x05, 
			0xc8, 0x06, 
			0x96, 0x05, 
			0xee, 0x0e, 
		},
		2, Stairs72,
		4, Monsters72,
		2, Knives72,
	},
	{
		{
			0x68, 0x04, 
			0x61, 0x07, 
			0x39, 0x0c, 
			0xeb, 0x0c, 
			0xea, 0x0e, 
		},
		3, Stairs73,
		2, Monsters73,
		0, nullptr,
	},
	{
		{
			0xa8, 0x0c, 
			0x62, 0x07, 
			0x26, 0x0e, 
			0xa6, 0x0e, 
			0xaa, 0x0e, 
		},
		0, nullptr,
		4, Monsters74,
		1, Knives74,
	},
};
const Stage[] Stages = {
	{
		2, Floors0,
		(0 << 4) | 0, // start
		(5 << 4) | 4, // goal
	},
	{
		2, Floors1,
		(5 << 4) | 4, // start
		(0 << 4) | 2, // goal
	},
	{
		3, Floors2,
		(0 << 4) | 4, // start
		(5 << 4) | 0, // goal
	},
	{
		3, Floors3,
		(0 << 4) | 4, // start
		(5 << 4) | 0, // goal
	},
	{
		4, Floors4,
		(0 << 4) | 0, // start
		(5 << 4) | 3, // goal
	},
	{
		4, Floors5,
		(5 << 4) | 3, // start
		(0 << 4) | 4, // goal
	},
	{
		5, Floors6,
		(0 << 4) | 0, // start
		(4 << 4) | 1, // goal
	},
	{
		5, Floors7,
		(2 << 4) | 4, // start
		(1 << 4) | 3, // goal
	},
};
