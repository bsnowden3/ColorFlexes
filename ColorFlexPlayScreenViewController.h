//
//  ColorFlexPlayScreenViewController.h
//  ColorFlexes
//
//  Created by Bernard Snowden III on 8/18/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ColorFlexStartViewController;

@interface ColorFlexPlayScreenViewController : UIViewController <UIAlertViewDelegate>{
    
    
}


@property float cumulativeTime;
@property ColorFlexStartViewController *startViewController;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@property (strong, nonatomic) IBOutlet UILabel *timerLabel;
@property (strong, nonatomic) IBOutlet UILabel *scoreLabel;
@property (strong, nonatomic) IBOutlet UIButton *quitButton;
@property (strong, nonatomic) IBOutlet UIButton *pauseButton;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) UIButton *upperLeftBtn;
@property (strong, nonatomic) UIButton *upperRightBtn;
@property (strong, nonatomic) UIButton *lowerLeftBtn;
@property (strong, nonatomic) UIButton *lowerRightBtn;
@property (strong,nonatomic) NSTimer *timer;
@property  NSUInteger accumulatedTime;
@property NSInteger score;
@property NSArray *colorImages;
@property NSDictionary *imageDictionary;
@property NSDictionary *colorDictionary;
@property NSDictionary *colorToStrings;
@property NSDictionary *imageToStrings;
@property UIImage *yellowImage,*greenImage,*blueImage,*grayImage,
*purpleImage,*brownImage,*pinkImage,*redImage,*orangeImage,*blankState;
@property NSMutableArray *stringsOfColors;
@property NSArray *colorObjects;
@property NSMutableArray *buttons;
@property NSString *colorOfPressedButton;
@property(nonatomic) NSInteger gameState;
@property NSTimer *userInputTimer;

@property NSString *firstColor,*secondColor,*thirdColor,*fourthColor;
@property UIButton *button1,*button2,*button3,*button4;





-(void)playRewardSound;
-(void)playLostSound;
-(IBAction)quitToMenu:(id)sender;
-(void)mainGameLoop;
- (IBAction)pauseGame:(id)sender;
- (IBAction)resumePlay:(id)sender;
-(void)shuffleArray: (NSMutableArray*) array;
-(void)gameSetup;
-(void)currentButtonImage:(UIButton*)button;
-(void)updateGraphics;
-(void)getInputFromUser;
-(void)checkUserGuess;


@end
