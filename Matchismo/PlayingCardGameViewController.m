//
//  PlayingCardGameViewController.m
//  Matchismo
//
//  Created by Alberto Perez on 9/10/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (CardMatchingGame *)game
{
    CardMatchingGame *_game = [super game];
    _game.numOfMatches = 2;
    return _game;
}

- (PlayingCardDeck *)createDeck
{
    return [[PlayingCardDeck alloc] init];
}

- (UIImage *)backgroundImageForCard:(PlayingCard *)card
{
    return [UIImage imageNamed: card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSAttributedString *)contentOfCard:(PlayingCard *)card
{
    return card.isChosen ? [[NSAttributedString alloc] initWithString:card.contents] : [[NSAttributedString alloc] initWithString:@""];
}


@end
