//
//  SetCard.h
//  Matchismo
//
//  Created by Alberto Perez on 9/11/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong,nonatomic) NSString *symbol;
@property (strong,nonatomic) NSString *shading;
@property (strong,nonatomic) NSString *color;

+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;
+ (NSUInteger)maxNumber;

@end
