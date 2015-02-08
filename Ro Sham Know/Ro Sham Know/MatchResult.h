//
//  MatchResult.h
//  Ro Sham Know
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014 Myriad Mobile. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MatchResult : NSObject

@property (nonatomic) NSUInteger leftScore;
@property (nonatomic) NSUInteger rightScore;
@property (nonatomic, strong) NSDate *when;

@end
