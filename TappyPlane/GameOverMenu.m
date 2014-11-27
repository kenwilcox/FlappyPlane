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
  
  SKSpriteNode *panelBackground = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"UIbg"]];
  panelBackground.position = CGPointMake(size.width * 0.5, size.height - 150.00);
  CGFloat width = panelBackground.size.width;
  CGFloat height = panelBackground.size.height;
  panelBackground.centerRect = CGRectMake((10 / width), (10 / height), ((width -20) / width) ,((height -20) / height));
  panelBackground.xScale = 175.0 / width;
  panelBackground.yScale = 155.0 / height;

  [self addChild:panelBackground];
  
  return self;
}

@end
