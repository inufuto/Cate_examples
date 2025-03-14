#include "Vram.h"
#include "Stage.h"
#include "Stages.h"

static const SkyElement[] SkyElement0 = {
	{ 0, 0x01 },
	{ 46, 0x00 },
	{ 48, 0x02 },
	{ 62, 0x00 },
	{ 64, 0x01 },
	{ 96, 0x03 },
	{ 110, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement0 = {
	{ 8, 0 },
	{ 12, 1 },
	{ 16, 0 },
	{ 32, 0 },
	{ 52, 0 },
	{ 56, 1 },
	{ 64, 0 },
	{ 90, 0 },
	{ 110, 0 },
	{ 114, 0 },
	{ 120, 0 },
};

static const SkyElement[] SkyElement1 = {
	{ 0, 0x01 },
	{ 44, 0x03 },
	{ 50, 0x02 },
	{ 60, 0x03 },
	{ 66, 0x01 },
	{ 92, 0x03 },
	{ 114, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement1 = {
	{ 6, 0 },
	{ 18, 0 },
	{ 26, 0 },
	{ 30, 1 },
	{ 38, 0 },
	{ 46, 1 },
	{ 54, 0 },
	{ 60, 0 },
	{ 66, 1 },
	{ 70, 0 },
	{ 76, 0 },
	{ 82, 0 },
	{ 90, 0 },
	{ 96, 0 },
	{ 102, 0 },
	{ 106, 1 },
	{ 110, 0 },
	{ 116, 0 },
	{ 120, 0 },
};

static const SkyElement[] SkyElement2 = {
	{ 0, 0x01 },
	{ 40, 0x03 },
	{ 70, 0x01 },
	{ 88, 0x03 },
	{ 118, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement2 = {
	{ 6, 0 },
	{ 10, 1 },
	{ 16, 0 },
	{ 24, 0 },
	{ 28, 1 },
	{ 36, 0 },
	{ 46, 0 },
	{ 52, 1 },
	{ 56, 0 },
	{ 62, 0 },
	{ 70, 0 },
	{ 76, 0 },
	{ 80, 1 },
	{ 84, 0 },
	{ 92, 0 },
	{ 104, 1 },
	{ 108, 0 },
	{ 114, 0 },
	{ 118, 0 },
	{ 122, 0 },
};

static const SkyElement[] SkyElement3 = {
	{ 0, 0x01 },
	{ 36, 0x03 },
	{ 74, 0x01 },
	{ 84, 0x03 },
	{ 122, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement3 = {
	{ 4, 1 },
	{ 8, 0 },
	{ 18, 0 },
	{ 24, 0 },
	{ 28, 1 },
	{ 34, 0 },
	{ 40, 0 },
	{ 44, 1 },
	{ 56, 0 },
	{ 60, 1 },
	{ 64, 0 },
	{ 68, 1 },
	{ 74, 0 },
	{ 80, 0 },
	{ 84, 1 },
	{ 92, 0 },
	{ 98, 0 },
	{ 110, 0 },
	{ 114, 0 },
	{ 120, 1 },
};

static const SkyElement[] SkyElement4 = {
	{ 0, 0x01 },
	{ 32, 0x03 },
	{ 124, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement4 = {
	{ 4, 0 },
	{ 8, 1 },
	{ 12, 0 },
	{ 20, 0 },
	{ 32, 0 },
	{ 36, 1 },
	{ 40, 0 },
	{ 46, 0 },
	{ 52, 1 },
	{ 58, 0 },
	{ 64, 0 },
	{ 68, 0 },
	{ 72, 1 },
	{ 78, 0 },
	{ 86, 0 },
	{ 92, 1 },
	{ 98, 0 },
	{ 102, 0 },
	{ 108, 0 },
	{ 116, 0 },
};

static const SkyElement[] SkyElement5 = {
	{ 0, 0x01 },
	{ 2, 0x03 },
	{ 4, 0x02 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement5 = {
	{ 10, 1 },
	{ 14, 1 },
	{ 22, 0 },
	{ 26, 0 },
	{ 32, 1 },
	{ 38, 1 },
	{ 46, 1 },
	{ 54, 1 },
	{ 62, 0 },
	{ 70, 1 },
	{ 78, 1 },
	{ 84, 0 },
	{ 92, 1 },
	{ 98, 1 },
	{ 104, 1 },
	{ 114, 0 },
	{ 116, 1 },
};

static const SkyElement[] SkyElement6 = {
	{ 0, 0x01 },
	{ 28, 0x03 },
	{ 124, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement6 = {
	{ 6, 0 },
	{ 12, 0 },
	{ 18, 0 },
	{ 22, 1 },
	{ 28, 0 },
	{ 34, 0 },
	{ 36, 0 },
	{ 40, 1 },
	{ 46, 1 },
	{ 50, 0 },
	{ 56, 0 },
	{ 68, 0 },
	{ 76, 0 },
	{ 82, 1 },
	{ 86, 0 },
	{ 94, 1 },
	{ 100, 0 },
	{ 102, 0 },
	{ 104, 0 },
	{ 110, 1 },
};

static const SkyElement[] SkyElement7 = {
	{ 0, 0x01 },
	{ 24, 0x03 },
	{ 124, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement7 = {
	{ 10, 0 },
	{ 16, 0 },
	{ 22, 1 },
	{ 28, 1 },
	{ 36, 0 },
	{ 40, 1 },
	{ 42, 0 },
	{ 48, 0 },
	{ 58, 1 },
	{ 62, 0 },
	{ 68, 0 },
	{ 78, 0 },
	{ 86, 0 },
	{ 90, 0 },
	{ 96, 1 },
	{ 98, 0 },
	{ 102, 0 },
	{ 112, 1 },
	{ 118, 0 },
	{ 124, 0 },
};

static const SkyElement[] SkyElement8 = {
	{ 0, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement8 = {
	{ 10, 0 },
	{ 14, 0 },
	{ 24, 0 },
	{ 28, 0 },
	{ 40, 1 },
	{ 44, 0 },
	{ 48, 0 },
	{ 54, 0 },
	{ 64, 0 },
	{ 68, 0 },
	{ 72, 1 },
	{ 76, 0 },
	{ 80, 0 },
	{ 84, 0 },
	{ 88, 1 },
	{ 92, 0 },
	{ 98, 0 },
	{ 102, 0 },
	{ 106, 0 },
	{ 110, 0 },
	{ 116, 0 },
	{ 120, 0 },
};

static const SkyElement[] SkyElement9 = {
	{ 0, 0x01 },
	{ 2, 0x03 },
	{ 124, 0x01 },
	{ 126, 0x00 },
};

static const GroundElement[] GroundElement9 = {
	{ 2, 0 },
	{ 8, 0 },
	{ 18, 1 },
	{ 24, 0 },
	{ 28, 0 },
	{ 34, 1 },
	{ 38, 0 },
	{ 46, 0 },
	{ 52, 0 },
	{ 56, 1 },
	{ 64, 0 },
	{ 68, 0 },
	{ 84, 0 },
	{ 88, 1 },
	{ 92, 0 },
	{ 98, 0 },
	{ 112, 0 },
	{ 114, 0 },
	{ 124, 1 },
};

const Stage[] Stages = {
	{
		{
			0x21, 0x00, 0x90, 0x09, 0x10, 0x80, 0x00, 0x00, 
			0x40, 0x08, 0x24, 0x00, 0xa5, 0x10, 0x80, 0x00, 
		},
		8, SkyElement0,
		11, GroundElement0,
	},
	{
		{
			0x10, 0x48, 0x00, 0x00, 0x08, 0x10, 0x18, 0x80, 
			0x00, 0x04, 0x20, 0x10, 0x00, 0x12, 0x06, 0x08, 
		},
		8, SkyElement1,
		19, GroundElement1,
	},
	{
		{
			0x10, 0x80, 0x00, 0x00, 0x00, 0x25, 0x48, 0x04, 
			0x20, 0x08, 0x00, 0x44, 0x5a, 0x88, 0x01, 0x20, 
		},
		6, SkyElement2,
		20, GroundElement2,
	},
	{
		{
			0x84, 0x04, 0x21, 0x00, 0x00, 0x84, 0x56, 0x00, 
			0x80, 0x02, 0x04, 0x4a, 0x61, 0x29, 0x10, 0x28, 
		},
		6, SkyElement3,
		20, GroundElement3,
	},
	{
		{
			0x05, 0x08, 0x00, 0x56, 0x00, 0x20, 0x88, 0x51, 
			0x80, 0x00, 0x29, 0x48, 0x01, 0x04, 0x00, 0x2a, 
		},
		4, SkyElement4,
		20, GroundElement4,
	},
	{
		{
			0x50, 0x01, 0x0a, 0x40, 0x10, 0x00, 0x00, 0x00, 
			0x00, 0x00, 0x80, 0x0a, 0x00, 0x40, 0x41, 0x2a, 
		},
		4, SkyElement5,
		17, GroundElement5,
	},
	{
		{
			0x00, 0x45, 0x01, 0x00, 0x00, 0x28, 0x02, 0x00, 
			0x04, 0x04, 0x00, 0x2a, 0x05, 0x14, 0x80, 0x2a, 
		},
		4, SkyElement6,
		20, GroundElement6,
	},
	{
		{
			0x50, 0x41, 0x00, 0x00, 0x0a, 0x50, 0xa0, 0x02, 
			0x02, 0x14, 0x15, 0xa2, 0x10, 0xa8, 0x00, 0x00, 
		},
		4, SkyElement7,
		20, GroundElement7,
	},
	{
		{
			0x54, 0x01, 0x58, 0x80, 0xaa, 0x44, 0x14, 0xa8, 
			0x08, 0x00, 0x04, 0x44, 0x01, 0x02, 0x08, 0x28, 
		},
		2, SkyElement8,
		22, GroundElement8,
	},
	{
		{
			0x40, 0x54, 0xa1, 0x80, 0x00, 0x14, 0x81, 0x40, 
			0x00, 0xa2, 0x82, 0x00, 0x01, 0x55, 0xa0, 0x2a, 
		},
		4, SkyElement9,
		19, GroundElement9,
	},
};
