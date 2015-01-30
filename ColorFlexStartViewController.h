//
//  ColorFlexStartViewController.h
//  ColorFlexes
//
//  Created by Bernard Snowden III on 8/18/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorFlexPlayScreenViewController;

@interface ColorFlexStartViewController : UIViewController
{
    
}

@property (strong,nonatomic) ColorFlexPlayScreenViewController*playScreenViewController;

@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UIButton *optionButton;
@property (strong, nonatomic) IBOutlet UIButton *helpButton;
- (IBAction)switchToPlay:(id)sender;

@end
