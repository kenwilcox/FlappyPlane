//
//  GameOverMenu.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/25/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameOverMenu.h"

@implementation GameOverMenu

- (instancetype)initWithSize:(CGSize)size;
{
  if (!(self = [super init]))
    return nil;
  _size = size;
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  // Setup node to act as a group for panel elements
  SKNode *panelGroup = [SKNode node];
  [self addChild:panelGroup];
  
  // Setup background panel
  SKSpriteNode *panelBackground = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"UIbg"]];
  panelBackground.position = CGPointMake(size.width * 0.5, size.height - 150.00);
  CGFloat width = panelBackground.size.width;
  CGFloat height = panelBackground.size.height;
  panelBackground.centerRect = CGRectMake((10 / width), (10 / height), ((width -20) / width) ,((height -20) / height));
  panelBackground.xScale = 175.0 / width;
  panelBackground.yScale = 115.0 / height;
  [panelGroup addChild:panelBackground];
  
  // Setup score title
  SKSpriteNode *scoreTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textScore"]];
  scoreTitle.anchorPoint = CGPointMake(1.0, 1.0);
  scoreTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) -20, CGRectGetMaxY(panelBackground.frame) -10);
  [panelGroup addChild:scoreTitle];
  
  // Setup best title
  SKSpriteNode *bestTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textBest"]];
  bestTitle.anchorPoint = CGPointMake(1.0, 1.0);
  bestTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) -20, CGRectGetMaxY(panelBackground.frame) -60);
  [panelGroup addChild:bestTitle];
  
  // Setup medal title
  SKSpriteNode *medalTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textMedal"]];
  medalTitle.anchorPoint = CGPointMake(0.0, 1.0);
  medalTitle.position = CGPointMake(CGRectGetMinX(panelBackground.frame) +20, CGRectGetMaxY(panelBackground.frame) -10);
  [panelGroup addChild:medalTitle];
  
  return self;
}

@end
