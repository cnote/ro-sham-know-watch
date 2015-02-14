//
//  ConfigurationInterfaceController.m
//  Ro Sham Know
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014-2015 Conor Prischmann. All rights reserved.
//

#import "ConfigurationInterfaceController.h"
#import "ScoringInterfaceController.h"
#import "ScoringContext.h"


@interface ConfigurationInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceButton *bestOfButton;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *firstToButton;
@property (weak, nonatomic) IBOutlet WKInterfaceSwitch *winByTwoSwitch;
@property (weak, nonatomic) IBOutlet WKInterfaceSlider *slider;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *startGameButton;

- (IBAction) bestOfButtonPressed;
- (IBAction) firstToButtonPressed;
- (IBAction) sliderAction:(float) value;
- (IBAction) startGameButtonPressed;
- (IBAction) winByTwoSwitchMoved:(BOOL) value;

@property (nonatomic, strong) ScoringContext *scoringContext;

@end


@implementation ConfigurationInterfaceController

- (void) awakeWithContext:(id) context
{
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
    self.scoringContext = [[ScoringContext alloc] init];
    [self turnOffBestOfMode];
    [self calculateWinningScore:0.2]; //need to match initial slider value from IB
}

- (void) willActivate
{
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void) didDeactivate
{
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (IBAction) bestOfButtonPressed
{
    self.scoringContext.isBestOfEnabled = YES;
    [self.bestOfButton setBackgroundColor:[UIColor purpleColor]];
    [self.firstToButton setBackgroundColor:[UIColor clearColor]];
    [self setNameOfStartGameButton];
}

- (IBAction) firstToButtonPressed
{
    [self turnOffBestOfMode];
}

- (void) turnOffBestOfMode
{
    self.scoringContext.isBestOfEnabled = NO;
    [self.bestOfButton setBackgroundColor:[UIColor clearColor]];
    [self.firstToButton setBackgroundColor:[UIColor purpleColor]];
    [self setNameOfStartGameButton];
}

- (IBAction) sliderAction:(float) value
{
    [self calculateWinningScore:value];
}

- (void) calculateWinningScore:(float) value
{
    self.scoringContext.winningScore = roundf(value * 98) + 1;
    [self setNameOfStartGameButton];
}

- (IBAction) startGameButtonPressed
{
    [self pushControllerWithName:@"Scoring" context:self.scoringContext];
}

- (IBAction) winByTwoSwitchMoved:(BOOL) value
{
    self.scoringContext.needToWinByTwo = value;
}

- (NSString *) startGameButtonDescription
{
    return [NSString stringWithFormat:@"Start: %@ %lu", (self.scoringContext.isBestOfEnabled ? @"Best Of" : @"First To"), (unsigned long) self.scoringContext.winningScore];
}

- (void) setNameOfStartGameButton
{
    [self.startGameButton setTitle:[self startGameButtonDescription]];
}

@end
