//
//  CSLayoutManagersAppDelegate.m
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 30/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CSLayoutManagersAppDelegate.h"

@implementation CSLayoutManagersAppDelegate

@synthesize window=_window;
@synthesize verticalAlignment=_verticalAlignment;
@synthesize horizontalAlignment=_horizontalAlignment;
@synthesize exampleSubview1=_exampleSubview1;
@synthesize exampleSubview2=_exampleSubview2;
@synthesize exampleSubview3=_exampleSubview3;
@synthesize exampleSubview4=_exampleSubview4;

@synthesize _layoutManager;

- (void)dealloc
{
    [_window release];
    [super dealloc];
}

#pragma -
-(IBAction)doVerticalAlignmentHasChanged:(id)sender {
    UISegmentedControl *control=(UISegmentedControl*)sender;
    
    switch(control.selectedSegmentIndex) {
        case 0: {
            // top
            _layoutManager.verticalAlign=CSLayoutVerticalAlignTop;
        } break;
        case 1: {
            _layoutManager.verticalAlign=CSLayoutVerticalAlignMiddle;
            // middle
        } break;
        case 2: {
            _layoutManager.verticalAlign=CSLayoutVerticalAlignBottom;
            // bottom
        } break;
        case 3: {
            // justify
#warning TODO Vertical alignment: justify            
//            _layoutManager.verticalAlign=VerticalAlignJustify;
        } break;
    }
    
    [UIView beginAnimations:@"LayoutViews" context:nil];
    [_layoutManager layoutSubviews];
    [UIView commitAnimations];
}

-(IBAction)doHorizontalAlignmentHasChanged:(id)sender {
    UISegmentedControl *control=(UISegmentedControl*)sender;   
    
    switch(control.selectedSegmentIndex) {
        case 0: {
            // left
            _layoutManager.horizontalAlign=CSLayoutHorizontalAlignLeft;
        } break;
        case 1: {
            // center
            _layoutManager.horizontalAlign=CSLayoutHorizontalAlignCenter;
        } break;
        case 2: {
            // right
            _layoutManager.horizontalAlign=CSLayoutHorizontalAlignRight;
        } break;
        case 3: {
            // justify
#warning TODO Vertical alignment: justify            
            //            _layoutManager.verticalAlign=VerticalAlignJustify;
        } break;            
    }
    
    [UIView beginAnimations:@"LayoutViews" context:nil];
    [_layoutManager layoutSubviews];
    [UIView commitAnimations];
}

#pragma -
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [self.window makeKeyAndVisible];
    
    self._layoutManager=[[CSVerticalLayoutManager alloc] initWithView:_exampleSubview1.superview];
    [_layoutManager addSubview:_exampleSubview1];
    [_layoutManager addSubview:_exampleSubview2];
    [_layoutManager addSubview:_exampleSubview3];
    [_layoutManager addSubview:_exampleSubview4];
    
    _layoutManager.verticalAlign=CSLayoutVerticalAlignTop;
    _layoutManager.horizontalAlign=CSLayoutHorizontalAlignLeft;
    _layoutManager.padding=DistanceMake(10, 10, 10, 10);
    [_layoutManager layoutSubviews];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
