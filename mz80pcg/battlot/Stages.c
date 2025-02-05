#include "Stage.h"
#include "Stages.h"
const Stage[] Stages = {
	{
		(0 << 4) | 9,
		(14 << 4) | 0,
		{
			0x0a, 0xaa, 0x0a, 0x02, 
			0x0a, 0xaa, 0x0a, 0x02, 
			0x02, 0xaa, 0x2a, 0xa2, 
			0x8a, 0x0a, 0x00, 0x22, 
			0x0a, 0x80, 0x2a, 0x82, 
			0x22, 0xa8, 0x02, 0x80, 
			0x20, 0xa8, 0x22, 0x8a, 
			0x28, 0xa8, 0xa2, 0x8a, 
			0x20, 0xa8, 0xa2, 0x8a, 
			0x20, 0xa8, 0xa2, 0xa8, 
			0x00, 0x00, 0xa0, 0xa8, 
		},
	},
	{
		(0 << 4) | 0,
		(14 << 4) | 9,
		{
			0x00, 0x88, 0x22, 0x00, 
			0xa0, 0xfa, 0xff, 0x88, 
			0x00, 0x80, 0x02, 0x88, 
			0x28, 0x80, 0x2a, 0x88, 
			0xa8, 0x82, 0x2a, 0x00, 
			0xa8, 0x00, 0x28, 0xaa, 
			0xaa, 0x02, 0x0a, 0xaa, 
			0x02, 0x00, 0x00, 0xa0, 
			0xaa, 0x8a, 0x00, 0x02, 
			0x00, 0x00, 0xc0, 0x0a, 
			0xaa, 0x2a, 0xea, 0x0a, 
		},
	},
	{
		(0 << 4) | 0,
		(14 << 4) | 0,
		{
			0x00, 0x0a, 0x03, 0x00, 
			0x00, 0xa8, 0x03, 0x08, 
			0x0a, 0xa8, 0x2b, 0x88, 
			0x82, 0x08, 0x03, 0xfc, 
			0x8a, 0x00, 0x03, 0x00, 
			0x08, 0xa8, 0x02, 0x00, 
			0x8a, 0xa0, 0x08, 0x08, 
			0x00, 0xa8, 0x08, 0xa8, 
			0x2a, 0x00, 0xc0, 0xff, 
			0x00, 0xa2, 0x20, 0x20, 
			0x82, 0xa0, 0x00, 0x00, 
		},
	},
	{
		(2 << 4) | 5,
		(14 << 4) | 9,
		{
			0x0a, 0x02, 0x8c, 0x02, 
			0x8a, 0x8a, 0x0e, 0x20, 
			0x00, 0x8a, 0xe0, 0xbf, 
			0x08, 0xaa, 0x00, 0x80, 
			0x00, 0x80, 0xa0, 0x02, 
			0x00, 0x88, 0x20, 0x00, 
			0x02, 0xc0, 0x00, 0x03, 
			0x00, 0x00, 0x00, 0x03, 
			0x20, 0xa8, 0x00, 0x83, 
			0x2a, 0x28, 0x00, 0x03, 
			0x8a, 0x20, 0x00, 0x03, 
		},
	},
	{
		(14 << 4) | 2,
		(2 << 4) | 4,
		{
			0x80, 0x20, 0x20, 0x80, 
			0x80, 0xa3, 0x20, 0x20, 
			0x00, 0x03, 0x20, 0x03, 
			0x22, 0x03, 0x00, 0x0b, 
			0x00, 0x03, 0x00, 0x8a, 
			0x00, 0x83, 0x00, 0x80, 
			0xf0, 0xff, 0x3f, 0x00, 
			0x88, 0x0a, 0x88, 0x02, 
			0x00, 0x00, 0x80, 0x00, 
			0x00, 0x02, 0x0a, 0x00, 
			0x02, 0x03, 0x00, 0x00, 
		},
	},
	{
		(0 << 4) | 1,
		(14 << 4) | 0,
		{
			0x08, 0x00, 0xc0, 0x08, 
			0x00, 0x00, 0xe0, 0x02, 
			0x00, 0x00, 0xc0, 0x20, 
			0x02, 0x00, 0xc0, 0x00, 
			0x00, 0x00, 0xc2, 0x00, 
			0x22, 0x02, 0xc2, 0x00, 
			0x00, 0x00, 0x00, 0xf0, 
			0x00, 0xfb, 0x03, 0x80, 
			0x80, 0x00, 0x80, 0x20, 
			0x8f, 0xaa, 0x02, 0x20, 
			0x82, 0x0a, 0x00, 0x00, 
		},
	},
	{
		(0 << 4) | 9,
		(14 << 4) | 0,
		{
			0x00, 0x3c, 0x03, 0x03, 
			0xa8, 0x02, 0x83, 0x03, 
			0x00, 0x00, 0x03, 0x00, 
			0xa8, 0x02, 0x83, 0x00, 
			0x00, 0x20, 0xc0, 0x22, 
			0x00, 0xca, 0xc0, 0x2a, 
			0x00, 0x08, 0xc0, 0x00, 
			0x22, 0x0c, 0xc8, 0xa8, 
			0x20, 0x2c, 0x08, 0x00, 
			0x00, 0x0c, 0x00, 0xa8, 
			0x00, 0x0c, 0x30, 0x00, 
		},
	},
	{
		(12 << 4) | 0,
		(5 << 4) | 9,
		{
			0x00, 0x00, 0x2c, 0x30, 
			0x00, 0x38, 0x0c, 0x00, 
			0x80, 0x30, 0x0c, 0x00, 
			0x00, 0x30, 0xfc, 0x2a, 
			0x00, 0x30, 0x0c, 0x00, 
			0x08, 0x30, 0x0c, 0x00, 
			0x00, 0xb0, 0x00, 0x00, 
			0xc0, 0xc0, 0x08, 0x20, 
			0xf0, 0xff, 0xff, 0x00, 
			0xc0, 0xc0, 0x02, 0x00, 
			0x00, 0xc0, 0x3f, 0x00, 
		},
	},
	{
		(0 << 4) | 9,
		(14 << 4) | 0,
		{
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 
		},
	},
	{
		(0 << 4) | 9,
		(14 << 4) | 9,
		{
			0x80, 0x0b, 0xb8, 0x00, 
			0x0c, 0xc3, 0x30, 0x2c, 
			0x2c, 0xe3, 0x38, 0x0e, 
			0x0c, 0xc3, 0x30, 0x8c, 
			0x8c, 0xcb, 0xb2, 0x0c, 
			0x0c, 0xc3, 0x30, 0x2c, 
			0x2c, 0xe3, 0x38, 0x0e, 
			0x0c, 0xc3, 0x30, 0x8c, 
			0x0c, 0xcb, 0xb2, 0x0c, 
			0x20, 0xc3, 0x30, 0x0c, 
			0x20, 0xe0, 0x02, 0x0e, 
		},
	},
};
