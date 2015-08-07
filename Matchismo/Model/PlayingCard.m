//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alberto Perez on 6/21/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// TODO
// Can do a better match
- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    NSArray *allCards = [otherCards arrayByAddingObject:self];
    for (int i = 0; i < [allCards count]; i++) {
         for (int j = i+1; j < [allCards count]; j++) {
             PlayingCard *first = [allCards objectAtIndex:i];
             PlayingCard *second = [allCards objectAtIndex:j];
             if ([first.suit isEqualToString:second.suit]) {
                 score += 1;
             } else if (first.rank == second.rank) {
                 score += 4;
             }
        }
    }
    return score;
}

- (NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit;

+ (NSArray *) validSuits
{
    return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}


- (NSString *)suit
{
    return _suit ? _suit : @"?";
}

+ (NSArray *)rankStrings
{
    return @[@"?", @"A", @"2", @"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank
{
    return [[self rankStrings] count]-1;
}

- (void)setRank:(NSUInteger)rank
{
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
    
}




@end
