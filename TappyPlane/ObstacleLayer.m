//
//  ObstacleLayer.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ObstacleLayer.h"
#import "Constants.h"

@interface ObstacleLayer()
@property (nonatomic) CGFloat marker;
@end

static const CGFloat kMarkerBuffer = 200.0;
static NSString *const kKeyMountainUp = @"MountainUp";
static NSString *const kKeyMountainDown = @"MountainDown";

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

- (SKSpriteNode*)createObjectForKey:(NSString*)key
{
  SKSpriteNode *object = nil;
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  if (key == kKeyMountainUp) {
    object = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"MountainGrass"]];
    
    CGFloat offsetX = object.frame.size.width * object.anchorPoint.x;
    CGFloat offsetY = object.frame.size.height * object.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 55 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 0 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 90 - offsetX, 0 - offsetY);
    CGPathCloseSubpath(path);
    
    object.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
    object.physicsBody.categoryBitMask = kCategoryGround;
    
    [self addChild:object];
  }
  else if (key == kKeyMountainDown) {
    object = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"MountainGrassDown"]];
    
    CGFloat offsetX = object.frame.size.width * object.anchorPoint.x;
    CGFloat offsetY = object.frame.size.height * object.anchorPoint.y;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0 - offsetX, 199 - offsetY);
    CGPathAddLineToPoint(path, NULL, 55 - offsetX, 0 - offsetY);
    CGPathAddLineToPoint(path, NULL, 90 - offsetX, 199 - offsetY);
    CGPathCloseSubpath(path);
    
    object.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromPath:path];
    object.physicsBody.categoryBitMask = kCategoryGround;
    
    [self addChild:object];
  }
  
  if (object) {
    object.name = key;
  }
  
  return object;
}

@end
