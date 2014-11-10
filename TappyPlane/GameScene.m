//
//  GameScene.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameScene.h"
#import "Plane.h"
#import "ScrollingLayer.h"

@interface GameScene()
@property (nonatomic) Plane *player;
@property (nonatomic) SKNode *world;
@property (nonatomic) ScrollingLayer *background;
@property (nonatomic) ScrollingLayer *foreground;
@end

static const CGFloat kMinFPS = 10.00 / 60.00;

@implementation GameScene

- (instancetype) initWithSize:(CGSize)size
{
  if (!(self = [super initWithSize:size]))
    return nil;
  
  // Set background color to sky blue
  self.backgroundColor = [SKColor colorWithRed:0.835294118 green:0.929411765 blue:0.968627451 alpha:1.0];
  
  // Get atlas file
  SKTextureAtlas *graphics = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  // Setup physics
  self.physicsWorld.gravity = CGVectorMake(0.0, -5.5);
  
  // Setup world
  _world = [SKNode node];
  [self addChild:_world];
  
  // Setup background tiles
  NSMutableArray *backgroudTiles = [[NSMutableArray alloc] init];
  for (int i = 0; i < 3; i++) {
    [backgroudTiles addObject:[SKSpriteNode spriteNodeWithTexture:[graphics textureNamed:@"background"]]];
  }
  
  // Setup background
  _background = [[ScrollingLayer alloc] initWithTiles:backgroudTiles];
  _background.position = CGPointMake(0, 30);
  _background.horizontalScrollSpeed = -60;
  _background.scrolling = YES;
  [_world addChild:_background];
  
  // Setup foreground
  _foreground = [[ScrollingLayer alloc] initWithTiles:@[[self generateGroundTile],[self generateGroundTile],[self generateGroundTile]]];
  _foreground.position = CGPointZero;
  _foreground.horizontalScrollSpeed = -80;
  _foreground.scrolling = YES;
  [_world addChild:_foreground];
  
  // Setup player
  _player = [[Plane alloc] init];
  _player.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
  _player.physicsBody.affectedByGravity = NO;

  [_world addChild:_player];
  _player.engineRunning = YES; // The setter updates the parent, has to be after addChild
  
  return self;
}

- (SKSpriteNode*)generateGroundTile
{
  SKTextureAtlas *graphics = [SKTextureAtlas atlasNamed:@"Graphics"];
  SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:[graphics textureNamed:@"groundGrass"]];
  sprite.anchorPoint = CGPointZero;
  
  CGFloat offsetX = sprite.frame.size.width * sprite.anchorPoint.x;
  CGFloat offsetY = sprite.frame.size.height * sprite.anchorPoint.y;
  
  CGMutablePathRef path = CGPathCreateMutable();
  
  CGPathMoveToPoint(path, NULL, 403 - offsetX, 17 - offsetY);
  CGPathAddLineToPoint(path, NULL, 383 - offsetX, 22 - offsetY);
  CGPathAddLineToPoint(path, NULL, 373 - offsetX, 34 - offsetY);
  CGPathAddLineToPoint(path, NULL, 329 - offsetX, 33 - offsetY);
  CGPathAddLineToPoint(path, NULL, 318 - offsetX, 23 - offsetY);
  CGPathAddLineToPoint(path, NULL, 298 - offsetX, 22 - offsetY);
  CGPathAddLineToPoint(path, NULL, 286 - offsetX, 7 - offsetY);
  CGPathAddLineToPoint(path, NULL, 267 - offsetX, 8 - offsetY);
  CGPathAddLineToPoint(path, NULL, 256 - offsetX, 13 - offsetY);
  CGPathAddLineToPoint(path, NULL, 235 - offsetX, 13 - offsetY);
  CGPathAddLineToPoint(path, NULL, 219 - offsetX, 28 - offsetY);
  CGPathAddLineToPoint(path, NULL, 187 - offsetX, 28 - offsetY);
  CGPathAddLineToPoint(path, NULL, 174 - offsetX, 21 - offsetY);
  CGPathAddLineToPoint(path, NULL, 155 - offsetX, 22 - offsetY);
  CGPathAddLineToPoint(path, NULL, 125 - offsetX, 33 - offsetY);
  CGPathAddLineToPoint(path, NULL, 79 - offsetX, 30 - offsetY);
  CGPathAddLineToPoint(path, NULL, 67 - offsetX, 18 - offsetY);
  CGPathAddLineToPoint(path, NULL, 45 - offsetX, 12 - offsetY);
  CGPathAddLineToPoint(path, NULL, 20 - offsetX, 14 - offsetY);
  CGPathAddLineToPoint(path, NULL, 17 - offsetX, 18 - offsetY);
  CGPathAddLineToPoint(path, NULL, 0 - offsetX, 17 - offsetY);
  
  sprite.physicsBody = [SKPhysicsBody bodyWithEdgeChainFromPath:path];

#if DEBUG
    SKShapeNode *bodyShape = [SKShapeNode node];
    bodyShape.path = path;
    bodyShape.strokeColor = [SKColor redColor];
    bodyShape.lineWidth = 2.0;
    bodyShape.zPosition = 99.0;
    [sprite addChild:bodyShape];
#endif
  
  return sprite;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  //for (UITouch *touch in touches) {
  self.player.engineRunning = !self.player.engineRunning;
  //[self.player setRandomColor];
  _player.physicsBody.affectedByGravity = YES;
  self.player.accelerating = YES;
  //}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  //for (UITouch *touch in touches) {
  self.player.accelerating = NO;
  self.player.engineRunning = NO;
  //}
}

- (void)update:(NSTimeInterval)currentTime
{
  static NSTimeInterval lastCallTime;
  NSTimeInterval timeElapsed = currentTime - lastCallTime;
  if (timeElapsed > kMinFPS) {
    timeElapsed = kMinFPS;
  }
  lastCallTime = currentTime;
  
  [self.player update];
  [self.background updateWithTimeElapsed:timeElapsed];
  [self.foreground updateWithTimeElapsed:timeElapsed];
}

@end
