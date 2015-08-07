//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alberto Perez on 6/22/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic,readwrite) NSInteger score;
@property (nonatomic,strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (NSMutableArray *)gameHistory
{
    if (!_gameHistory) _gameHistory= [[NSMutableArray alloc] init];
    return _gameHistory;
}


- (NSMutableDictionary *)playInfo
{
    if (!_playInfo) _playInfo = [[NSMutableDictionary alloc] init];
    return _playInfo;
}


- (NSInteger)numOfMatches
{
    return _numOfMatches ? _numOfMatches : DEFAULT_MATCHES;
}


- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck
{
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (Card *)drawCardFromDeck:(Deck *)deck
{
    Card *card = [deck drawRandomCard];
    if (card) {
        [self.cards addObject:card];
        return card;
    } else {
        return nil;
    }
}

static const int DEFAULT_MATCHES = 2;
static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    NSMutableArray *cardsToMatch =  [[NSMutableArray alloc] init];
    NSMutableArray *allCardsChosen =  [[NSMutableArray alloc] init];
    NSNumber *num = [[NSNumber alloc] initWithUnsignedInteger: -1*COST_TO_CHOOSE];
    NSString *typeOfPlay = @"Chose ";
    
    // Chose only cards that are not matched
    if (!card.isMatched) {
        // CHOSE/UNCHOSE SWITCH
        // Unchose card if chosen otherwise perform operations on card
        if (card.isChosen) {
            card.chosen = NO;
        } else {
            // Check all possible cards that can be matched with this card.
            // CardsToMatch contains all possible cards that can be matched.
            // A card can be matched if it is not matched already and it is chosen
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [cardsToMatch addObject:otherCard];
                }
            }
            // A card can be scored only if all cards chosen is equal to the number
            // of cards the game allows to be matched.
            if ([cardsToMatch count] + 1 == self.numOfMatches) { // changed + 1 instead of -1
                int matchScore = [card match:cardsToMatch];
                if (matchScore) { // MATCH
                    typeOfPlay = @"Matched ";
                    self.score += matchScore * MATCH_BONUS;
                    num = [[NSNumber alloc] initWithUnsignedInteger: matchScore * MATCH_BONUS];
                    for (Card *cardT in cardsToMatch) {
                        cardT.matched = YES;
                    }
                    card.matched = YES;
                } else { // MISTMATCH
                    typeOfPlay = @"Mismatched ";
                    self.score -= MISMATCH_PENALTY;
                    num = [[NSNumber alloc] initWithUnsignedInteger: -1*MISMATCH_PENALTY];
                    for (Card *cardT in cardsToMatch) {
                        cardT.chosen = NO;
                    }
                }
            }
            
            // Chosing a card should have cost
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
    // introspection
    if(![typeOfPlay isEqual:@"Chose "]) {
        [allCardsChosen addObjectsFromArray:cardsToMatch];
    }
    if (card.isChosen) {
        [allCardsChosen addObject:card];
    }
    [self.playInfo setObject:allCardsChosen forKey:@"cards"];
    [self.playInfo setObject:num forKey:@"score"];
    [self.playInfo setObject:typeOfPlay forKey:@"play"];
    if(![typeOfPlay isEqual:@"Chose "]) {
        [self.gameHistory addObject:[self.playInfo  copy]];
    }
}

- (Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

@end
