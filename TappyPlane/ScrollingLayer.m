//
//  ScrollingLayer.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/7/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ScrollingLayer.h"

@interface ScrollingLayer()
@property (nonatomic) SKSpriteNode *rightmostTile;
@end

@implementation ScrollingLayer

- (instancetype)initWithTiles:(NSArray *)tileSpriteNodes
{
  if (!(self = [super init]))
    return nil;
  
  for (SKSpriteNode *tile in tileSpriteNodes) {
    tile.anchorPoint = CGPointZero;
    tile.name = @"Tile";
    [self addChild:tile];
  }
  
  [self layoutTiles];
  
  return self;
}

- (void)layoutTiles
{
  self.rightmostTile = nil;
  [self enumerateChildNodesWithName:@"Tile" usingBlock:^(SKNode *node, BOOL *stop) {
    [self updateRightMostTile:node];
  }];
}

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed
{
  [super updateWithTimeElapsed:timeElapsed];
  
  if (self.scrolling && self.horizontalScrollSpeed < 0 && self.scene) {
    
    [self enumerateChildNodesWithName:@"Tile" usingBlock:^(SKNode *node, BOOL *stop) {
      CGPoint nodePositionInScene = [self convertPoint:node.position toNode:self.scene];
      
      if (nodePositionInScene.x + node.frame.size.width < -self.scene.size.width * self.scene.anchorPoint.x) {
        [self updateRightMostTile:node];
      }
    }];
    
  }
}

- (void) updateRightMostTile:(SKNode *)node
{
  node.position = CGPointMake(self.rightmostTile.position.x + self.rightmostTile.size.width, node.position.y);
  self.rightmostTile = (SKSpriteNode *)node;
}

@end
