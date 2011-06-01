//
//  CSVerticalLayoutManager.m
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 13/04/2010.
//  Copyright 2010 BluePocket Ltd. All rights reserved.
//

#import "CSVerticalLayoutManager.h"
#import "CSLayoutableWidget.h"

@interface CSVerticalLayoutManager (PrivateMethods)
	-(CGFloat)layoutSubviewsAlignTop;
	-(CGFloat)layoutSubviewsAlignVerticalMiddle;
	-(CGFloat)layoutSubviewsAlignBottom;
	-(CGFloat)layoutSubviewsAlignLeft;
	-(CGFloat)layoutSubviewsAlignHorizontalCenter;
	-(CGFloat)layoutSubviewsAlignRight;
	-(NSArray*)visibleSubviews;
//	-(CGSize)getPreferredSize:(UIView*)aView withMaxSize:(CGSize)maxSize;
@end

@implementation CSVerticalLayoutManager

@synthesize _superview;
@synthesize _subviews;
@synthesize spacing;
@synthesize padding;
@synthesize verticalAlign;
@synthesize horizontalAlign;
@synthesize ignoreHidden;

-(id)init {
    self=[super init];
	if(self){
		self.verticalAlign=CSLayoutVerticalAlignTop;
		self.horizontalAlign=CSLayoutHorizontalAlignLeft;
		self._subviews=[[NSMutableArray alloc] init];
		spacing=CGSizeZero;
		padding=CGDistanceZero;
		ignoreHidden=TRUE;
    }
    return self;
}

-(id)initWithSuperview:(UIView*)view {
    self=[super init];
	if(self){
		self._superview=view;
		self.verticalAlign=CSLayoutVerticalAlignTop;
		self.horizontalAlign=CSLayoutHorizontalAlignLeft;
		self._subviews=[[NSMutableArray alloc] init];
		spacing=CGSizeZero;
		padding=CSDistanceMake(0, 0, 0, 0);
		ignoreHidden=TRUE;
        
        [self addViews:view.subviews];
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

-(CGSize)layoutViews {
	CGFloat preferredHeight=0.0;
	switch (verticalAlign) {
		case CSLayoutVerticalAlignTop:
			preferredHeight=[self layoutSubviewsAlignTop];
			break;
		case CSLayoutVerticalAlignMiddle:
			preferredHeight=[self layoutSubviewsAlignVerticalMiddle];
			break;
		case CSLayoutVerticalAlignBottom:
			preferredHeight=[self layoutSubviewsAlignBottom];
			break;
	}
	
	CGFloat preferredWidth=0.0;
	switch (horizontalAlign) {
		case CSLayoutHorizontalAlignLeft:
			preferredWidth=[self layoutSubviewsAlignLeft];
			break;
		case CSLayoutHorizontalAlignCenter:
			preferredWidth=[self layoutSubviewsAlignHorizontalCenter];
			break;
		case CSLayoutHorizontalAlignRight:
			preferredWidth=[self layoutSubviewsAlignRight];
			break;
	}
	
	return CGSizeMake(preferredWidth, preferredHeight);
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

#pragma mark -
#pragma mark Vertical align
-(CGFloat)layoutSubviewsAlignTop {
	CGFloat verticalOffset=padding.top;
	for (UIView *subview in [self visibleSubviews]) {
		subview.frame=CGRectMake(subview.frame.origin.x, verticalOffset, subview.frame.size.width, subview.frame.size.height);
		verticalOffset+=subview.frame.size.height+spacing.height;
	}
	return verticalOffset;
}

-(CGFloat)layoutSubviewsAlignVerticalMiddle {
	// calculate total height for all widgets
    
	CGFloat totalHeight=0;
	for (UIView *subview in [self visibleSubviews]) {
		totalHeight+=subview.frame.size.height+spacing.height;
	}
	// if there were any widgets at all, then substract last spacing;
	// it is not needed
	if(totalHeight>0){
		totalHeight-=spacing.height;
	}

	
	// align the widgets
	CGRect viewBounds=_superview.bounds;
	CGFloat viewHeight=viewBounds.size.height;
	// if the offset is not 'integer' the the displayed character are fuzzy 
	// (iphone tries to mimic 'double' position
	CGFloat verticalOffset=floor((viewHeight-totalHeight)/2+padding.top);
	for (UIView *subview in [self visibleSubviews]) {
		CGRect subviewFrame=CGRectMake(subview.frame.origin.x, verticalOffset, subview.frame.size.width, subview.frame.size.height);
		[subview setFrame:subviewFrame];
		verticalOffset+=subview.frame.size.height+spacing.height;
	}
	return verticalOffset;
}

-(CGFloat)layoutSubviewsAlignBottom {
	// calculate total height for all widgets
	CGFloat totalHeight=0;
	for (UIView *subview in [self visibleSubviews]) {
		totalHeight+=subview.frame.size.height+spacing.height;
	}
	// if there were any widgets at all, then substract last spacing;
	// it is not needed
	if(totalHeight>0){
		totalHeight-=spacing.height;
	}
	
	// align the widgets
	CGFloat verticalOffset=_superview.bounds.size.height-totalHeight-padding.bottom;
	for (UIView *subview in [self visibleSubviews]) {
		[subview setFrame:CGRectMake(subview.frame.origin.x, verticalOffset, subview.frame.size.width, subview.frame.size.height)];
		verticalOffset+=subview.frame.size.height+spacing.height;
	}
	return verticalOffset;
}

#pragma mark -
#pragma mark Horizontal align
-(CGFloat)layoutSubviewsAlignLeft {
	CGFloat horizontalOffset=padding.left;
	CGFloat result=0.0;
	for (UIView *subview in [self visibleSubviews]) {
		CGRect currentFrame=subview.frame;
		[subview setFrame:CGRectMake(horizontalOffset, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height)];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(CGFloat)layoutSubviewsAlignHorizontalCenter {
	CGFloat viewWidth=_superview.bounds.size.width;
	CGFloat result=0.0;
	for (UIView *subview in [self visibleSubviews]) {
		CGRect currentFrame=subview.frame;
		CGFloat horizontalOffset=floor((viewWidth-currentFrame.size.width-padding.left-padding.right)/2)+padding.left;
		[subview setFrame:CGRectMake(horizontalOffset, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height)];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(CGFloat)layoutSubviewsAlignRight {
	CGFloat viewWidth=_superview.bounds.size.width;
	CGFloat result=0.0;
	for (UIView *subview in [self visibleSubviews]) {
		CGRect currentFrame=subview.frame;
		CGFloat horizontalOffset=viewWidth-currentFrame.size.width-padding.right;
		[subview setFrame:CGRectMake(horizontalOffset, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height)];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(NSArray*)allViews {
	NSArray *result=[NSArray arrayWithArray:self._subviews];
	return result;
}

@end
