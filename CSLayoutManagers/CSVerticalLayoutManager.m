//
//  VerticalLayoutManager.m
//  TabBarApp
//
//  Created by Marcin Maciukiewicz on 13/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CSVerticalLayoutManager.h"

@interface CSVerticalLayoutManager (PrivateMethods)
	-(CGFloat)layoutSubviewsAlignTop;
	-(CGFloat)layoutSubviewsAlignVerticalMiddle;
	-(CGFloat)layoutSubviewsAlignBottom;
	-(CGFloat)layoutSubviewsAlignLeft;
	-(CGFloat)layoutSubviewsAlignHorizontalCenter;
	-(CGFloat)layoutSubviewsAlignRight;
	-(NSArray*)visibleSubviews;
	-(CGSize)getPreferredSize:(UIView*)aView withMaxSize:(CGSize)maxSize;
@end

@implementation CSVerticalLayoutManager

@synthesize _view;
@synthesize _subviews;
@synthesize spacing;
@synthesize padding;
@synthesize verticalAlign;
@synthesize horizontalAlign;
@synthesize _visibleSubviews;
@synthesize ignoreHidden;

-(id)init {
	NSLog(@"[CSVerticalLayoutManager init] is not allowed; Use initWithView:");
	[NSException raise:NSGenericException format:@"Use initWithView:"];
	return nil;
}

-(id)initWithView:(UIView*)view {
	if((self=[super init])){
		self._view=view;
		self.verticalAlign=CSLayoutVerticalAlignTop;
		self.horizontalAlign=CSLayoutHorizontalAlignLeft;
		self._subviews=[[NSMutableArray alloc] init];
		spacing=CGSizeZero;
		padding=DistanceMake(0, 0, 0, 0);
		ignoreHidden=TRUE;
	}
	return self;
}

-(void)dealloc {
	[_view release];
	[_subviews release];
	[_visibleSubviews release];
	
	[super dealloc];
}

-(void)addSubview:(UIView*)subview {
	[_subviews addObject:subview];
	[_visibleSubviews release];
	self._visibleSubviews=nil;
}

-(CGSize)layoutSubviews {
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
	// if there is visible subview array, reuse it...
	if(_visibleSubviews){
		return _visibleSubviews;
	}
	// ... otherwise build visible subviews array
	NSArray *result;
	// filter if should ignore invisible widgets
	if(ignoreHidden){
		NSMutableArray *visibleViews=[[NSMutableArray alloc] init];
		for (UIView *subview in _subviews) {
			if(!subview.hidden){
				[visibleViews addObject:subview];
			}
		}
		self._visibleSubviews=visibleViews;
		result=visibleViews;
	} else {
		self._visibleSubviews=_subviews;
		result=_subviews;
	}
	return result;
}

//-(CGSize)getPreferredSize:(UIView*)aView withMaxSize:(CGSize)maxSize {
//	CGSize result;
////	BOOL conformsToTheProtocol=[aView conformsToProtocol:NSProtocolFromString(@"CSLayoutableWidget")];
//	BOOL respondsToSelector=[aView respondsToSelector:@selector(preferredSize)];
//	if(respondsToSelector){
//		aView.frame=CGRectMake(0, 0, maxSize.width, maxSize.height);
//		id<CSLayoutableWidget> layoutableWidget=(id<CSLayoutableWidget>)aView;
//		result=[layoutableWidget preferredSize];
//	} else {
//		result=aView.frame.size;
//	}
//	return result;
//}

#pragma mark -
#pragma mark Vertical align
-(CGFloat)layoutSubviewsAlignTop {
	CGFloat verticalOffset=padding.top;
	CGSize parentViewSize=self._view.frame.size;
	for (UIView *subview in [self visibleSubviews]) {
		CGSize maxSize=CGSizeMake(parentViewSize.width-padding.left-padding.right, parentViewSize.height-verticalOffset-padding.bottom);
		CGSize preferredSize=[self getPreferredSize:subview withMaxSize:maxSize];
		subview.frame=CGRectMake(0, verticalOffset, preferredSize.width, preferredSize.height);
		[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		verticalOffset+=preferredSize.height+spacing.height;
	}
	return verticalOffset;
}

-(CGFloat)layoutSubviewsAlignVerticalMiddle {
#warning TODO review the code; Get rid of CSLayoutableWidget
	// calculate total height for all widgets
	CGFloat totalHeight=0;
	for (UIView *subview in [self visibleSubviews]) {
		CGSize preferredSize=[subview preferredSize];
		totalHeight+=preferredSize.height+spacing.height;
	}
	// if there were any widgets at all, then substract last spacing;
	// it is not needed
	if(totalHeight>0){
		totalHeight-=spacing.height;
	}
	
	// align the widgets
	CGRect viewFrame=_view.frame;
	CGFloat viewHeight=viewFrame.size.height;
	// if the offset is not 'integer' the the displayed character are fuzzy 
	// (iphone tries to mimic 'double' position
	CGFloat verticalOffset=floor((viewHeight-totalHeight)/2+padding.top);
	for (UIView *subview in [self visibleSubviews]) {
		CGSize preferredSize=[subview preferredSize];
		CGRect subviewFrame=CGRectMake(0, verticalOffset, preferredSize.width, preferredSize.height);
		[subview setFrame:subviewFrame];
		[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		verticalOffset+=preferredSize.height+spacing.height;
	}
	return verticalOffset;
}

-(CGFloat)layoutSubviewsAlignBottom {
#warning TODO review the code; Get rid of CSLayoutableWidget
	// calculate total height for all widgets
	CGFloat totalHeight=0;
	for (UIView *subview in [self visibleSubviews]) {
		CGSize preferredSize=[subview preferredSize];
		totalHeight+=preferredSize.height+spacing.height;
	}
	// if there were any widgets at all, then substract last spacing;
	// it is not needed
	if(totalHeight>0){
		totalHeight-=spacing.height;
	}
	
	// align the widgets
	CGFloat verticalOffset=_view.frame.size.height-totalHeight-padding.bottom;
	for (UIView *subview in [self visibleSubviews]) {
		CGSize preferredSize=[subview preferredSize];
		[subview setFrame:CGRectMake(0, verticalOffset, preferredSize.width, preferredSize.height)];
		[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		verticalOffset+=preferredSize.height+spacing.height;
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
		//[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(CGFloat)layoutSubviewsAlignHorizontalCenter {
	CGFloat viewWidth=_view.frame.size.width;
	CGFloat result=0.0;
	for (UIView *subview in [self visibleSubviews]) {
		CGRect currentFrame=subview.frame;
		CGFloat horizontalOffset=floor((viewWidth-currentFrame.size.width-padding.left-padding.right)/2)+padding.left;
		[subview setFrame:CGRectMake(horizontalOffset, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height)];
		//[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(CGFloat)layoutSubviewsAlignRight {
	CGFloat viewWidth=_view.frame.size.width;
	CGFloat result=0.0;
	for (UIView *subview in [self visibleSubviews]) {
		CGRect currentFrame=subview.frame;
		CGFloat horizontalOffset=viewWidth-currentFrame.size.width-padding.right;
		[subview setFrame:CGRectMake(horizontalOffset, currentFrame.origin.y, currentFrame.size.width, currentFrame.size.height)];
		//[(UIView*)subview setNeedsLayout];
		//[(UIView*)subview layoutIfNeeded];
		CGFloat tmp=currentFrame.size.width+horizontalOffset;
		result=(tmp>result)?tmp:result;
	}
	return result;
}

-(NSArray*)allSubviews {
	NSArray *result=[NSArray arrayWithArray:self._subviews];
	return result;
}

@end
