//
//  ColorFlexPlayScreenViewController.m
//  ColorFlexes
//
//  Created by Bernard Snowden III on 8/18/12.
//  Copyright (c) 2012 Bernard Snowden III. All rights reserved.
//

#define statusBarHeight 20
#define kGameStateRunning 1
#define kGameStatePaused  2

#import "ColorFlexPlayScreenViewController.h"
#import "ColorFlexStartViewController.h"
#import "AudioToolbox/AudioToolbox.h"
#include <stdlib.h>


@class ColorFlexStartViewController;

@interface ColorFlexPlayScreenViewController ()

@end

@implementation ColorFlexPlayScreenViewController


@synthesize colorLabel;
@synthesize timerLabel;
@synthesize scoreLabel;
@synthesize quitButton;
@synthesize pauseButton;
@synthesize playButton;
 





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
    
    
    
    //Image initialization for the game.
    self.yellowImage = [UIImage imageNamed:@"yellow.png"];
    self.greenImage = [UIImage imageNamed:@"green.png"];
    self.blueImage = [UIImage imageNamed:@"blue.png"];
    self.grayImage = [UIImage imageNamed:@"gray.png"];
    self.purpleImage = [UIImage imageNamed:@"purple.png"];
    self.brownImage = [UIImage imageNamed:@"brown.png"];
    self.pinkImage = [UIImage imageNamed:@"pink.png"];
    self.redImage = [UIImage imageNamed:@"red.png"];
    self.orangeImage = [UIImage imageNamed:@"orange.png"];
    self.blankState = [UIImage imageNamed:@"blankState.png"];
    
    
    

    //Buttons Array for random arrangment
    self.buttons = [[NSMutableArray alloc]initWithObjects:self.upperLeftBtn,self.upperRightBtn,self.lowerLeftBtn,self.lowerRightBtn, nil];
    
    //NSArray init
    self.stringsOfColors =
    [[NSMutableArray alloc]initWithObjects:@"yellow",@"green",@"blue",@"gray",@"purple",@"brown",@"pink",
                            @"red",@"orange", nil];

    
    // Do any additional setup after loading the view from its nib.
    self.accumulatedTime = self.accumulatedTime;
    self->_timer = [NSTimer scheduledTimerWithTimeInterval:1.25 target:self selector:@selector(mainGameLoop) userInfo:nil repeats:YES];
    
    
//----------------------------------------------------------------------------
    //upperLeftButton customization
    
    self.upperLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *upperLeftImage = [UIImage imageNamed:@"blankState.png"];
    [self.upperLeftBtn setFrame:CGRectMake(42.5, 115, 75.0, 75.0)];
    [self.upperLeftBtn setImage:upperLeftImage forState:UIControlStateNormal];
    [self.view addSubview:self.upperLeftBtn];
   
    
    //upperRightButton customization
    self.upperRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *upperRightImage = [UIImage imageNamed:@"blankState.png"];
    [self.upperRightBtn setFrame:CGRectMake(202.5, 115, 75.0, 75.0)];
    [self.upperRightBtn setImage:upperRightImage forState:UIControlStateNormal];
    [self.view addSubview:self.upperRightBtn];
    
    //upperLeftButton customization
    self.lowerLeftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *lowerLeftImage = [UIImage imageNamed:@"blankState.png"];
    [self.lowerLeftBtn setFrame:CGRectMake(42.5, 275.0, 75.0, 75.0)];
    [self.lowerLeftBtn setImage:lowerLeftImage forState:UIControlStateNormal];
    [self.view addSubview:self.lowerLeftBtn];
    
    //upperLeftButton customization
    self.lowerRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *lowerRightImage = [UIImage imageNamed:@"blankState.png"];
    [self.lowerRightBtn setFrame:CGRectMake(202.5, 275.0, 75.0, 75.0)];
    [self.lowerRightBtn setImage:lowerRightImage forState:UIControlStateNormal];
    [self.view addSubview:self.lowerRightBtn];
    
    //Buttons Array for random arrangment
    self.buttons = [[NSMutableArray alloc]initWithObjects:self.upperLeftBtn,self.upperRightBtn,self.lowerLeftBtn,self.lowerRightBtn, nil];
//-----------------------------------------------------------------------------
    //Creation of NSArray colorImages
    self.colorImages = [[NSArray alloc]initWithObjects:self.yellowImage,self.greenImage,self.blueImage,self.grayImage,
                        self.purpleImage,self.brownImage,self.pinkImage,self.redImage,self.orangeImage,nil];
    //NSArray colorObjects
    self.colorObjects = [[NSArray alloc]initWithObjects: UIColor.yellowColor,UIColor.greenColor,UIColor.blueColor,UIColor.grayColor,UIColor.purpleColor,UIColor.brownColor,UIColor.magentaColor,UIColor.redColor,UIColor.orangeColor, nil];
    
    //Creation of NSDictionaries imageStrings,colorStrings
    self.imageDictionary = [NSDictionary dictionaryWithObjects:self.colorImages forKeys:self.stringsOfColors];
    self.colorDictionary = [NSDictionary dictionaryWithObjects:self.colorObjects forKeys:self.stringsOfColors];
    
    self.colorToStrings = [NSDictionary dictionaryWithObjects:self.stringsOfColors forKeys:self.colorObjects];
    self.imageToStrings = [NSDictionary dictionaryWithObjects:self.stringsOfColors forKeys:self.colorImages];
    
    
    
    
}

- (void)viewDidUnload
{

    self.accumulatedTime = self.accumulatedTime;
    [self setColorLabel:nil];
    [self setTimerLabel:nil];
    [self setScoreLabel:nil];
    [self setQuitButton:nil];
    [self setPauseButton:nil];
    [self setPlayButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(IBAction)quitToMenu:(id)sender{
    self.accumulatedTime = self.accumulatedTime;
    [_timer invalidate];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Are you sure you want to Quit?" message:@"If you quit you will lose all progress." delegate:self cancelButtonTitle:@"Yes" otherButtonTitles:@"No",nil];
    [alert show];
    
}

-(void)mainGameLoop
{
    BOOL isPlaying = YES;
    
    NSTimer *timerCheckGuess = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(checkUserGuess) userInfo:nil repeats:YES];
    [timerCheckGuess fire];
    
        
        [self updateGraphics];
        
      
       
        isPlaying = NO;
    
   //if(isPlaying)
       //[self.timer invalidate];
}

- (IBAction)pauseGame:(id)sender {
    self.accumulatedTime = self.accumulatedTime;
    [_timer invalidate];
}

- (IBAction)resumePlay:(id)sender {
    [_timer fire];
    timerLabel.font = [UIFont fontWithName:@"Futura" size:30];
    timerLabel.text = [[NSString alloc]initWithFormat:@"%d",self.accumulatedTime];
    if(self.accumulatedTime ==   30)
    {
        [_timer invalidate];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Game Over" message:@"Sorry get faster" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }

}
//This sets up the arrangement of the next group of colors to be played
/*-(void)gameSetup
{
    
    self.accumulatedTime += 1;
    // Timer Setup
    timerLabel.font = [UIFont fontWithName:@"Futura" size:30];
    timerLabel.text = [[NSString alloc]initWithFormat:@"%d",self.accumulatedTime];
    
    //Intialization of NSnumber objects that will be placed in an NSMutable array
    NSNumber *zero = [[NSNumber alloc]initWithInt:0];
    NSNumber *one = [[NSNumber alloc]initWithInt:1];
    NSNumber *two = [[NSNumber alloc]initWithInt:2];
    NSNumber *three = [[NSNumber alloc]initWithInt:3];
    NSNumber *four = [[NSNumber alloc]initWithInt:4];
    NSNumber *five = [[NSNumber alloc]initWithInt:5];
    NSNumber *six = [[NSNumber alloc]initWithInt:6];
    NSNumber *seven = [[NSNumber alloc]initWithInt:7];
    NSNumber *eight = [[NSNumber alloc]initWithInt:8];
   
    NSMutableArray *randomColorIndexes = [[NSMutableArray alloc]initWithObjects:zero,one,two,three,four,five,six,seven,eight, nil];
    //Shuffle for random access to numbers
    [self shuffleArray:randomColorIndexes];
    //Theses indexes will be used to select a random color from the array stringsOfColors
    NSInteger randColorIndex1 = [[randomColorIndexes objectAtIndex:0]intValue];
    NSInteger randColorIndex2 = [[randomColorIndexes objectAtIndex:1]intValue];
    NSInteger randColorIndex3 = [[randomColorIndexes objectAtIndex:2]intValue];
    NSInteger randColorIndex4 = [[randomColorIndexes objectAtIndex:3]intValue];
    
    //Intialization of randomColors from array stringsOfColors
    NSString *firstColor = [self.stringsOfColors objectAtIndex:randColorIndex1];
    NSString *secondColor = [self.stringsOfColors objectAtIndex:randColorIndex2];
    NSString *thirdColor = [self.stringsOfColors objectAtIndex:randColorIndex3];
    NSString *fourthColor = [self.stringsOfColors objectAtIndex:randColorIndex4];
    
    //Changes the text and color of text respectively
    self.colorLabel.text = [firstColor uppercaseString];
    self.colorLabel.textColor = [self.colorDictionary objectForKey:secondColor];
    
    //Shuffle array and changes colors of buttons
    [self shuffleArray:self.buttons];
    UIButton *button1 = [self.buttons objectAtIndex:0];
    UIButton *button2 = [self.buttons objectAtIndex:1];
    UIButton *button3 = [self.buttons objectAtIndex:2];
    UIButton *button4 = [self.buttons objectAtIndex:3];
    
    button1.imageView.image = [self.imageDictionary objectForKey:firstColor];
    button2.imageView.image = [self.imageDictionary objectForKey:secondColor];
    button3.imageView.image = [self.imageDictionary objectForKey:thirdColor];
    button4.imageView.image = [self.imageDictionary objectForKey:fourthColor];
    
    button1.titleLabel.hidden = YES;
    button2.titleLabel.hidden = YES;
    button3.titleLabel.hidden = YES;
    button4.titleLabel.hidden = YES;
    
    button1.titleLabel.text = firstColor;
    button2.titleLabel.text = secondColor;
    button3.titleLabel.text = thirdColor;
    button4.titleLabel.text = fourthColor;
    
    

    NSLog(@"Color of pressed button: %@",self.colorOfPressedButton);
    
    [button1 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [button3 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [button4 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
   
    if ([self.colorOfPressedButton isEqualToString:secondColor]) {
        self.score += 5;
        self.colorOfPressedButton = nil;
    }
    else
    {
        self.colorOfPressedButton = nil;
        self.score -= 5;
    }
    
    
   
    
    NSString *scoreString = [[NSString alloc]initWithFormat:@"%i",self.score];
    self.scoreLabel.text = scoreString;

  
   
    
}*/

-(void) currentButtonImage:(UIButton *) button
{
    self.colorOfPressedButton = button.titleLabel.text;
}

// Shuffles any NSMutable array for next arrangement
-(void)shuffleArray: (NSMutableArray*) array
{
    for (int i = [array count] - 1; i > 0; i--)
    {
        [array exchangeObjectAtIndex:(arc4random() % ([array count] - 1))
                  withObjectAtIndex:i];
    }
}
#pragma  mark -
#pragma UIAlert View Delegate Methods

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0)
    {
        if(self.startViewController == nil)
        {
            self.startViewController = [[ColorFlexStartViewController alloc]initWithNibName:@"ColorFlexStartViewController" bundle:nil];
        }
        
    [self.view insertSubview:self.startViewController.view aboveSubview:self.view];
       
    }
}

-(void)updateGraphics{
    self.accumulatedTime += 1;
    // Timer Setup
    timerLabel.font = [UIFont fontWithName:@"Futura" size:30];
    timerLabel.text = [[NSString alloc]initWithFormat:@"%d",self.accumulatedTime];
    
    //Intialization of NSnumber objects that will be placed in an NSMutable array
    NSNumber *zero = [[NSNumber alloc]initWithInt:0];
    NSNumber *one = [[NSNumber alloc]initWithInt:1];
    NSNumber *two = [[NSNumber alloc]initWithInt:2];
    NSNumber *three = [[NSNumber alloc]initWithInt:3];
    NSNumber *four = [[NSNumber alloc]initWithInt:4];
    NSNumber *five = [[NSNumber alloc]initWithInt:5];
    NSNumber *six = [[NSNumber alloc]initWithInt:6];
    NSNumber *seven = [[NSNumber alloc]initWithInt:7];
    NSNumber *eight = [[NSNumber alloc]initWithInt:8];
    
    NSMutableArray *randomColorIndexes = [[NSMutableArray alloc]initWithObjects:zero,one,two,three,four,five,six,seven,eight, nil];
    //Shuffle for random access to numbers
    [self shuffleArray:randomColorIndexes];
    //Theses indexes will be used to select a random color from the array stringsOfColors
    NSInteger randColorIndex1 = [[randomColorIndexes objectAtIndex:0]intValue];
    NSInteger randColorIndex2 = [[randomColorIndexes objectAtIndex:1]intValue];
    NSInteger randColorIndex3 = [[randomColorIndexes objectAtIndex:2]intValue];
    NSInteger randColorIndex4 = [[randomColorIndexes objectAtIndex:3]intValue];
    
    //Intialization of randomColors from array stringsOfColors
    NSString *firstColor = [self.stringsOfColors objectAtIndex:randColorIndex1];
    NSString *secondColor = [self.stringsOfColors objectAtIndex:randColorIndex2];
    NSString *thirdColor = [self.stringsOfColors objectAtIndex:randColorIndex3];
    NSString *fourthColor = [self.stringsOfColors objectAtIndex:randColorIndex4];
    
    _secondColor = secondColor;
    //Changes the text and color of text respectively
    self.colorLabel.text = [firstColor uppercaseString];
    self.colorLabel.textColor = [self.colorDictionary objectForKey:secondColor];
    
    NSLog(@"Correct Color: %@",secondColor);
    
    //Shuffle array and changes colors of buttons
    [self shuffleArray:self.buttons];
    _button1 = [self.buttons objectAtIndex:0];
    _button2 = [self.buttons objectAtIndex:1];
    _button3 = [self.buttons objectAtIndex:2];
    _button4 = [self.buttons objectAtIndex:3];
    
    _button1.imageView.image = [self.imageDictionary objectForKey:firstColor];
    _button2.imageView.image = [self.imageDictionary objectForKey:secondColor];
    _button3.imageView.image = [self.imageDictionary objectForKey:thirdColor];
    _button4.imageView.image = [self.imageDictionary objectForKey:fourthColor];
    
    _button1.titleLabel.hidden = YES;
    _button2.titleLabel.hidden = YES;
    _button3.titleLabel.hidden = YES;
    _button4.titleLabel.hidden = YES;
    
    _button1.titleLabel.text = firstColor;
    _button2.titleLabel.text = secondColor;
    _button3.titleLabel.text = thirdColor;
    _button4.titleLabel.text = fourthColor;
    
    
    
//NSLog(@"Color of pressed button: %@",self.colorOfPressedButton);
    NSLog(@"Colors: %@,%@,%@,%@ ",firstColor,secondColor,thirdColor,fourthColor);
    
}
-(void)getInputFromUser{
   
    
    [_button1 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [_button2 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [_button3 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
    [_button4 addTarget:self action:@selector(currentButtonImage:) forControlEvents:UIControlEventTouchUpInside];
  
    //NSLog(@"Correct Color: %@",_secondColor);
    //NSLog(@"Color of pressed button: %@",self.colorOfPressedButton);
   
}
-(void)checkUserGuess{
    _userInputTimer = [NSTimer timerWithTimeInterval:0.00001 target:self selector:@selector(getInputFromUser) userInfo:nil repeats:YES];
    [_userInputTimer fire];
    
  
    if ([self.colorOfPressedButton isEqualToString:_secondColor]) {
        self.score += 50;
        [self playRewardSound];
        self.colorOfPressedButton = nil;
    }
    else
    {   self.score -= 25;
        [self playLostSound];
        self.colorOfPressedButton = nil;
       
    }
    
    NSString *scoreString = [[NSString alloc]initWithFormat:@"%i",self.score];
    self.scoreLabel.text = scoreString;
}

-(void)playRewardSound{
    NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"RewardSound" withExtension:@"mp3"];
    SystemSoundID winSoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &winSoundID);
    AudioServicesPlaySystemSound(winSoundID);
    
}
-(void)playLostSound{
    NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"buzzer" withExtension:@"mp3"];
    SystemSoundID lostSoundID;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &lostSoundID);
    AudioServicesPlaySystemSound(lostSoundID);
    
}
@end
