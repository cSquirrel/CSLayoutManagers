//
//  CSLayoutManagers.h
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 01/06/2011.
//  Copyright 2011 BluePocket Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>

enum {
	CSLayoutVerticalAlignTop,
	CSLayoutVerticalAlignMiddle,
	CSLayoutVerticalAlignBottom
    /*,CSVerticalAlignJustify // components spread evenly */
} typedef CSLayoutVerticalAlign;

enum {
	CSLayoutHorizontalAlignLeft,
	CSLayoutHorizontalAlignCenter,
	CSLayoutHorizontalAlignRight
    /*,CSHorizontalAlignJustify // components spread evenly */
} typedef CSLayoutHorizontalAlign;

struct {
	CGFloat	top;
	CGFloat	right;
	CGFloat	bottom;
	CGFloat	left;
} typedef CSDistance;

CG_INLINE CSDistance CSDistanceMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left) {
	CSDistance size; size.top = top; size.right = right; size.bottom = bottom; size.left = left; return size;
}

#define CGDistanceZero CSDistanceMake(0, 0, 0, 0)

#import "CSLayoutableWidget.h"
#include "CSVerticalLayoutManager.h"
#include "CSFlowLayoutManager.h"