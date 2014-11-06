//
//  GameScene.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "GameScene.h"
#import "Plane.h"

@interface GameScene()
@property (nonatomic) Plane *player;
@property (nonatomic) SKNode *world;
@end

@implementation GameScene

- (instancetype) initWithSize:(CGSize)size
{
  if (!(self = [super initWithSize:size]))
    return nil;
  
  // Setup physics
  self.physicsWorld.gravity = CGVectorMake(0.0, -5.5);
  
  // Setup world
  _world = [SKNode node];
  [self addChild:_world];
  
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
  [self.player update];
}

@end
