//
//  ColorFlexAppDelegate.h
//  ColorFlexes
//
//  Created by Bernard Snowden III on 8/18/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ColorFlexStartViewController;
@class ColorFlexPlayScreenViewController;

@interface ColorFlexAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ColorFlexStartViewController *startViewController;
@property (strong, nonatomic) ColorFlexPlayScreenViewController *playScreenViewController;


@end
