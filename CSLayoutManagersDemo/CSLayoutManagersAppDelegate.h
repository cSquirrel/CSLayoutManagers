//
//  CSLayoutManagersAppDelegate.h
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 30/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSVerticalLayoutManager.h"

@interface CSLayoutManagersAppDelegate : NSObject <UIApplicationDelegate> {
    CSVerticalLayoutManager *_layoutManager;
}

@property (nonatomic, retain)   IBOutlet    UIWindow            *window;
@property (nonatomic,retain)    IBOutlet    UISegmentedControl  *verticalAlignment;
@property (nonatomic,retain)    IBOutlet    UISegmentedControl  *horizontalAlignment;

@property (nonatomic,retain)    IBOutlet    UIView              *exampleSubview1;
@property (nonatomic,retain)    IBOutlet    UIView              *exampleSubview2;
@property (nonatomic,retain)    IBOutlet    UIView              *exampleSubview3;
@property (nonatomic,retain)    IBOutlet    UIView              *exampleSubview4;


@property (nonatomic,retain)    CSVerticalLayoutManager *_layoutManager;

-(IBAction)doVerticalAlignmentHasChanged:(id)sender;
-(IBAction)doHorizontalAlignmentHasChanged:(id)sender;

@end
