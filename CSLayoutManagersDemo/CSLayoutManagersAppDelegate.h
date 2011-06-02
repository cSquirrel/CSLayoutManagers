//
//  CSLayoutManagersAppDelegate.h
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 30/05/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CSLayoutManagers.h"
#import "LayoutDemoSelector.h"

@interface CSLayoutManagersAppDelegate : NSObject <UIApplicationDelegate> {
    UINavigationController *_navigationController;
}

@property (nonatomic, retain)   IBOutlet    UIWindow                *window;
@property (nonatomic, retain)               UINavigationController  *_navigationController;

@end
