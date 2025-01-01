#include "Stage.h"
#include "Stages.h"

static const byte[] Enemies0 = {
	(14 << 4) | 10,
};

static const byte[] Enemies1 = {
	(11 << 4) | 0,
	(15 << 4) | 5,
};

static const byte[] Enemies2 = {
	(13 << 4) | 0,
	(2 << 4) | 1,
};

static const byte[] Enemies3 = {
	(0 << 4) | 3,
	(0 << 4) | 9,
	(14 << 4) | 10,
};

static const byte[] Enemies4 = {
	(9 << 4) | 2,
	(0 << 4) | 10,
	(15 << 4) | 10,
};

static const byte[] Enemies5 = {
	(15 << 4) | 0,
	(0 << 4) | 10,
	(7 << 4) | 10,
	(14 << 4) | 10,
};

static const byte[] Enemies6 = {
	(10 << 4) | 3,
	(10 << 4) | 5,
	(0 << 4) | 10,
	(15 << 4) | 10,
};

static const byte[] Enemies7 = {
	(0 << 4) | 0,
	(15 << 4) | 0,
	(8 << 4) | 4,
	(0 << 4) | 10,
	(15 << 4) | 10,
};

static const byte[] Enemies8 = {
	(5 << 4) | 10,
	(6 << 4) | 10,
	(7 << 4) | 10,
	(8 << 4) | 10,
	(9 << 4) | 10,
};

static const byte[] Enemies9 = {
	(0 << 4) | 0,
	(8 << 4) | 0,
	(15 << 4) | 0,
	(9 << 4) | 5,
	(7 << 4) | 10,
	(15 << 4) | 10,
};

const Stage[] Stages = {
	{
		(0 << 4) | 3,
		1, Enemies0,
		{
			0x55, 0x55, 0x44, 0x55, 
			0x55, 0x54, 0x44, 0x55, 
			0x55, 0x54, 0x54, 0x55, 
			0x00, 0x54, 0x00, 0x15, 
			0x55, 0x40, 0x14, 0x55, 
			0x05, 0x00, 0x00, 0x00, 
			0x55, 0x55, 0x40, 0x44, 
			0x55, 0x55, 0x40, 0x45, 
			0x59, 0x45, 0x40, 0x45, 
			0x59, 0x04, 0x40, 0x55, 
			0x19, 0x00, 0x00, 0x40, 
		},
	},
	{
		(0 << 4) | 10,
		2, Enemies1,
		{
			0x00, 0x54, 0x11, 0x55, 
			0x55, 0x54, 0xa9, 0x0a, 
			0x51, 0x00, 0x00, 0x55, 
			0x51, 0x40, 0x01, 0x15, 
			0x49, 0x40, 0x01, 0x00, 
			0x59, 0x04, 0x01, 0x15, 
			0x00, 0x00, 0x84, 0xaa, 
			0x11, 0x55, 0x00, 0x51, 
			0x11, 0x00, 0x01, 0x00, 
			0x11, 0x15, 0x00, 0x50, 
			0x00, 0x54, 0x45, 0x00, 
		},
	},
	{
		(0 << 4) | 10,
		2, Enemies2,
		{
			0xaa, 0x2a, 0x00, 0x50, 
			0x85, 0x20, 0x41, 0x40, 
			0x95, 0x60, 0x40, 0x45, 
			0x95, 0x64, 0x04, 0x00, 
			0x81, 0x20, 0x00, 0x40, 
			0x80, 0x20, 0x00, 0x40, 
			0x80, 0x44, 0x05, 0x45, 
			0x94, 0x04, 0x45, 0x00, 
			0x14, 0x04, 0x45, 0x55, 
			0x15, 0x01, 0x00, 0x00, 
			0x00, 0x00, 0x01, 0x50, 
		},
	},
	{
		(15 << 4) | 0,
		3, Enemies3,
		{
			0x54, 0x58, 0x11, 0x00, 
			0x00, 0x00, 0x48, 0x00, 
			0x15, 0x00, 0x08, 0x10, 
			0x00, 0x51, 0x09, 0x10, 
			0xaa, 0xaa, 0x0a, 0x55, 
			0x14, 0x01, 0x08, 0x00, 
			0x00, 0x00, 0x08, 0x14, 
			0x08, 0x04, 0x58, 0x18, 
			0xa8, 0x0a, 0x00, 0x18, 
			0x58, 0x10, 0x54, 0x18, 
			0x5a, 0x11, 0x04, 0x08, 
		},
	},
	{
		(10 << 4) | 0,
		3, Enemies4,
		{
			0x00, 0xa9, 0x0a, 0x10, 
			0x00, 0x80, 0xaa, 0x2a, 
			0x01, 0x00, 0x02, 0x04, 
			0x40, 0x55, 0xa2, 0xaa, 
			0x04, 0x00, 0x01, 0x00, 
			0x06, 0x04, 0x01, 0x00, 
			0x12, 0x40, 0x01, 0x00, 
			0x12, 0x41, 0x01, 0x00, 
			0x00, 0x01, 0x20, 0x14, 
			0x80, 0x80, 0xaa, 0xaa, 
			0x80, 0x00, 0x00, 0x00, 
		},
	},
	{
		(0 << 4) | 1,
		4, Enemies5,
		{
			0x41, 0x01, 0x48, 0x00, 
			0x08, 0x01, 0x09, 0xa8, 
			0x04, 0x01, 0x28, 0x80, 
			0x01, 0x00, 0x29, 0x00, 
			0x01, 0x40, 0x28, 0x10, 
			0x00, 0x01, 0x28, 0x00, 
			0x0a, 0x04, 0x20, 0x50, 
			0x01, 0x00, 0x02, 0x00, 
			0x00, 0x40, 0x02, 0x10, 
			0x04, 0x44, 0x12, 0x40, 
			0x44, 0x00, 0x2a, 0x40, 
		},
	},
	{
		(0 << 4) | 0,
		4, Enemies6,
		{
			0x00, 0x06, 0x01, 0x00, 
			0x00, 0x00, 0xaa, 0x00, 
			0x10, 0x00, 0x81, 0x00, 
			0x04, 0x00, 0x80, 0x00, 
			0xa0, 0xaa, 0xaa, 0x0a, 
			0x00, 0x00, 0x88, 0x40, 
			0xa8, 0xaa, 0x88, 0x00, 
			0x40, 0x55, 0x80, 0x04, 
			0x82, 0xaa, 0xaa, 0x02, 
			0x50, 0x11, 0x00, 0x40, 
			0x40, 0x01, 0x40, 0x01, 
		},
	},
	{
		(10 << 4) | 10,
		5, Enemies7,
		{
			0x00, 0x10, 0x06, 0x00, 
			0x10, 0x22, 0x02, 0x04, 
			0x00, 0x02, 0x82, 0x40, 
			0x40, 0x02, 0x82, 0x04, 
			0x40, 0x42, 0x80, 0x40, 
			0x00, 0xaa, 0xaa, 0x12, 
			0xa8, 0x82, 0x80, 0x01, 
			0x04, 0x80, 0x88, 0x11, 
			0x40, 0x80, 0x88, 0x40, 
			0x00, 0xa8, 0x88, 0x10, 
			0x20, 0x00, 0x88, 0x00, 
		},
	},
	{
		(7 << 4) | 0,
		5, Enemies8,
		{
			0x00, 0x00, 0x00, 0x00, 
			0x61, 0x44, 0x44, 0x48, 
			0x24, 0x11, 0x11, 0x19, 
			0x60, 0x00, 0x00, 0x09, 
			0x60, 0x00, 0x00, 0x09, 
			0x60, 0x44, 0x44, 0x09, 
			0x20, 0x11, 0x11, 0x08, 
			0x60, 0x00, 0x00, 0x09, 
			0x64, 0x00, 0x00, 0x19, 
			0x21, 0x00, 0x00, 0x49, 
			0x00, 0x00, 0x00, 0x00, 
		},
	},
	{
		(0 << 4) | 10,
		6, Enemies9,
		{
			0x54, 0x55, 0x54, 0x15, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x51, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x55, 0x55, 0x55, 0x55, 
			0x54, 0x15, 0x55, 0x15, 
		},
	},
};