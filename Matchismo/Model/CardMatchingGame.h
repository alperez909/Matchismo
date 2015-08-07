//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alberto Perez on 6/22/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *) deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
- (Card *)drawCardFromDeck: (Deck *)deck;


@property (nonatomic,readonly) NSInteger score;
// public method of number of cards to match
@property (nonatomic) NSInteger numOfMatches;
@property (nonatomic,strong) NSMutableDictionary *playInfo;
@property (nonatomic,strong) NSMutableArray *gameHistory;
@end
