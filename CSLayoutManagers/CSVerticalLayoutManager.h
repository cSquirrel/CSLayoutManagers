//
//  CSVerticalLayoutManager.m
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 13/04/2010.
//  Copyright 2010 BluePocket Ltd. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#include "CSLayoutManagers.h"

/**
 * Layout components in vertical lign.
 * Alignment may be applied:
 */
@interface CSVerticalLayoutManager : NSObject {
	CSLayoutVerticalAlign	verticalAlign;
	CSLayoutHorizontalAlign	horizontalAlign;
	UIView			*_superview;
	NSMutableArray	*_subviews;
	CGSize			spacing;
	CSDistance		padding;
	BOOL			ignoreHidden;
}

@property(nonatomic,retain)	UIView			*_superview;
@property(nonatomic,assign)	NSMutableArray	*_subviews;
@property					CGSize			spacing;
@property					CSDistance		padding;
@property					CSLayoutVerticalAlign	verticalAlign;
@property					CSLayoutHorizontalAlign	horizontalAlign;
@property					BOOL			ignoreHidden;

-(id)init;
-(id)initWithSuperview:(UIView*)view;
-(void)addView:(UIView*)subview;
-(void)addViews:(NSArray*/*UIView*/)subviews;
-(CGSize)layoutViews;
-(NSArray*)allViews;

@end
