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
  
  // Setup player
  _player = [[Plane alloc] init];
  _player.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
  _player.physicsBody.affectedByGravity = NO;

  [_world addChild:_player];
  _player.engineRunning = YES; // The setter updates the parent, has to be after addChild
  
  return self;
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
}

@end
