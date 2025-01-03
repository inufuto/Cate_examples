#include "Stage.h"
#include "Stages.h"

static const byte[] Enemies0 = {
	(0 << 4) | 0,
	(9 << 4) | 0,
};

static const byte[] Enemies1 = {
	(9 << 4) | 0,
	(0 << 4) | 6,
};

static const byte[] Enemies2 = {
	(6 << 4) | 0,
	(0 << 4) | 6,
};

static const byte[] Enemies3 = {
	(0 << 4) | 0,
	(7 << 4) | 4,
	(7 << 4) | 6,
};

static const byte[] Enemies4 = {
	(5 << 4) | 0,
	(8 << 4) | 3,
	(0 << 4) | 6,
};

static const byte[] Enemies5 = {
	(0 << 4) | 0,
	(9 << 4) | 0,
	(0 << 4) | 6,
};

static const byte[] Enemies6 = {
	(0 << 4) | 0,
	(9 << 4) | 0,
	(0 << 4) | 6,
	(9 << 4) | 6,
};

static const byte[] Enemies7 = {
	(0 << 4) | 0,
	(4 << 4) | 0,
	(7 << 4) | 2,
	(0 << 4) | 6,
};

const Stage[] Stages = {
	{
		(4 << 4) | 4,
		2, Enemies0,
		{
			0x41, 0x44, 0x04, 0x55, 0x15, 
			0x05, 0x11, 0x24, 0x66, 0x51, 
			0x54, 0x52, 0x64, 0x66, 0x56, 
			0x65, 0x66, 0x66, 0x22, 0x52, 
			0x22, 0x66, 0x66, 0x6a, 0x56, 
			0x68, 0x66, 0x66, 0x66, 0x56, 
			0x66, 0x66, 0x66, 0x66, 0x7a, 
		},
	},
	{
		(0 << 4) | 0,
		2, Enemies1,
		{
			0x94, 0x45, 0x74, 0x66, 0x34, 
			0x11, 0x56, 0x66, 0x24, 0x50, 
			0x46, 0x66, 0x66, 0x24, 0x52, 
			0x60, 0x66, 0x86, 0x66, 0x56, 
			0x62, 0x66, 0x46, 0x22, 0x52, 
			0x60, 0x66, 0x46, 0x22, 0x12, 
			0x62, 0x66, 0x62, 0x32, 0x3a, 
		},
	},
	{
		(5 << 4) | 1,
		2, Enemies2,
		{
			0x51, 0x55, 0x1a, 0x62, 0x56, 
			0x5a, 0x44, 0x62, 0x42, 0x16, 
			0x64, 0x46, 0x46, 0x62, 0x36, 
			0x45, 0x46, 0x66, 0xa6, 0x56, 
			0x11, 0x62, 0x22, 0x62, 0x1b, 
			0x02, 0x62, 0x22, 0x62, 0x16, 
			0x22, 0x62, 0x26, 0x62, 0x76, 
		},
	},
	{
		(2 << 4) | 6,
		3, Enemies3,
		{
			0x50, 0x50, 0x56, 0x55, 0x74, 
			0x55, 0x45, 0x66, 0x44, 0xb2, 
			0x66, 0x67, 0x66, 0x45, 0x52, 
			0x6a, 0x62, 0x66, 0x66, 0x56, 
			0x60, 0x66, 0x66, 0x26, 0x12, 
			0x52, 0x20, 0x2a, 0x66, 0x56, 
			0x6a, 0x26, 0x22, 0x26, 0x36, 
		},
	},
	{
		(5 << 4) | 6,
		3, Enemies4,
		{
			0x01, 0x12, 0x25, 0x56, 0x55, 
			0x45, 0x68, 0x56, 0x64, 0x76, 
			0x46, 0x46, 0x64, 0x46, 0x76, 
			0x66, 0x22, 0x22, 0x20, 0x12, 
			0x6a, 0x22, 0x62, 0x66, 0x56, 
			0x6a, 0x20, 0x66, 0x66, 0x56, 
			0x62, 0x22, 0x62, 0x22, 0xb2, 
		},
	},
	{
		(6 << 4) | 3,
		3, Enemies5,
		{
			0x11, 0x1a, 0x11, 0x89, 0x11, 
			0x44, 0x44, 0x46, 0x45, 0x74, 
			0xa1, 0x02, 0x28, 0x24, 0x38, 
			0x86, 0x66, 0x66, 0x64, 0x56, 
			0x45, 0x66, 0x66, 0x66, 0x56, 
			0xa2, 0xa2, 0x22, 0x22, 0x12, 
			0x62, 0x22, 0x22, 0x22, 0x32, 
		},
	},
	{
		(5 << 4) | 2,
		4, Enemies6,
		{
			0x40, 0x44, 0x84, 0x44, 0x14, 
			0x44, 0x44, 0x44, 0x44, 0x54, 
			0x44, 0x44, 0x44, 0x44, 0x54, 
			0x48, 0x44, 0x88, 0x48, 0x94, 
			0x44, 0x44, 0x44, 0x44, 0x54, 
			0x44, 0x44, 0x44, 0x44, 0x54, 
			0x62, 0x66, 0xa6, 0x66, 0x36, 
		},
	},
	{
		(4 << 4) | 3,
		4, Enemies7,
		{
			0x01, 0x12, 0x01, 0x22, 0x32, 
			0x12, 0x81, 0x11, 0x00, 0x90, 
			0x00, 0xaa, 0x02, 0x21, 0x10, 
			0x82, 0x80, 0x16, 0x00, 0x10, 
			0x90, 0xa2, 0x20, 0x02, 0x12, 
			0x02, 0x22, 0x22, 0x22, 0x12, 
			0x22, 0x22, 0x22, 0x22, 0xb2, 
		},
	},
};
