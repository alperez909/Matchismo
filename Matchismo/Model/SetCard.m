//
//  SetCard.m
//  Matchismo
//
//  Created by Alberto Perez on 9/11/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    // Create an NSMutableSet for each property
    NSMutableSet *symbols = [[NSMutableSet alloc] init];
    NSMutableSet *shadings = [[NSMutableSet alloc] init];
    NSMutableSet *colors = [[NSMutableSet alloc] init];
    NSMutableSet *numbers = [[NSMutableSet alloc] init];

    // Add a property for each card into its respsective NSMutableSet
    for (SetCard *card in otherCards) {
        // TODO Introspection
        //if([card.symbol isKindOfClass:[NSString class]])
        [symbols addObject:card.symbol];
        //if([card.shading isKindOfClass:[NSString class]])
        [shadings addObject:card.shading];
        //if([card.color isKindOfClass:[NSString class]])
        [colors addObject:card.color];
        [numbers addObject:[NSNumber numberWithUnsignedInteger:card.number]];
    }
    
    // add self to sets
    // introspection
    [symbols addObject:self.symbol];
    [shadings addObject:self.shading];
    [colors addObject:self.color];
    [numbers addObject:[NSNumber numberWithUnsignedInteger:self.number]];
    
    // Returns if all cards are all the same or all cards are different for
    // each property
    if ([symbols count] == [otherCards count] + 1 || [symbols count] == 1)
        if ([shadings count] == [otherCards count] + 1 || [shadings count] == 1)
            if ([colors count] == [otherCards count] + 1|| [colors count] == 1)
                if([numbers count] == [otherCards count] + 1 || [numbers count] == 1)
                    return 27;
    
    return score;
    
}

- (NSString *)contents
{
    return nil;
}

@synthesize symbol = _symbol;

- (void)setSymbol:(NSString *)symbol
{
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (NSString *)symbol
{
    return _symbol ? _symbol : @"?";
}

@synthesize shading = _shading;

- (void)setShading:(NSString *)shading
{
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (NSString *)shading
{
    return _shading ? _shading : @"?";
}

@synthesize color = _color;

- (void)setColor:(NSString *)color
{
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}

- (NSString *)color
{
    return _color ? _color : @"?";
}


+ (NSArray *)numberStrings
{
    return @[@"1",@"2",@"3"];
}

+ (NSArray *)validSymbols
{
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validShadings
{
    return @[@"solid",@"striped",@"open"];
}

+ (NSArray *)validColors
{
    return @[@"red",@"green",@"purple"];
}


+ (NSUInteger)maxNumber
{
    return [[self numberStrings] count];
}

- (void)setNumber:(NSUInteger)number
{
    if (number <= [SetCard maxNumber]) {
        _number = number;
    }
    
}



@end
