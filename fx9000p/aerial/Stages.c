#include "Vram.h"
#include "Stage.h"
#include "Stages.h"

static const SkyElement[] SkyElement0 = {
	{ 0, 0x01 },
	{ 34, 0x00 },
	{ 36, 0x02 },
	{ 46, 0x00 },
	{ 48, 0x01 },
	{ 72, 0x03 },
	{ 82, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement0 = {
	{ 6, 0 },
	{ 10, 1 },
	{ 12, 0 },
	{ 24, 0 },
	{ 40, 0 },
	{ 42, 1 },
	{ 48, 0 },
	{ 68, 0 },
	{ 82, 0 },
	{ 86, 0 },
	{ 90, 0 },
};

static const SkyElement[] SkyElement1 = {
	{ 0, 0x01 },
	{ 34, 0x03 },
	{ 38, 0x02 },
	{ 46, 0x03 },
	{ 50, 0x01 },
	{ 70, 0x03 },
	{ 86, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement1 = {
	{ 4, 0 },
	{ 14, 0 },
	{ 20, 0 },
	{ 22, 1 },
	{ 28, 0 },
	{ 34, 1 },
	{ 40, 0 },
	{ 46, 0 },
	{ 50, 1 },
	{ 52, 0 },
	{ 58, 0 },
	{ 62, 0 },
	{ 68, 0 },
	{ 72, 0 },
	{ 76, 0 },
	{ 80, 1 },
	{ 82, 0 },
	{ 88, 0 },
	{ 90, 0 },
};

static const SkyElement[] SkyElement2 = {
	{ 0, 0x01 },
	{ 30, 0x03 },
	{ 52, 0x01 },
	{ 66, 0x03 },
	{ 88, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement2 = {
	{ 4, 0 },
	{ 8, 1 },
	{ 12, 0 },
	{ 18, 0 },
	{ 22, 1 },
	{ 28, 0 },
	{ 34, 0 },
	{ 40, 1 },
	{ 42, 0 },
	{ 46, 0 },
	{ 52, 0 },
	{ 58, 0 },
	{ 60, 1 },
	{ 64, 0 },
	{ 70, 0 },
	{ 78, 1 },
	{ 82, 0 },
	{ 86, 0 },
	{ 88, 0 },
	{ 92, 0 },
};

static const SkyElement[] SkyElement3 = {
	{ 0, 0x01 },
	{ 28, 0x03 },
	{ 56, 0x01 },
	{ 64, 0x03 },
	{ 92, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement3 = {
	{ 4, 1 },
	{ 6, 0 },
	{ 14, 0 },
	{ 18, 0 },
	{ 22, 1 },
	{ 26, 0 },
	{ 30, 0 },
	{ 34, 1 },
	{ 42, 0 },
	{ 46, 1 },
	{ 48, 0 },
	{ 52, 1 },
	{ 56, 0 },
	{ 60, 0 },
	{ 64, 1 },
	{ 70, 0 },
	{ 74, 0 },
	{ 82, 0 },
	{ 86, 0 },
	{ 90, 1 },
};

static const SkyElement[] SkyElement4 = {
	{ 0, 0x01 },
	{ 24, 0x03 },
	{ 92, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement4 = {
	{ 4, 0 },
	{ 6, 1 },
	{ 10, 0 },
	{ 16, 0 },
	{ 24, 0 },
	{ 28, 1 },
	{ 30, 0 },
	{ 34, 0 },
	{ 40, 1 },
	{ 44, 0 },
	{ 48, 0 },
	{ 52, 0 },
	{ 54, 1 },
	{ 58, 0 },
	{ 64, 0 },
	{ 70, 1 },
	{ 74, 0 },
	{ 76, 0 },
	{ 82, 0 },
	{ 88, 0 },
};

static const SkyElement[] SkyElement5 = {
	{ 0, 0x01 },
	{ 2, 0x03 },
	{ 4, 0x02 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement5 = {
	{ 8, 1 },
	{ 10, 1 },
	{ 16, 0 },
	{ 20, 0 },
	{ 24, 1 },
	{ 28, 1 },
	{ 34, 1 },
	{ 40, 1 },
	{ 46, 0 },
	{ 52, 1 },
	{ 58, 1 },
	{ 64, 0 },
	{ 70, 1 },
	{ 74, 1 },
	{ 78, 1 },
	{ 86, 0 },
	{ 88, 1 },
};

static const SkyElement[] SkyElement6 = {
	{ 0, 0x01 },
	{ 22, 0x03 },
	{ 92, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement6 = {
	{ 4, 0 },
	{ 10, 0 },
	{ 14, 0 },
	{ 16, 1 },
	{ 22, 0 },
	{ 26, 0 },
	{ 28, 0 },
	{ 30, 1 },
	{ 34, 1 },
	{ 38, 0 },
	{ 42, 0 },
	{ 52, 0 },
	{ 58, 0 },
	{ 62, 1 },
	{ 64, 0 },
	{ 70, 1 },
	{ 76, 0 },
	{ 78, 0 },
	{ 82, 1 },
};

static const SkyElement[] SkyElement7 = {
	{ 0, 0x01 },
	{ 18, 0x03 },
	{ 92, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement7 = {
	{ 8, 0 },
	{ 12, 0 },
	{ 16, 1 },
	{ 22, 1 },
	{ 28, 0 },
	{ 30, 1 },
	{ 32, 0 },
	{ 36, 0 },
	{ 44, 1 },
	{ 46, 0 },
	{ 52, 0 },
	{ 58, 0 },
	{ 64, 0 },
	{ 68, 0 },
	{ 72, 1 },
	{ 74, 0 },
	{ 76, 0 },
	{ 84, 1 },
	{ 88, 0 },
	{ 92, 0 },
};

static const SkyElement[] SkyElement8 = {
	{ 0, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement8 = {
	{ 8, 0 },
	{ 10, 0 },
	{ 18, 0 },
	{ 22, 0 },
	{ 30, 1 },
	{ 32, 0 },
	{ 36, 0 },
	{ 40, 0 },
	{ 48, 0 },
	{ 52, 0 },
	{ 54, 1 },
	{ 58, 0 },
	{ 60, 0 },
	{ 64, 0 },
	{ 66, 1 },
	{ 70, 0 },
	{ 74, 0 },
	{ 76, 0 },
	{ 80, 0 },
	{ 82, 0 },
	{ 88, 0 },
	{ 90, 0 },
};

static const SkyElement[] SkyElement9 = {
	{ 0, 0x01 },
	{ 2, 0x03 },
	{ 92, 0x01 },
	{ 94, 0x00 },
};

static const GroundElement[] GroundElement9 = {
	{ 2, 0 },
	{ 6, 0 },
	{ 14, 1 },
	{ 18, 0 },
	{ 22, 0 },
	{ 26, 1 },
	{ 28, 0 },
	{ 34, 0 },
	{ 38, 0 },
	{ 42, 1 },
	{ 48, 0 },
	{ 52, 0 },
	{ 64, 0 },
	{ 66, 1 },
	{ 70, 0 },
	{ 74, 0 },
	{ 84, 0 },
	{ 86, 0 },
	{ 94, 1 },
};

const Stage[] Stages = {
	{
		{
			0x21, 0x00, 0x21, 0x10, 0x08, 0x00, 0x10, 0x42, 
			0x02, 0x21, 0x00, 0x00, 		},
		8, SkyElement0,
		11, GroundElement0,
	},
	{
		{
			0x40, 0x26, 0x09, 0x09, 0x90, 0x24, 0x00, 0x00, 
			0x00, 0x00, 0x00, 0x00, 		},
		8, SkyElement1,
		19, GroundElement1,
	},
	{
		{
			0x00, 0x00, 0x00, 0x40, 0x92, 0x10, 0x48, 0x02, 
			0x00, 0x19, 0x02, 0x00, 		},
		6, SkyElement2,
		20, GroundElement2,
	},
	{
		{
			0x00, 0x01, 0x02, 0x00, 0x61, 0x00, 0x80, 0x40, 
			0x20, 0x91, 0x02, 0x21, 		},
		6, SkyElement3,
		20, GroundElement3,
	},
	{
		{
			0x01, 0x92, 0x10, 0x00, 0x80, 0x40, 0x00, 0x90, 
			0x20, 0x01, 0x00, 0x20, 		},
		4, SkyElement4,
		20, GroundElement4,
	},
	{
		{
			0x10, 0x80, 0x40, 0x40, 0x92, 0x24, 0x49, 0x92, 
			0x20, 0x00, 0x04, 0x80, 		},
		4, SkyElement5,
		17, GroundElement5,
	},
	{
		{
			0x40, 0x10, 0x00, 0x00, 0x22, 0x10, 0x00, 0x00, 
			0x20, 0x01, 0x01, 0x88, 		},
		4, SkyElement6,
		19, GroundElement6,
	},
	{
		{
			0x10, 0x04, 0x00, 0x08, 0x04, 0x0a, 0x00, 0x51, 
			0x88, 0x40, 0x0a, 0x00, 		},
		4, SkyElement7,
		20, GroundElement7,
	},
	{
		{
			0x14, 0x00, 0x01, 0x2a, 0x44, 0xa0, 0x00, 0x00, 
			0x10, 0x81, 0x90, 0x80, 		},
		2, SkyElement8,
		22, GroundElement8,
	},
	{
		{
			0x00, 0x15, 0x22, 0x00, 0x11, 0x42, 0x80, 0x88, 
			0x00, 0x10, 0x05, 0x2a, 		},
		4, SkyElement9,
		19, GroundElement9,
	},
};
