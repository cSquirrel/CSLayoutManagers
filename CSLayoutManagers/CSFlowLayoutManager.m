//
//  FlowLayoutManager.m
//  TabBarApp
//
//  Created by Marcin Maciukiewicz on 11/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSFlowLayoutManager.h"

#pragma -
@interface CSFlowLayoutManager (PrivateMethods)
    
    -(NSArray*)visibleSubviews;
@end

#pragma -
@implementation CSFlowLayoutManager

@synthesize _superview;
@synthesize _subviews;
@synthesize spacing;
@synthesize padding;
@synthesize ignoreHidden;

-(id)init {
    self=[super init];
	if(self){
		self._subviews=[[NSMutableArray alloc] init];
		spacing=CGSizeZero;
		padding=CGDistanceZero;
        ignoreHidden=TRUE;
	}
	return self;
}

-(id)initWithSuperview:(UIView*)superview {
    self=[super init];
	if(self){
		self._superview=superview;
		self._subviews=[[NSMutableArray alloc] init];
		spacing=CGSizeZero;
		padding=CGDistanceZero;
        ignoreHidden=TRUE;
	}
	return self;
}

-(void)dealloc {
	[_superview release];
	[_subviews release];
	
	[super dealloc];
}

-(void)addView:(UIView*)subview {
    if(!_superview) {
        self._superview=subview.superview;
    } else {
        NSAssert((subview.superview==self._superview),@"Added view must have same superview as other added views.");
    }
	[_subviews addObject:subview];
}

-(void)addViews:(NSArray*/*UIView*/)subviews {
    [subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [self addView:(UIView*)obj]; 
    }];
}

-(NSArray*)visibleSubviews {
    // always build new list of views
    // we never know when they go hidden or removed from parent
	NSArray *result;
	// filter if should ignore invisible widgets
	if(ignoreHidden){
		NSMutableArray *visibleViews=[[NSMutableArray alloc] init];
        [_subviews enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UIView *subview=(UIView*)obj;
			if(!subview.hidden){
				[visibleViews addObject:subview];
			}
        }];
		result=visibleViews;
	} else {
		result=_subviews;
	}
	return result;
}

-(void)layoutViews {

	CGFloat offsetX=padding.left;
	CGFloat offsetY=padding.top;
	CGFloat rowHeight=0;
    CGRect superviewBounds=_superview.bounds;
    
	for (UIView *subview in [self visibleSubviews]) {
        // will the view exceed superview's bounds?
        // if yes then start a new line
        CGRect currentFrame=subview.frame;
        if(offsetX+currentFrame.size.width>superviewBounds.size.width) {
            // new line
            offsetY+=rowHeight;
            rowHeight=0;
            offsetX=padding.left;
        }
        
        
		[subview setFrame:CGRectMake(offsetX, offsetY, subview.frame.size.width, subview.frame.size.height)];
		if(subview.frame.size.height>rowHeight){
			rowHeight=subview.frame.size.height;
		}
		offsetX+=subview.frame.size.width+spacing.width;
	}
}

@end
