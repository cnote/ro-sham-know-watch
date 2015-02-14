//
//  ScoringContext.h
//  Ro Sham Know
//
//  Created by Conor Prischmann on 11/23/14.
//  Copyright (c) 2014-2015 Conor Prischmann. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ScoringContext : NSObject

@property (nonatomic) BOOL isBestOfEnabled;
@property (nonatomic) BOOL needToWinByTwo;
@property (nonatomic) NSUInteger winningScore;

@end
