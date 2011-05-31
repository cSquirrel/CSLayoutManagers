//
//  UITextField(LayoutableWidget).m
//  TabBarApp
//
//  Created by Marcin Maciukiewicz on 20/04/2010.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "UITextField(CSLayoutableWidget).h"


@implementation UITextField(CSLayoutableWidget)

-(CGSize)preferredSize {
	CGSize result;
	CGFloat widgetWidth;
	CGSize textSize;
	
	// calculate the text size
	if(!self.text || [self.text length]==0) {
		// use mock text if the text filed is empty
		textSize=[@"MOCK" sizeWithFont:self.font forWidth:self.frame.size.width lineBreakMode:UILineBreakModeWordWrap];
	} else {
		textSize=[self.text sizeWithFont:self.font forWidth:self.frame.size.width lineBreakMode:UILineBreakModeWordWrap];
	}
	
	if(self.frame.size.width<=0){
		// the frame width for the view is not calculated,
		// use text for width calculation
		if(self.clearButtonMode==UITextFieldViewModeAlways){
			widgetWidth=textSize.width+40;
		} else {
			widgetWidth=textSize.width;
		}
	} else {
		// the frame width was set, use it
		widgetWidth=self.frame.size.width;
	}
	result=CGSizeMake(widgetWidth,textSize.height);
	return result;
}

-(void)setFrame:(CGRect)newFrame {
	[super setFrame:newFrame];
}

-(CGRect)frame {
	return [super frame];
}

@end
