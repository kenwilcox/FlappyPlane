//
//  GameOverMenu.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/25/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameOverMenu.h"
#import "BitmapFontLabel.h"
#import "Button.h"

@interface GameOverMenu()
@property (nonatomic) SKSpriteNode *medalDisplay;
@property (nonatomic) SKTextureAtlas *atlas;
@property (nonatomic) BitmapFontLabel *scoreText;
@property (nonatomic) BitmapFontLabel *bestScoreText;
@end

@implementation GameOverMenu

- (instancetype)initWithSize:(CGSize)size;
{
  if (!(self = [super init]))
    return nil;
  _size = size;
  
  _atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  // Setup game over title text
  SKSpriteNode *gameOverTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textGameOver"]];
  gameOverTitle.position = CGPointMake(size.width * 0.5, size.height - 70);
  [self addChild:gameOverTitle];
  
  // Setup node to act as a group for panel elements
  SKNode *panelGroup = [SKNode node];
  [self addChild:panelGroup];
  
  // Setup background panel
  SKSpriteNode *panelBackground = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"UIbg"]];
  panelBackground.position = CGPointMake(size.width * 0.5, size.height - 150.00);
  CGFloat width = panelBackground.size.width;
  CGFloat height = panelBackground.size.height;
  panelBackground.centerRect = CGRectMake((10 / width), (10 / height), ((width -20) / width) ,((height -20) / height));
  panelBackground.xScale = 175.0 / width;
  panelBackground.yScale = 115.0 / height;
  [panelGroup addChild:panelBackground];
  
  // Setup score title
  SKSpriteNode *scoreTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textScore"]];
  scoreTitle.anchorPoint = CGPointMake(1.0, 1.0);
  scoreTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) -20, CGRectGetMaxY(panelBackground.frame) -10);
  [panelGroup addChild:scoreTitle];
  
  // Setup score text label
  _scoreText = [[BitmapFontLabel alloc] initWithText:@"0" andFontName:@"number"];
  _scoreText.alignment = BitmapFontAlignmentRight;
  _scoreText.position = CGPointMake(CGRectGetMaxX(scoreTitle.frame), CGRectGetMinY(scoreTitle.frame) - 15);
  [_scoreText setScale:0.5];
  [panelGroup addChild:_scoreText];
  
  // Setup best title
  SKSpriteNode *bestTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textBest"]];
  bestTitle.anchorPoint = CGPointMake(1.0, 1.0);
  bestTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) - 20, CGRectGetMaxY(panelBackground.frame) - 60);
  [panelGroup addChild:bestTitle];
  
  // Setup bestscore text label
  _bestScoreText = [[BitmapFontLabel alloc] initWithText:@"0" andFontName:@"number"];
  _bestScoreText.alignment = BitmapFontAlignmentRight;
  _bestScoreText.position = CGPointMake(CGRectGetMaxX(bestTitle.frame), CGRectGetMinY(bestTitle.frame) - 15);
  [_bestScoreText setScale:0.5];
  [panelGroup addChild:_bestScoreText];
  
  // Setup medal title
  SKSpriteNode *medalTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textMedal"]];
  medalTitle.anchorPoint = CGPointMake(0.0, 1.0);
  medalTitle.position = CGPointMake(CGRectGetMinX(panelBackground.frame) + 20, CGRectGetMaxY(panelBackground.frame) - 10);
  [panelGroup addChild:medalTitle];
  
  // Setup display of medal
  _medalDisplay = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"medalBlank"]];
  _medalDisplay.anchorPoint = CGPointMake(0.5, 1.0);
  _medalDisplay.position = CGPointMake(CGRectGetMidX(medalTitle.frame), CGRectGetMinY(medalTitle.frame) - 15);
  [panelGroup addChild:_medalDisplay];
  
  // Setup play button
  Button *playButton = [Button spriteNodeWithTexture:[_atlas textureNamed:@"buttonPlay"]];
  playButton.position = CGPointMake(CGRectGetMidX(panelBackground.frame), CGRectGetMinY(panelBackground.frame) - 25);
  [playButton setPressedTarget:self withAction:@selector(pressedPlayButton)];
  [self addChild:playButton];
  
  // Set initial values
  self.medal = MedalNone;
  self.score = 0;
  self.bestScore = 0;
  
  return self;
}

- (void)pressedPlayButton
{
  self.score += 1;
}

- (void)setScore:(NSInteger)score
{
  _score = score;
  self.scoreText.text = [NSString stringWithFormat:@"%ld", (long)score];
}

- (void)setBestScore:(NSInteger)bestScore
{
  _bestScore = bestScore;
  self.bestScoreText.text = [NSString stringWithFormat:@"%ld", (long)bestScore];
}

- (void)setMedal:(MedalType)medal
{
  _medal = medal;
  switch (medal) {
    case MedalBronze:
      self.medalDisplay.texture = [_atlas textureNamed:@"medalBronze"];
      break;
    case MedalSilver:
      self.medalDisplay.texture = [_atlas textureNamed:@"medalSilver"];
      break;
    case MedalGold:
      self.medalDisplay.texture = [_atlas textureNamed:@"medalGold"];
      break;
    default:
      self.medalDisplay.texture = [_atlas textureNamed:@"medalBlank"];
      break;
  }
}

@end
