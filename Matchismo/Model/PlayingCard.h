//
//  PlayingCard.h
//  Matchismo
//
//  Created by Alberto Perez on 6/21/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
