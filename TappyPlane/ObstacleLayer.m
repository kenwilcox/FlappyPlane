//
//  ObstacleLayer.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ObstacleLayer.h"

@interface ObstacleLayer()
@property (nonatomic) CGFloat marker;
@end

static const CGFloat kMarkerBuffer = 200.0;

@implementation ObstacleLayer

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed
{
  [super updateWithTimeElapsed:timeElapsed];
  
  if (self.scrolling && self.scene) {
    // Find marker's location in scene coords
    CGPoint markerLocationInScene = [self convertPoint:CGPointMake(self.marker, 0) toNode:self.scene];
    // When marker comes onto screen, add new obstacles
    if (markerLocationInScene.x - (self.scene.size.width * self.scene.anchorPoint.x)
        < self.scene.size.width + kMarkerBuffer) {
      [self addObstacleSet];
    }
  }
}

- (void)addObstacleSet
{
}

@end
