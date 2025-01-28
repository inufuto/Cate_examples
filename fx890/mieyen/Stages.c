#include "Stage.h"
#include "Stages.h"

static const byte[] Enemies0 = {
	(7 << 4) | 0,
	(0 << 4) | 1,
};

static const byte[] Enemies1 = {
	(7 << 4) | 0,
	(0 << 4) | 3,
};

static const byte[] Enemies2 = {
	(5 << 4) | 0,
	(0 << 4) | 3,
};

static const byte[] Enemies3 = {
	(0 << 4) | 0,
	(6 << 4) | 1,
	(5 << 4) | 3,
};

static const byte[] Enemies4 = {
	(4 << 4) | 0,
	(6 << 4) | 1,
	(0 << 4) | 3,
};

static const byte[] Enemies5 = {
	(0 << 4) | 0,
	(7 << 4) | 0,
	(0 << 4) | 3,
};

static const byte[] Enemies6 = {
	(0 << 4) | 0,
	(7 << 4) | 0,
	(0 << 4) | 3,
	(7 << 4) | 3,
};

static const byte[] Enemies7 = {
	(0 << 4) | 0,
	(3 << 4) | 0,
	(5 << 4) | 0,
	(0 << 4) | 3,
};

const Stage[] Stages = {
	{
		(3 << 4) | 2,
		2, Enemies0,
		{
			0x64, 0x45, 0x66, 0x16, 
			0x63, 0x66, 0x60, 0x56, 
			0x6a, 0x66, 0x6a, 0x56, 
			0x66, 0x66, 0x66, 0x7a, 
		},
	},
	{
		(0 << 4) | 0,
		2, Enemies1,
		{
			0x95, 0x45, 0x67, 0x34, 
			0x66, 0x66, 0x68, 0x56, 
			0x64, 0x66, 0x24, 0x12, 
			0x62, 0x26, 0x36, 0x3a, 
		},
	},
	{
		(4 << 4) | 0,
		2, Enemies2,
		{
			0x59, 0xa5, 0x25, 0x74, 
			0x45, 0x66, 0x22, 0x5b, 
			0xa2, 0x26, 0x62, 0x16, 
			0x22, 0x66, 0x62, 0x76, 
		},
	},
	{
		(1 << 4) | 3,
		3, Enemies3,
		{
			0x62, 0x66, 0x45, 0xb6, 
			0x68, 0x66, 0x26, 0x52, 
			0x05, 0xa2, 0x66, 0x56, 
			0x6a, 0x22, 0x26, 0x36, 
		},
	},
	{
		(4 << 4) | 3,
		3, Enemies4,
		{
			0xa7, 0x55, 0x51, 0x55, 
			0x2a, 0x22, 0x66, 0x52, 
			0x0a, 0x62, 0x66, 0x56, 
			0x22, 0x22, 0x26, 0xb2, 
		},
	},
	{
		(4 << 4) | 1,
		3, Enemies5,
		{
			0xa1, 0xa4, 0x8b, 0x15, 
			0x68, 0x66, 0x76, 0x56, 
			0x2a, 0x2a, 0x22, 0x12, 
			0x22, 0x22, 0x22, 0x32, 
		},
	},
	{
		(4 << 4) | 0,
		4, Enemies6,
		{
			0x40, 0x84, 0x44, 0x14, 
			0x48, 0x84, 0x48, 0x94, 
			0x48, 0x44, 0x48, 0x94, 
			0x62, 0x66, 0x6a, 0x36, 
		},
	},
	{
		(3 << 4) | 2,
		4, Enemies7,
		{
			0xa2, 0x28, 0x21, 0x92, 
			0x28, 0x28, 0x02, 0x12, 
			0x0a, 0x6a, 0x2a, 0x12, 
			0x22, 0x22, 0x22, 0xb2, 
		},
	},
};
