//
//  FlowLayoutManager.h
//  TabBarApp
//
//  Created by Marcin Maciukiewicz on 11/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CSLayoutManagers.h"

/**
 * Layout component as the go - one after another.
 */
@interface CSFlowLayoutManager : NSObject {
	UIView			*_superview;
	NSMutableArray	*_subviews;
	CGSize			spacing;
	CSDistance			padding;
    BOOL			ignoreHidden;
}

@property(nonatomic,retain)	UIView			*_superview;
@property(nonatomic,assign)	NSMutableArray	*_subviews;
@property					CGSize			spacing;
@property					CSDistance			padding;
@property					BOOL			ignoreHidden;

-(id)initWithSuperview:(UIView*)view;
-(void)addView:(UIView*)subview;
-(void)layoutViews;

@end
