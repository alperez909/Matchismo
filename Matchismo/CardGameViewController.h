//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Alberto Perez on 6/19/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//
// Abstract class. Must implement methods as described below.

#import <UIKit/UIKit.h>
#import "Deck.h"
#import "CardMatchingGame.h"


@interface CardGameViewController : UIViewController
@property (nonatomic,strong) CardMatchingGame *game;
// protected
// for subclasses
- (Deck *)createDeck; //abstract
- (UIImage *)backgroundImageForCard:(Card *)card; //abstract
- (NSAttributedString *)contentOfCard:(Card *)card;
@end
