//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Alberto Perez on 6/19/14.
//  Copyright (c) 2014 Alberto Perez. All rights reserved.
//

#import "CardGameViewController.h"

@interface CardGameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (nonatomic, strong) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *choiceLabel;
@end

@implementation CardGameViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self updateUI];
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Game History"]) {
        if ([segue.destinationViewController isKindOfClass:[GameHistoryViewController class]]) {
            GameHistoryViewController *ghvc = (GameHistoryViewController *) segue.destinationViewController;
            for(NSMutableDictionary *eachPlayInfo in self.game.gameHistory) {
                NSArray *cards = [[NSArray alloc] init];
                cards = [eachPlayInfo objectForKey:@"cards"];
                int score = [[eachPlayInfo objectForKey:@"score"] intValue];
                NSString *play = [eachPlayInfo objectForKey:@"play"];
                
                NSMutableAttributedString *label = [[NSMutableAttributedString alloc] initWithString:play];
                for (Card *card in cards) {
                    BOOL temp = card.isChosen;
                    card.chosen = YES;
                    [label appendAttributedString:[self contentOfCard:card]];
                    card.chosen = temp;
                }
                
                [label appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat: @" for %d\n", score]]];
                [ghvc.playStrings addObject:[label copy]];
            }
        }
    }
}
 */

- (CardMatchingGame *)game
{
    if (!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

- (Deck *)createDeck // abstract
{
    return nil;
}

- (IBAction)touchCardButton:(UIButton *)sender
{
    int cardIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:cardIndex];
    [self choiceLabelUpdate];
    [self updateUI];
}


- (void)choiceLabelUpdate
{
    NSArray *cards = [[NSArray alloc] init];
    cards = [[self.game playInfo] objectForKey:@"cards"];
    int score = [[[self.game playInfo] objectForKey:@"score"] intValue];
    NSString *play = [[self.game playInfo] objectForKey:@"play"];
    
    NSMutableAttributedString *label = [[NSMutableAttributedString alloc] initWithString:play];
    for (Card *card in cards) {
        BOOL temp = card.isChosen; // trick contentOfCard
        card.chosen = YES;
        [label appendAttributedString:[self contentOfCard:card]];
        card.chosen = temp;
    }
    
    [label appendAttributedString:[[NSMutableAttributedString alloc] initWithString:[[NSString alloc] initWithFormat: @" for %d", score]]];
    
    if ([cards count] == 0) {
        label = [[NSMutableAttributedString alloc] initWithString:@"No Cards are Chosen"];
    }
    
    self.choiceLabel.attributedText = label;
}

- (void)updateUI
{
    for (UIButton *cardButton in self.cardButtons) {
        int cardIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

- (NSAttributedString *)titleForCard:(Card *)card
{
    return [self contentOfCard:card];
}

- (UIImage *)backgroundImageForCard:(Card *)card // abstract
{
    return nil;
}

- (IBAction)reset:(id)sender {
    self.game = nil;
    [self updateUI];
    self.choiceLabel.attributedText = [[NSAttributedString alloc] initWithString: @"No Cards are Chosen"];
}

- (NSAttributedString *)contentOfCard:(Card *)card // abstract
{
    return nil;
}


@end
