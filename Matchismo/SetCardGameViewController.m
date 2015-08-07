//
//  SetCardGameViewController.m
//  Matchismo
//
//  Created by Alberto Perez on 9/11/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "SetCardGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"


@interface SetCardGameViewController ()

@end

@implementation SetCardGameViewController

- (CardMatchingGame *)game
{
    CardMatchingGame *_game = [super game];
    _game.numOfMatches = 3;
    return _game;
}

- (SetCardDeck *)createDeck
{
    return [[SetCardDeck alloc] init];
}

- (NSMutableAttributedString *)numberOfShapes:(SetCard *)card
{
    NSMutableAttributedString *s = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < card.number; i++) {
        [s appendAttributedString:[[NSAttributedString alloc] initWithString: card.symbol]];
    }
    return s;
}

- (UIColor *)colorString:(SetCard *)card
{
    UIColor *color;
    
    // Introspection
    NSInteger c = [[SetCard validColors] indexOfObject:card.color];
    
    switch (c) {
        case 0:
            color =  [UIColor redColor];
            break;
        case 1:
            color =  [UIColor greenColor];
            break;
        case 2:
            color =  [UIColor purpleColor];
            break;
        default:
            color = [UIColor blackColor];
            break;
    }
    
    return color;
}


- (NSNumber *)strokeWidth:(SetCard *) card
{
    NSNumber *stroke;
    
    NSInteger c = [[SetCard validShadings] indexOfObject:card.shading];
    
    switch (c) {
        case 0:
            stroke = @0;
            break;
        case 1:
            stroke = @-10;
            break;
        case 2:
            stroke = @10;
            break;
        default:
            stroke = @0;
            break;
    }
    return stroke;
}

- (UIColor *)strokeColor:(SetCard *)card
{
    int i = [[self strokeWidth:card] integerValue];
    if (i > 0) {
        return [self colorString:card];
    } else {
        return [UIColor blackColor];
    }
}

- (NSAttributedString *)contentOfCard:(SetCard *)card
{
    NSMutableAttributedString *s = [self numberOfShapes:card];
    [s setAttributes:@{ NSStrokeWidthAttributeName: [self strokeWidth:card],
                        NSStrokeColorAttributeName: [self strokeColor:card],
                        NSForegroundColorAttributeName: [self colorString:card]}
               range: NSMakeRange(0, [s length])];
    return s;
}


- (UIImage *)backgroundImageForCard:(SetCard *)card
{
    return [UIImage imageNamed: card.isChosen ? @"setCardSelected" : @"cardfront"];
}


@end
