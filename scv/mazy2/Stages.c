#include "Stage.h"
#include "Stages.h"

static const byte[] Stairs00 = {
	(7 << 4) | 2,
	(3 << 4) | 4,
};

static const byte[] Monsters00 = {
	(4 << 4) | 0, 0x02,
	(7 << 4) | 0, 0x01,
	(6 << 4) | 1, 0x02,
	(6 << 4) | 3, 0x01,
};

static const byte[] Knives00 = {
	(1 << 4) | 0,
	(1 << 4) | 4,
};

static const byte[] Monsters01 = {
	(1 << 4) | 4, 0x00,
	(5 << 4) | 4, 0x02,
};

static const byte[] Knives01 = {
	(6 << 4) | 0,
	(0 << 4) | 2,
};

static const Floor[] Floors0 = {
	{
		{
			0x99, 0x60, 
			0x60, 0x57, 
			0xb3, 0xde, 
			0x8c, 0xca, 
			0xee, 0xea, 
		},
		2, Stairs00,
		4, Monsters00,
		2, Knives00,
	},
	{
		{
			0xa2, 0xe0, 
			0x85, 0x69, 
			0x75, 0x66, 
			0xc6, 0xc5, 
			0xea, 0xee, 
		},
		0, nullptr,
		2, Monsters01,
		2, Knives01,
	},
};
static const byte[] Stairs10 = {
	(7 << 4) | 0,
	(0 << 4) | 1,
	(7 << 4) | 3,
	(0 << 4) | 4,
	(4 << 4) | 4,
};

static const byte[] Monsters10 = {
	(0 << 4) | 0, 0x01,
	(5 << 4) | 2, 0x02,
};

static const byte[] Knives10 = {
	(5 << 4) | 0,
	(3 << 4) | 3,
};

static const byte[] Monsters11 = {
	(2 << 4) | 1, 0x02,
	(3 << 4) | 1, 0x02,
	(7 << 4) | 1, 0x00,
};

static const Floor[] Floors1 = {
	{
		{
			0xc8, 0xe9, 
			0x67, 0x44, 
			0xcc, 0x79, 
			0xb1, 0xd6, 
			0xab, 0xeb, 
		},
		5, Stairs10,
		2, Monsters10,
		2, Knives10,
	},
	{
		{
			0xc2, 0x50, 
			0xa5, 0x45, 
			0x75, 0xf5, 
			0x91, 0x5b, 
			0xaf, 0xef, 
		},
		0, nullptr,
		3, Monsters11,
		0, nullptr,
	},
};
static const byte[] Stairs20 = {
	(3 << 4) | 0,
	(5 << 4) | 4,
};

static const byte[] Monsters20 = {
	(2 << 4) | 0, 0x01,
	(5 << 4) | 0, 0x01,
	(5 << 4) | 1, 0x02,
	(4 << 4) | 4, 0x02,
};

static const byte[] Knives20 = {
	(2 << 4) | 2,
	(3 << 4) | 4,
};

static const byte[] Stairs21 = {
	(6 << 4) | 0,
	(1 << 4) | 2,
	(4 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Monsters21 = {
	(4 << 4) | 0, 0x02,
	(5 << 4) | 2, 0x02,
	(3 << 4) | 4, 0x02,
};

static const byte[] Knives21 = {
	(6 << 4) | 1,
};

static const byte[] Monsters22 = {
	(3 << 4) | 1, 0x01,
	(4 << 4) | 2, 0x02,
	(3 << 4) | 3, 0x02,
	(0 << 4) | 4, 0x02,
};

static const byte[] Knives22 = {
	(6 << 4) | 4,
};

static const Floor[] Floors2 = {
	{
		{
			0x98, 0x7a, 
			0x66, 0x68, 
			0xb8, 0x63, 
			0x9a, 0xd8, 
			0xea, 0xeb, 
		},
		2, Stairs20,
		4, Monsters20,
		2, Knives20,
	},
	{
		{
			0x58, 0xf1, 
			0xa5, 0x67, 
			0x31, 0x7a, 
			0xa5, 0xed, 
			0xea, 0xeb, 
		},
		4, Stairs21,
		3, Monsters21,
		1, Knives21,
	},
	{
		{
			0x98, 0x64, 
			0x69, 0x69, 
			0x99, 0xe7, 
			0x96, 0x68, 
			0xea, 0xfa, 
		},
		0, nullptr,
		4, Monsters22,
		1, Knives22,
	},
};
static const byte[] Stairs30 = {
	(7 << 4) | 1,
	(4 << 4) | 2,
	(7 << 4) | 2,
	(3 << 4) | 4,
	(5 << 4) | 4,
};

static const byte[] Monsters30 = {
	(3 << 4) | 2, 0x01,
	(5 << 4) | 2, 0x02,
};

static const byte[] Knives30 = {
	(4 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Stairs31 = {
	(0 << 4) | 0,
	(2 << 4) | 0,
	(5 << 4) | 0,
	(4 << 4) | 1,
	(3 << 4) | 2,
	(0 << 4) | 3,
	(4 << 4) | 3,
	(6 << 4) | 4,
};

static const byte[] Monsters31 = {
	(4 << 4) | 0, 0x02,
	(1 << 4) | 1, 0x02,
	(0 << 4) | 4, 0x02,
	(2 << 4) | 4, 0x02,
};

static const byte[] Monsters32 = {
	(4 << 4) | 2, 0x00,
};

static const byte[] Knives32 = {
	(7 << 4) | 2,
};

static const Floor[] Floors3 = {
	{
		{
			0x29, 0xc6, 
			0x98, 0xe5, 
			0x71, 0xe9, 
			0xb1, 0x45, 
			0xeb, 0xfb, 
		},
		5, Stairs30,
		2, Monsters30,
		2, Knives30,
	},
	{
		{
			0x3a, 0x6b, 
			0xcc, 0xda, 
			0xa2, 0xe7, 
			0x71, 0x61, 
			0xba, 0xef, 
		},
		8, Stairs31,
		4, Monsters31,
		0, nullptr,
	},
	{
		{
			0xa5, 0x6e, 
			0x9a, 0x46, 
			0x31, 0xf9, 
			0x71, 0x4a, 
			0xfa, 0xfa, 
		},
		0, nullptr,
		1, Monsters32,
		1, Knives32,
	},
};
static const byte[] Stairs40 = {
	(7 << 4) | 2,
	(0 << 4) | 3,
};

static const byte[] Monsters40 = {
	(6 << 4) | 0, 0x01,
	(4 << 4) | 1, 0x02,
	(4 << 4) | 4, 0x02,
	(5 << 4) | 4, 0x02,
	(6 << 4) | 4, 0x02,
};

static const byte[] Knives40 = {
	(5 << 4) | 2,
};

static const byte[] Stairs41 = {
	(7 << 4) | 0,
	(0 << 4) | 4,
};

static const byte[] Monsters41 = {
	(6 << 4) | 3, 0x02,
};

static const byte[] Knives41 = {
	(6 << 4) | 1,
};

static const byte[] Stairs42 = {
	(0 << 4) | 3,
	(6 << 4) | 4,
};

static const byte[] Monsters42 = {
	(2 << 4) | 2, 0x02,
	(4 << 4) | 4, 0x01,
};

static const byte[] Knives42 = {
	(6 << 4) | 2,
};

static const byte[] Monsters43 = {
	(3 << 4) | 0, 0x01,
	(2 << 4) | 2, 0x02,
};

static const byte[] Knives43 = {
	(7 << 4) | 2,
};

static const Floor[] Floors4 = {
	{
		{
			0x92, 0x48, 
			0xac, 0x5b, 
			0xaa, 0xfe, 
			0xa1, 0xe1, 
			0xae, 0xea, 
		},
		2, Stairs40,
		5, Monsters40,
		1, Knives40,
	},
	{
		{
			0x0a, 0x61, 
			0x59, 0x57, 
			0x3a, 0x7b, 
			0xa1, 0xe6, 
			0xef, 0xea, 
		},
		2, Stairs41,
		1, Monsters41,
		1, Knives41,
	},
	{
		{
			0x15, 0xea, 
			0x25, 0x69, 
			0x6b, 0x7a, 
			0xe1, 0x68, 
			0xab, 0xee, 
		},
		2, Stairs42,
		2, Monsters42,
		1, Knives42,
	},
	{
		{
			0x4a, 0x64, 
			0x9c, 0x4b, 
			0xa4, 0xf9, 
			0xa1, 0x62, 
			0xab, 0xee, 
		},
		0, nullptr,
		2, Monsters43,
		1, Knives43,
	},
};
static const byte[] Stairs50 = {
	(0 << 4) | 0,
	(5 << 4) | 0,
	(7 << 4) | 0,
	(2 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Monsters50 = {
	(5 << 4) | 1, 0x01,
	(0 << 4) | 2, 0x02,
	(0 << 4) | 3, 0x02,
	(5 << 4) | 3, 0x02,
};

static const byte[] Knives50 = {
	(2 << 4) | 3,
};

static const byte[] Stairs51 = {
	(6 << 4) | 0,
	(0 << 4) | 2,
	(4 << 4) | 2,
	(2 << 4) | 3,
};

static const byte[] Monsters51 = {
	(1 << 4) | 0, 0x02,
	(2 << 4) | 0, 0x01,
	(5 << 4) | 3, 0x00,
};

static const byte[] Knives51 = {
	(0 << 4) | 3,
};

static const byte[] Stairs52 = {
	(4 << 4) | 0,
	(7 << 4) | 0,
	(7 << 4) | 2,
	(7 << 4) | 4,
};

static const byte[] Monsters52 = {
	(2 << 4) | 0, 0x02,
	(1 << 4) | 2, 0x02,
	(4 << 4) | 3, 0x00,
	(4 << 4) | 4, 0x00,
};

static const byte[] Knives52 = {
	(3 << 4) | 0,
};

static const byte[] Monsters53 = {
	(5 << 4) | 1, 0x02,
	(0 << 4) | 2, 0x02,
	(4 << 4) | 4, 0x02,
};

static const byte[] Knives53 = {
	(4 << 4) | 1,
};

static const Floor[] Floors5 = {
	{
		{
			0x81, 0x73, 
			0x15, 0xe9, 
			0xe5, 0x6a, 
			0x65, 0xd5, 
			0xbb, 0xea, 
		},
		5, Stairs50,
		4, Monsters50,
		1, Knives50,
	},
	{
		{
			0xa1, 0xee, 
			0x19, 0x62, 
			0x6e, 0xf9, 
			0xe6, 0xe0, 
			0xaa, 0xeb, 
		},
		4, Stairs51,
		3, Monsters51,
		1, Knives51,
	},
	{
		{
			0xe8, 0xe6, 
			0x2a, 0x43, 
			0x5c, 0xfd, 
			0x15, 0xd2, 
			0xba, 0xeb, 
		},
		4, Stairs52,
		4, Monsters52,
		1, Knives52,
	},
	{
		{
			0x88, 0xcb, 
			0x15, 0x61, 
			0xe6, 0xfb, 
			0xc6, 0x51, 
			0xaa, 0xee, 
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
	(7 << 4) | 1,
	(1 << 4) | 2,
};

static const byte[] Monsters60 = {
	(4 << 4) | 3, 0x02,
	(3 << 4) | 4, 0x02,
	(5 << 4) | 4, 0x02,
};

static const byte[] Stairs61 = {
	(0 << 4) | 0,
	(3 << 4) | 2,
	(5 << 4) | 2,
	(7 << 4) | 2,
	(3 << 4) | 4,
	(5 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Monsters61 = {
	(0 << 4) | 4, 0x02,
	(1 << 4) | 4, 0x02,
};

static const byte[] Stairs62 = {
	(7 << 4) | 0,
	(3 << 4) | 1,
	(7 << 4) | 1,
	(3 << 4) | 3,
	(5 << 4) | 3,
};

static const byte[] Monsters62 = {
	(0 << 4) | 1, 0x02,
};

static const byte[] Knives62 = {
	(7 << 4) | 3,
};

static const byte[] Stairs63 = {
	(3 << 4) | 2,
	(5 << 4) | 2,
	(1 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Monsters63 = {
	(0 << 4) | 0, 0x02,
	(4 << 4) | 1, 0x02,
	(1 << 4) | 2, 0x02,
	(6 << 4) | 3, 0x02,
};

static const byte[] Monsters64 = {
	(3 << 4) | 0, 0x00,
};

static const byte[] Knives64 = {
	(5 << 4) | 4,
};

static const Floor[] Floors6 = {
	{
		{
			0x22, 0x62, 
			0xdd, 0xdd, 
			0x3c, 0x64, 
			0x62, 0x47, 
			0xaa, 0xfb, 
		},
		5, Stairs60,
		3, Monsters60,
		0, nullptr,
	},
	{
		{
			0x11, 0x51, 
			0xdd, 0xdd, 
			0xc5, 0xcc, 
			0xc5, 0xcc, 
			0xee, 0xee, 
		},
		7, Stairs61,
		2, Monsters61,
		0, nullptr,
	},
	{
		{
			0xa1, 0xea, 
			0xc5, 0xcc, 
			0xe5, 0xee, 
			0xc5, 0xcc, 
			0xee, 0xee, 
		},
		5, Stairs62,
		1, Monsters62,
		1, Knives62,
	},
	{
		{
			0xa2, 0xea, 
			0xcc, 0xc4, 
			0xe6, 0x6d, 
			0xcc, 0x45, 
			0xee, 0xfe, 
		},
		4, Stairs63,
		4, Monsters63,
		0, nullptr,
	},
	{
		{
			0xa8, 0x6a, 
			0xcc, 0x5c, 
			0xe4, 0x66, 
			0x69, 0xcc, 
			0xee, 0xee, 
		},
		0, nullptr,
		1, Monsters64,
		1, Knives64,
	},
};
static const byte[] Stairs70 = {
	(7 << 4) | 0,
	(4 << 4) | 4,
};

static const byte[] Monsters70 = {
	(6 << 4) | 0, 0x01,
	(6 << 4) | 3, 0x02,
};

static const byte[] Knives70 = {
	(5 << 4) | 4,
};

static const byte[] Stairs71 = {
	(7 << 4) | 2,
	(0 << 4) | 4,
};

static const byte[] Monsters71 = {
	(3 << 4) | 0, 0x02,
	(4 << 4) | 1, 0x02,
	(2 << 4) | 2, 0x02,
};

static const byte[] Stairs72 = {
	(0 << 4) | 1,
	(4 << 4) | 4,
};

static const byte[] Monsters72 = {
	(0 << 4) | 0, 0x02,
	(4 << 4) | 1, 0x00,
	(1 << 4) | 2, 0x02,
	(7 << 4) | 4, 0x00,
};

static const byte[] Knives72 = {
	(6 << 4) | 0,
	(5 << 4) | 3,
};

static const byte[] Stairs73 = {
	(6 << 4) | 1,
	(1 << 4) | 4,
	(7 << 4) | 4,
};

static const byte[] Monsters73 = {
	(4 << 4) | 1, 0x02,
	(5 << 4) | 3, 0x02,
	(0 << 4) | 4, 0x02,
};

static const byte[] Monsters74 = {
	(2 << 4) | 0, 0x02,
	(2 << 4) | 2, 0x02,
	(1 << 4) | 3, 0x02,
	(7 << 4) | 3, 0x02,
};

static const byte[] Knives74 = {
	(3 << 4) | 2,
};

static const Floor[] Floors7 = {
	{
		{
			0x48, 0xca, 
			0x15, 0x72, 
			0xe6, 0xe3, 
			0xac, 0x69, 
			0xea, 0xeb, 
		},
		2, Stairs70,
		2, Monsters70,
		1, Knives70,
	},
	{
		{
			0x9a, 0xe8, 
			0xc5, 0x6a, 
			0x8a, 0xd5, 
			0x56, 0x6a, 
			0xea, 0xea, 
		},
		2, Stairs71,
		3, Monsters71,
		0, nullptr,
	},
	{
		{
			0xa8, 0x66, 
			0xab, 0x72, 
			0xa1, 0xe9, 
			0x69, 0x75, 
			0xea, 0xeb, 
		},
		2, Stairs72,
		4, Monsters72,
		2, Knives72,
	},
	{
		{
			0xa8, 0x4c, 
			0x89, 0x76, 
			0xe5, 0xc8, 
			0xac, 0xe6, 
			0xab, 0xeb, 
		},
		3, Stairs73,
		3, Monsters73,
		0, nullptr,
	},
	{
		{
			0xa8, 0xca, 
			0x86, 0x76, 
			0x98, 0xe2, 
			0x9c, 0xea, 
			0xae, 0xea, 
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
		(7 << 4) | 4, // goal
	},
	{
		2, Floors1,
		(7 << 4) | 4, // start
		(1 << 4) | 1, // goal
	},
	{
		3, Floors2,
		(0 << 4) | 4, // start
		(6 << 4) | 0, // goal
	},
	{
		3, Floors3,
		(0 << 4) | 4, // start
		(7 << 4) | 0, // goal
	},
	{
		4, Floors4,
		(0 << 4) | 0, // start
		(7 << 4) | 3, // goal
	},
	{
		4, Floors5,
		(7 << 4) | 3, // start
		(0 << 4) | 4, // goal
	},
	{
		5, Floors6,
		(0 << 4) | 0, // start
		(6 << 4) | 1, // goal
	},
	{
		5, Floors7,
		(3 << 4) | 4, // start
		(2 << 4) | 3, // goal
	},
};
