#include "Stage.h"
#include "Stages.h"

static const byte[] Enemies0 = {
	(14 << 4) | 0,
};

static const byte[] Enemies1 = {
	(10 << 4) | 0,
	(1 << 4) | 1,
};

static const byte[] Enemies2 = {
	(7 << 4) | 0,
	(5 << 4) | 1,
};

static const byte[] Enemies3 = {
	(14 << 4) | 0,
	(7 << 4) | 3,
};

static const byte[] Enemies4 = {
	(0 << 4) | 0,
	(6 << 4) | 2,
	(8 << 4) | 3,
};

static const byte[] Enemies5 = {
	(3 << 4) | 0,
	(5 << 4) | 1,
	(13 << 4) | 1,
};

static const byte[] Enemies6 = {
	(13 << 4) | 0,
	(13 << 4) | 1,
	(11 << 4) | 4,
};

static const byte[] Enemies7 = {
	(12 << 4) | 0,
	(15 << 4) | 0,
	(0 << 4) | 3,
};

static const byte[] Enemies8 = {
	(8 << 4) | 0,
	(11 << 4) | 0,
	(14 << 4) | 0,
	(15 << 4) | 3,
};

static const byte[] Enemies9 = {
	(8 << 4) | 0,
	(14 << 4) | 0,
	(12 << 4) | 2,
	(13 << 4) | 3,
};

const Stage[] Stages = {
	{
		(1 << 4) | 5,
		15,
		1, Enemies0,
		{
			0xf2, 0x53, 0x33, 0x3f, 0x55, 0x55, 0x33, 0x23, 
			0x3a, 0xf0, 0x33, 0x53, 0x53, 0xf3, 0xf3, 0xa3, 
			0xfa, 0x33, 0x3f, 0x33, 0xf0, 0x30, 0x55, 0xa3, 
			0x3a, 0xf3, 0x33, 0x53, 0x55, 0x05, 0x3f, 0xa3, 
			0x3a, 0x5f, 0x55, 0x55, 0xf5, 0x33, 0xf3, 0xa3, 
			0x3b, 0x33, 0xf3, 0x33, 0xf3, 0x33, 0x33, 0xb3, 
		},
	},
	{
		(12 << 4) | 5,
		20,
		2, Enemies1,
		{
			0xff, 0x23, 0x35, 0x33, 0x33, 0x33, 0xf3, 0x0f, 
			0x3f, 0xa3, 0xf3, 0xf2, 0x23, 0xf3, 0x03, 0x30, 
			0x55, 0xa3, 0x33, 0x3a, 0xa3, 0xf0, 0x3f, 0x30, 
			0xff, 0xb0, 0x3f, 0x0a, 0xaf, 0x05, 0xf2, 0xf5, 
			0x32, 0x03, 0x23, 0x0b, 0xa0, 0x35, 0x5a, 0x33, 
			0xfb, 0x33, 0xbf, 0x33, 0xb3, 0x33, 0x3b, 0xff, 
		},
	},
	{
		(15 << 4) | 0,
		22,
		2, Enemies2,
		{
			0x5f, 0xf5, 0x35, 0x33, 0xf3, 0x3f, 0x33, 0x32, 
			0x25, 0x20, 0x33, 0x23, 0x3f, 0xf5, 0x5f, 0xfa, 
			0xaf, 0xa3, 0x03, 0xaf, 0x0f, 0x33, 0x02, 0x5a, 
			0xb5, 0xa3, 0x3f, 0xa3, 0x30, 0x5f, 0x3b, 0x5a, 
			0x53, 0xaf, 0x3f, 0xbf, 0xf3, 0xf0, 0xf0, 0x5a, 
			0xf3, 0xb3, 0xf3, 0x3f, 0x37, 0x33, 0x33, 0x3b, 
		},
	},
	{
		(1 << 4) | 0,
		17,
		2, Enemies3,
		{
			0x30, 0xf5, 0x0f, 0x53, 0x52, 0x55, 0x3f, 0x03, 
			0x30, 0x05, 0x53, 0x0f, 0x3a, 0x05, 0x23, 0x5f, 
			0xf3, 0x32, 0x30, 0x00, 0x3b, 0x23, 0xaf, 0x03, 
			0x55, 0xfa, 0xf0, 0x35, 0x03, 0xb0, 0xb0, 0x25, 
			0x0f, 0x5a, 0x03, 0x3f, 0x00, 0x53, 0x53, 0xa5, 
			0xff, 0xfb, 0x33, 0x3f, 0x33, 0x3f, 0x3f, 0xb3, 
		},
	},
	{
		(15 << 4) | 0,
		24,
		3, Enemies4,
		{
			0x53, 0xff, 0x3f, 0xff, 0x32, 0x5f, 0xf5, 0x33, 
			0xf3, 0x20, 0x55, 0x30, 0xfa, 0x02, 0xf5, 0x05, 
			0x3f, 0xa3, 0xf0, 0x03, 0x3a, 0x3a, 0x03, 0xf5, 
			0x53, 0xa5, 0xf0, 0x3f, 0x5b, 0x0a, 0x03, 0x55, 
			0x3f, 0xa3, 0xf0, 0x33, 0x5f, 0x3a, 0x33, 0x0f, 
			0xff, 0xbf, 0x33, 0xf7, 0x37, 0x7b, 0x3f, 0x33, 
		},
	},
	{
		(3 << 4) | 5,
		20,
		3, Enemies5,
		{
			0x52, 0x35, 0xf3, 0xf2, 0x53, 0x55, 0xff, 0x05, 
			0x0a, 0x00, 0x3f, 0x5a, 0x35, 0x30, 0x30, 0x5f, 
			0x3a, 0x32, 0xf3, 0xfb, 0xf0, 0x53, 0x53, 0xf5, 
			0x5a, 0x5a, 0x5f, 0x23, 0xf5, 0x00, 0x05, 0x30, 
			0xfb, 0xfa, 0x53, 0xa3, 0x33, 0x30, 0x3f, 0xf5, 
			0x7f, 0x3b, 0xf7, 0xb3, 0xf3, 0x73, 0xf3, 0x33, 
		},
	},
	{
		(0 << 4) | 0,
		23,
		3, Enemies6,
		{
			0x33, 0x55, 0x55, 0x0f, 0xf5, 0x35, 0x35, 0x25, 
			0x52, 0xf3, 0xf5, 0x30, 0x0f, 0xff, 0x35, 0xaf, 
			0x0a, 0x55, 0x32, 0xf3, 0x35, 0x53, 0xf2, 0xb5, 
			0xfb, 0x0f, 0x5b, 0x35, 0x33, 0xf3, 0x5a, 0x0f, 
			0x52, 0x0f, 0xff, 0x3f, 0x35, 0x33, 0x5a, 0x0f, 
			0x7b, 0x33, 0xf3, 0x33, 0x3f, 0xf7, 0xfb, 0x33, 
		},
	},
	{
		(3 << 4) | 5,
		21,
		3, Enemies7,
		{
			0x50, 0x20, 0x53, 0x55, 0x55, 0xf5, 0xf3, 0x33, 
			0xf3, 0xa5, 0xff, 0x53, 0xf3, 0x23, 0x0f, 0x05, 
			0x05, 0xbf, 0x0f, 0xf2, 0x35, 0xa5, 0x00, 0x05, 
			0x33, 0x53, 0x00, 0x0a, 0x33, 0xbf, 0x30, 0x5f, 
			0x50, 0x33, 0x00, 0x3a, 0xf5, 0x55, 0xff, 0x2f, 
			0xf3, 0x33, 0x33, 0xfb, 0xf3, 0xf3, 0x33, 0xbf, 
		},
	},
	{
		(1 << 4) | 0,
		24,
		4, Enemies8,
		{
			0x3f, 0x05, 0x05, 0x5f, 0x53, 0x3f, 0x33, 0x23, 
			0xf5, 0x3f, 0x0f, 0xf0, 0xff, 0xf3, 0x55, 0xa3, 
			0x5f, 0x00, 0x33, 0x33, 0xf0, 0x3f, 0x53, 0xaf, 
			0x33, 0x00, 0x50, 0x55, 0xf2, 0x35, 0x5f, 0xbf, 
			0x55, 0x00, 0xf3, 0x5f, 0x5a, 0xf5, 0x50, 0x25, 
			0x77, 0x33, 0x3f, 0x3f, 0xfb, 0x33, 0x33, 0xbf, 
		},
	},
	{
		(4 << 4) | 0,
		17,
		4, Enemies9,
		{
			0x5f, 0x35, 0x03, 0xf5, 0x53, 0x35, 0x2f, 0x53, 
			0x5f, 0x00, 0x00, 0xf5, 0x00, 0x05, 0xb2, 0xf0, 
			0x33, 0x20, 0x03, 0xf5, 0x20, 0x3f, 0x0b, 0xf5, 
			0x30, 0xa3, 0x05, 0x2f, 0xb3, 0x50, 0x33, 0x55, 
			0x5f, 0xa3, 0x35, 0xaf, 0xf5, 0x33, 0x05, 0xf5, 
			0x33, 0xbf, 0x37, 0xb3, 0x33, 0x37, 0x3f, 0xf3, 
		},
	},
};
