//
//  VerticalLayoutDemoViewController.m
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 01/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VerticalLayoutDemoViewController.h"


@implementation VerticalLayoutDemoViewController

//@synthesize verticalAlignment=_verticalAlignment;
//@synthesize horizontalAlignment=_horizontalAlignment;
@synthesize exampleSubview1=_exampleSubview1;
@synthesize exampleSubview2=_exampleSubview2;
@synthesize exampleSubview3=_exampleSubview3;
@synthesize exampleSubview4=_exampleSubview4;
@synthesize _layoutManager;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
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
    [_layoutManager layoutViews];
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
    }
    
    [UIView beginAnimations:@"LayoutViews" context:nil];
    [_layoutManager layoutViews];
    [UIView commitAnimations];
}

-(IBAction)doShowHide:(id)sender {
    [UIView beginAnimations:@"LayoutViews" context:nil];
    _exampleSubview2.hidden=!_exampleSubview2.hidden;
    [_layoutManager layoutViews];
    [UIView commitAnimations];
}

-(IBAction)doChangeSpacing:(id)sender {
    [UIView beginAnimations:@"LayoutViews" context:nil];
    if(_layoutManager.spacing.width==10) {
        _layoutManager.spacing=CGSizeMake(20, 20);
    } else {
        _layoutManager.spacing=CGSizeMake(10, 10);
    }
    [_layoutManager layoutViews];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title=@"Vertical Layout";
    
    _layoutManager=[[CSVerticalLayoutManager alloc] init];
    [_layoutManager addView:_exampleSubview1];
    [_layoutManager addView:_exampleSubview2];
    [_layoutManager addView:_exampleSubview3];
    [_layoutManager addView:_exampleSubview4];
    _layoutManager.spacing=CGSizeMake(5, 5);
    _layoutManager.padding=CSDistanceMake(10, 10, 20, 10);
    [_layoutManager layoutViews];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
