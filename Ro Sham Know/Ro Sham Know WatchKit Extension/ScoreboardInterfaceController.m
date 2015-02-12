//
//  ScoreboardInterfaceController.m
//  Ro Sham Know
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014 Myriad Mobile. All rights reserved.
//

#import "ScoreboardInterfaceController.h"
#import "MatchResult.h"

@interface ScoreboardInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *scoreLabel;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *resultLabel;

@property (strong, nonatomic) MatchResult *matchResult;

- (IBAction)newGameButtonPressed;

@end

@implementation ScoreboardInterfaceController

- (void)awakeWithContext:(id)context
{
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
    self.matchResult = (MatchResult *)context;
    NSString *winner = (self.matchResult.leftScore > self.matchResult.rightScore) ? @"Left" : @"Right";
    NSString *loser = (self.matchResult.leftScore > self.matchResult.rightScore) ? @"Right" : @"Left";
    //self.scoreLabel.text = [NSString stringWithFormat:@"%@ beat %@, %@ to %@!", winner, loser, @(MAX(self.matchResult.leftScore, self.matchResult.rightScore)), @(MIN(self.matchResult.leftScore, self.matchResult.rightScore))];
    
    self.resultLabel.text = [NSString stringWithFormat:@"%@ beat %@!", winner, loser];
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %@ to %@", @(MAX(self.matchResult.leftScore, self.matchResult.rightScore)), @(MIN(self.matchResult.leftScore, self.matchResult.rightScore))];
}

- (void)willActivate
{
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate
{
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

- (IBAction)newGameButtonPressed
{
    [self pushControllerWithName:@"Configuration" context:nil];
}

@end
