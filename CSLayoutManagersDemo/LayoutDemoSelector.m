//
//  LayoutDemoSelector.m
//  CSLayoutManagers
//
//  Created by Marcin Maciukiewicz on 02/06/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LayoutDemoSelector.h"
#import "CSLayoutManagers.h"
#import "FlowLayoutDemoViewController.h"
#import "VerticalLayoutDemoViewController.h"

#pragma mark -
@interface LayoutDemoView : UIView {
    UIButton *btnFlowLayout;
    UIButton *btnVerticalLayout;
    
    CSVerticalLayoutManager *_layoutManager;
}

@property(nonatomic,retain) UIButton *btnFlowLayout;
@property(nonatomic,retain) UIButton *btnVerticalLayout;
@property(nonatomic,retain) CSVerticalLayoutManager *_layoutManager;

@end

@implementation LayoutDemoView

@synthesize btnFlowLayout;
@synthesize btnVerticalLayout;
@synthesize _layoutManager;

-(id)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if(self){
        
        self.btnFlowLayout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnFlowLayout setTitle:@"Flow Layout" forState:UIControlStateNormal];
        btnFlowLayout.frame=CGRectMake(0, 0, 150, 50);
        self.btnVerticalLayout=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [btnVerticalLayout setTitle:@"Vertical Layout" forState:UIControlStateNormal];
        btnVerticalLayout.frame=CGRectMake(0, 0, 150, 50);
        
        [self addSubview:btnFlowLayout];
        [self addSubview:btnVerticalLayout];
        
        self._layoutManager=[[CSVerticalLayoutManager alloc] initWithSuperview:self];
        _layoutManager.horizontalAlign=CSLayoutHorizontalAlignCenter;
        _layoutManager.verticalAlign=CSLayoutVerticalAlignMiddle;
        _layoutManager.spacing=CGSizeMake(0, 10);
        [_layoutManager layoutViews];
        
    }
    
    return self;
}

-(void)dealloc {
    [btnFlowLayout release];
    [btnVerticalLayout release];
    [_layoutManager release];
    
    [super dealloc];
}

-(void)layoutSubviews {
    [_layoutManager layoutViews];
}


@end

#pragma mark -
@implementation LayoutDemoSelector

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {}
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    LayoutDemoView  *rootView=[[[LayoutDemoView alloc] initWithFrame:CGRectZero] autorelease];
    [rootView.btnFlowLayout addTarget:self action:@selector(doShowFlowLayout:) forControlEvents:UIControlEventTouchDown];
    [rootView.btnVerticalLayout addTarget:self action:@selector(doShowVerticalLayout:) forControlEvents:UIControlEventTouchDown];
    self.view=rootView;
}

-(void)doShowFlowLayout:(id)sender {
    UIViewController *layoutDemo=[[FlowLayoutDemoViewController alloc] init];
    [self.navigationController pushViewController:layoutDemo animated:TRUE];
    [layoutDemo release];
}

-(void)doShowVerticalLayout:(id)sender {
    UIViewController *layoutDemo=[[VerticalLayoutDemoViewController alloc] init];
    [self.navigationController pushViewController:layoutDemo animated:TRUE];
    [layoutDemo release];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    self.title=@"Select layout";
    
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
