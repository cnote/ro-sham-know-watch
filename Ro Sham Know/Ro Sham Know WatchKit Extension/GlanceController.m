//
//  GlanceController.m
//  Ro Sham Know WatchKit Extension
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014 Myriad Mobile. All rights reserved.
//

#import "GlanceController.h"


@interface GlanceController()

@end


@implementation GlanceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    // Initialize variables here.
    // Configure interface objects here.
    NSLog(@"%@ awakeWithContext", self);
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    NSLog(@"%@ will activate", self);
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    NSLog(@"%@ did deactivate", self);
}

@end



