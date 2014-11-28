//
//  GameOverMenu.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/25/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
  MedalNone,
  MedalBronze,
  MedalSilver,
  MedalGold,
} MedalType;

@protocol GameOverMenuDelegate <NSObject>

- (void)pressedStartNewGameButton;

@end

@interface GameOverMenu : SKNode

@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger bestScore;
@property (nonatomic) MedalType medal;
@property (nonatomic, weak)id<GameOverMenuDelegate> delegate;

- (instancetype)initWithSize:(CGSize)size;
- (void)show;

@end
