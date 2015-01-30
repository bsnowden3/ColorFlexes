//
//  ColorFlexStartViewController.m
//  ColorFlexes
//
//  Created by Bernard Snowden III on 8/18/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//

#import "ColorFlexStartViewController.h"
#import "ColorFlexPlayScreenViewController.h"

@class ColorFlexPlayScreenViewController;

@interface ColorFlexStartViewController ()
{
    
}

@end

@implementation ColorFlexStartViewController
@synthesize playButton;
@synthesize optionButton;
@synthesize helpButton;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.frame = CGRectMake(0,0,320,480);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{

    
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    [self setPlayButton:nil];
    [self setOptionButton:nil];
    [self setHelpButton:nil];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)switchToPlay:(id)sender
{

    if(self.playScreenViewController.view.superview == nil)
    {
        if(self.playScreenViewController == nil)
            {
                self.playScreenViewController = [[ColorFlexPlayScreenViewController alloc] initWithNibName:@"ColorFlexPlayScreenViewController" bundle:nil];
            }
        
        
        [self.view insertSubview:self.playScreenViewController.view aboveSubview:self.view];
    }
        
    
}
@end
