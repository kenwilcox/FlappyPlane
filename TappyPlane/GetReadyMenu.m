//
//  GetReadyMenu.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GetReadyMenu.h"

@interface GetReadyMenu()
@property (nonatomic) SKTextureAtlas *atlas;
@property (nonatomic) SKSpriteNode *getReadyTitle;
@property (nonatomic) SKNode *tapGroup;
@end

@implementation GetReadyMenu

- (instancetype)initWithSize:(CGSize)size andPlayerPosition:(CGPoint)playerPosition
{
  if (!(self = [super init]))
    return nil;
  _size = size;
  
  _atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  // Setup Get Ready Text
  _getReadyTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textGetReady"]];
  _getReadyTitle.position = CGPointMake(size.width * 0.75, playerPosition.y);
  [self addChild:_getReadyTitle];
  
  // Setup group for tap nodes
  _tapGroup = [SKNode node];
  _tapGroup.position = playerPosition;
  [self addChild:_tapGroup];
  
  // Setup right tap tag
  SKSpriteNode *rightTapTag = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"tapLeft"]];
  rightTapTag.position = CGPointMake(55, 0);
  [self.tapGroup addChild:rightTapTag];
  
  // Setup left tap tag
  SKSpriteNode *leftTapTag = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"tapRight"]];
  leftTapTag.position = CGPointMake(-55, 0);
  [self.tapGroup addChild:leftTapTag];
  
  // Setup frames for animation
  NSArray *tapAnimationFrames = @[[_atlas textureNamed:@"tap"], [_atlas textureNamed:@"tapTick"], [_atlas textureNamed:@"tapTick"]];
  SKAction *tapAnimation = [SKAction animateWithTextures:tapAnimationFrames timePerFrame:0.5 resize:YES restore:NO];
  
  // Setup tap hand
  SKSpriteNode *tapHand = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"tap"]];
  tapHand.position = CGPointMake(0, -40);
  [self.tapGroup addChild:tapHand];
  [tapHand runAction:[SKAction repeatActionForever:tapAnimation]];
  
  return self;
}

- (void)show
{
  
}

- (void)hide
{
  
}

@end
