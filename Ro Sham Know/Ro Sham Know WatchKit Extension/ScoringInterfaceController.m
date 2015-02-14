//
//  ScoringInterfaceController.m
//  Ro Sham Know
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014-2015 Conor Prischmann. All rights reserved.
//

#import "ScoringInterfaceController.h"
#import "ScoringContext.h"
#import "MatchResult.h"


@interface ScoringInterfaceController ()

@property (weak, nonatomic) IBOutlet WKInterfaceLabel *leftScore;
@property (weak, nonatomic) IBOutlet WKInterfaceLabel *rightScore;
@property (weak, nonatomic) IBOutlet WKInterfaceButton *undoButton;

- (IBAction) undoPressed;
- (IBAction) leftPressed;
- (IBAction) rightPressed;

@property (nonatomic) NSUInteger leftCount;
@property (nonatomic) NSUInteger rightCount;
@property (strong, nonatomic) NSMutableArray *previousPresses; //-1: left, +1: right
@property (strong, nonatomic) ScoringContext *scoringContext;

@end


@implementation ScoringInterfaceController

#pragma mark - Lifecycle

- (void) awakeWithContext:(id) context
{
    [super awakeWithContext:context];
    // Initialize variables here.
    self.previousPresses = [[NSMutableArray alloc] init];
    // Configure interface objects here.
    [self.undoButton setEnabled:NO];
    self.scoringContext = context;
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

#pragma mark - Button Handling

- (IBAction) undoPressed
{
    if ([self.previousPresses count] > 0)
    {
        if ([[self.previousPresses lastObject] isEqualToNumber:@ - 1])
        {
            self.leftCount--;
            [self updateLeftDisplay];
        }
        else
        {
            self.rightCount--;
            [self updateRightDisplay];
        }
        
        [self.previousPresses removeLastObject];
        
        if ([self.previousPresses count] < 1)
        {
            [self.undoButton setEnabled:NO];
        }
    }
}

- (IBAction) leftPressed
{
    self.leftCount++;
    [self updateLeftDisplay];
    [self.previousPresses addObject:@ - 1];
    [self.undoButton setEnabled:YES];
    [self checkForWinner];
}

- (IBAction) rightPressed
{
    self.rightCount++;
    [self updateRightDisplay];
    [self.previousPresses addObject:@1];
    [self.undoButton setEnabled:YES];
    [self checkForWinner];
}

- (void) updateLeftDisplay
{
    self.leftScore.text = [NSString stringWithFormat:@"%ld", (long) self.leftCount];
}

- (void) updateRightDisplay
{
    self.rightScore.text = [NSString stringWithFormat:@"%ld", (long) self.rightCount];
}

- (void) checkForWinner
{
    if (self.leftCount != self.rightCount)
    {
        if (self.scoringContext.isBestOfEnabled)
        {
            if (((self.leftCount + self.rightCount) >= self.scoringContext.winningScore) && [self twoPointDifferenceOrNotRequired])
            {
                [self someoneWon];
            }
        }
        else
        {
            if (((self.leftCount >= self.scoringContext.winningScore) || (self.rightCount >= self.scoringContext.winningScore)) &&
                [self twoPointDifferenceOrNotRequired])
            {
                [self someoneWon];
            }
        }
    }
}

- (BOOL) twoPointDifferenceOrNotRequired
{
    return (!self.scoringContext.needToWinByTwo ||
            (self.scoringContext.needToWinByTwo && (abs((int) self.leftCount - (int) self.rightCount) >= 2)));
}

- (void) someoneWon
{
    NSLog(@"someone won!!!");
    MatchResult *matchResult = [[MatchResult alloc] init];
    matchResult.leftScore = self.leftCount;
    matchResult.rightScore = self.rightCount;
    matchResult.when = [NSDate date];
    [self pushControllerWithName:@"Scoreboard" context:matchResult];
}

@end
