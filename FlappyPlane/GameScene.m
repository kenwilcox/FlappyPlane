//
//  GameScene.m
//  FlappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameScene.h"

@implementation GameScene

- (instancetype) initWithSize:(CGSize)size
{
  if (!(self = [super initWithSize:size]))
    return nil;
  
  SKSpriteNode *plane1 = [SKSpriteNode spriteNodeWithImageNamed:@"planeBlue1"];
  plane1.position = CGPointMake(50, 50);
  [self addChild:plane1];
  
  SKSpriteNode *plane2 = [SKSpriteNode spriteNodeWithImageNamed:@"planeGreen1"];
  plane2.position = CGPointMake(100, 50);
  [self addChild:plane2];
  
  SKSpriteNode *plane3 = [SKSpriteNode spriteNodeWithImageNamed:@"planeRed1"];
  plane3.position = CGPointMake(150, 50);
  [self addChild:plane3];
  
  SKSpriteNode *plane4 = [SKSpriteNode spriteNodeWithImageNamed:@"planeYellow1"];
  plane4.position = CGPointMake(200, 50);
  [self addChild:plane4];
  
  return self;
}

@end
