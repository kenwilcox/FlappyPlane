//
//  GameOverMenu.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/25/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameOverMenu.h"

@interface GameOverMenu()
@property (nonatomic) SKSpriteNode *medalDisplay;
@property (nonatomic) SKTextureAtlas *atlas;
@end

@implementation GameOverMenu

- (instancetype)initWithSize:(CGSize)size;
{
  if (!(self = [super init]))
    return nil;
  _size = size;
  
  _atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
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
  
  // Setup best title
  SKSpriteNode *bestTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textBest"]];
  bestTitle.anchorPoint = CGPointMake(1.0, 1.0);
  bestTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) -20, CGRectGetMaxY(panelBackground.frame) -60);
  [panelGroup addChild:bestTitle];
  
  // Setup medal title
  SKSpriteNode *medalTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textMedal"]];
  medalTitle.anchorPoint = CGPointMake(0.0, 1.0);
  medalTitle.position = CGPointMake(CGRectGetMinX(panelBackground.frame) +20, CGRectGetMaxY(panelBackground.frame) -10);
  [panelGroup addChild:medalTitle];
  
  // Setup display of medal
  _medalDisplay = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"medalBlank"]];
  _medalDisplay.anchorPoint = CGPointMake(0.5, 1.0);
  _medalDisplay.position = CGPointMake(CGRectGetMidX(medalTitle.frame), CGRectGetMinY(medalTitle.frame) - 15);
  [panelGroup addChild:_medalDisplay];
  
  // Set initial values
  self.medal = MedalNone;
  
  return self;
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
