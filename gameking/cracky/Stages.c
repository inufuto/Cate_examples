#include "Stage.h"
#include "Stages.h"

static const byte[] Enemies0 = {
	(10 << 4) | 0,
};

static const byte[] Enemies1 = {
	(8 << 4) | 0,
	(1 << 4) | 1,
};

static const byte[] Enemies2 = {
	(5 << 4) | 0,
	(4 << 4) | 1,
};

static const byte[] Enemies3 = {
	(11 << 4) | 0,
	(5 << 4) | 2,
};

static const byte[] Enemies4 = {
	(0 << 4) | 0,
	(5 << 4) | 1,
	(6 << 4) | 2,
};

static const byte[] Enemies5 = {
	(2 << 4) | 0,
	(4 << 4) | 1,
	(10 << 4) | 1,
};

static const byte[] Enemies6 = {
	(10 << 4) | 0,
	(10 << 4) | 1,
	(8 << 4) | 3,
};

static const byte[] Enemies7 = {
	(9 << 4) | 0,
	(11 << 4) | 0,
	(0 << 4) | 2,
};

static const byte[] Enemies8 = {
	(6 << 4) | 0,
	(8 << 4) | 0,
	(11 << 4) | 0,
	(11 << 4) | 2,
};

static const byte[] Enemies9 = {
	(6 << 4) | 0,
	(11 << 4) | 0,
	(9 << 4) | 1,
	(10 << 4) | 2,
};

const Stage[] Stages = {
	{
		(1 << 4) | 3,
		10,
		1, Enemies0,
		{
			0xf2, 0x31, 0xf3, 0x11, 0x31, 0x23, 
			0xfa, 0xff, 0x13, 0x13, 0x1f, 0xa1, 
			0x3a, 0x3f, 0x13, 0x11, 0xf1, 0xa3, 
			0x3b, 0x33, 0x33, 0xf3, 0x33, 0xbf, 
		},
	},
	{
		(9 << 4) | 3,
		14,
		2, Enemies1,
		{
			0xff, 0x12, 0x33, 0x33, 0x33, 0xff, 
			0x31, 0x3a, 0x2f, 0x23, 0xff, 0x31, 
			0xf2, 0xfb, 0xa3, 0xaf, 0x21, 0x1f, 
			0xfb, 0xf3, 0xb3, 0xb3, 0xb3, 0xf3, 
		},
	},
	{
		(11 << 4) | 0,
		11,
		2, Enemies2,
		{
			0x2f, 0x11, 0x33, 0xf3, 0x3f, 0x31, 
			0xa1, 0x32, 0x23, 0x3f, 0x21, 0x21, 
			0xb1, 0xfa, 0xb3, 0x30, 0xb1, 0xa3, 
			0x33, 0xfb, 0xff, 0xf3, 0x3f, 0xbf, 
		},
	},
	{
		(1 << 4) | 0,
		10,
		2, Enemies3,
		{
			0x30, 0xf1, 0x10, 0x12, 0xf1, 0x33, 
			0xf3, 0x32, 0xf1, 0x3a, 0xf2, 0x12, 
			0x11, 0x0a, 0x3f, 0x0b, 0x0b, 0x2b, 
			0xff, 0x3b, 0xf3, 0x33, 0xf3, 0xb3, 
		},
	},
	{
		(11 << 4) | 0,
		15,
		3, Enemies4,
		{
			0x13, 0xff, 0xf3, 0x32, 0x11, 0x3f, 
			0xff, 0x12, 0x31, 0xfa, 0x12, 0x1f, 
			0x13, 0x0a, 0xff, 0x1b, 0x3a, 0x10, 
			0xff, 0x3b, 0x3f, 0x33, 0xfb, 0xf3, 
		},
	},
	{
		(2 << 4) | 3,
		11,
		3, Enemies5,
		{
			0x12, 0x33, 0x2f, 0x13, 0xf1, 0x1f, 
			0x3a, 0xf2, 0xa3, 0xf1, 0x31, 0x13, 
			0x19, 0xfa, 0xa1, 0xf1, 0x10, 0x30, 
			0x3f, 0x3b, 0xb3, 0xf3, 0xf3, 0x3f, 
		},
	},
	{
		(0 << 4) | 0,
		13,
		3, Enemies6,
		{
			0x33, 0x11, 0xf1, 0xf1, 0x11, 0x23, 
			0x12, 0x21, 0xff, 0x31, 0x21, 0xb3, 
			0xfa, 0xbf, 0x11, 0x33, 0xaf, 0xf1, 
			0x3b, 0xff, 0xff, 0x33, 0xb3, 0xf3, 
		},
	},
	{
		(2 << 4) | 3,
		10,
		3, Enemies7,
		{
			0x10, 0x32, 0x11, 0x11, 0x31, 0x3f, 
			0xf1, 0xfa, 0x2f, 0xf1, 0xf2, 0x10, 
			0x33, 0x09, 0xa0, 0xf3, 0x0b, 0x13, 
			0x33, 0x33, 0xb3, 0xf3, 0xf3, 0x3f, 
		},
	},
	{
		(1 << 4) | 0,
		11,
		4, Enemies8,
		{
			0x3f, 0x11, 0x10, 0x13, 0x33, 0x33, 
			0x11, 0xff, 0xf3, 0xff, 0x1f, 0x21, 
			0x33, 0x00, 0x11, 0xf2, 0xf1, 0xb1, 
			0x33, 0xff, 0x33, 0x3b, 0x33, 0x33, 
		},
	},
	{
		(3 << 4) | 0,
		5,
		4, Enemies9,
		{
			0x1f, 0x31, 0x10, 0x13, 0xf1, 0x32, 
			0x1f, 0x32, 0x10, 0x20, 0x31, 0x1b, 
			0x30, 0x1a, 0x20, 0xb3, 0x31, 0x13, 
			0x3f, 0x3b, 0xb3, 0xf3, 0x33, 0x33, 
		},
	},
};
