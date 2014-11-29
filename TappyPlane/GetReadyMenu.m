//
//  GetReadyMenu.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GetReadyMenu.h"

@interface GetReadyMenu()
@property (nonatomic) SKSpriteNode *getReadyTitle;
@property (nonatomic) SKTextureAtlas *atlas;
@end

@implementation GetReadyMenu

- (instancetype)initWithSize:(CGSize)size andPlayerPosition:(CGPoint)playerPosition
{
  if (!(self = [super init]))
    return nil;
  _size = size;
  
  _atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  _getReadyTitle = [SKSpriteNode spriteNodeWithTexture:[_atlas textureNamed:@"textGetReady"]];
  _getReadyTitle.position = CGPointMake(size.width * 0.75, playerPosition.y);
  [self addChild:_getReadyTitle];
  
  return self;
}

- (void)show
{
  
}

- (void)hide
{
  
}

@end
