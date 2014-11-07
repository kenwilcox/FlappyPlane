//
//  Plane.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Plane.h"

@interface Plane()

@property (nonatomic) NSMutableArray *planeAnimations;
@property (nonatomic) SKEmitterNode *puffTrailEmitter;
@property (nonatomic) CGFloat puffTrailBirthRate;

@end

static NSString* const kKeyPlaneAnimation = @"PlaneAnimation";

@implementation Plane

- (id) init
{
  if (!(self = [super initWithImageNamed:@"planeBlue1"]))
    return nil;
  
  // Setup physics body
  self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width * 0.5];
  self.physicsBody.mass = 0.08;
  
  // Load animation plist
  _planeAnimations = [[NSMutableArray alloc] init];
  NSString *path = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
  NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:path];
  for (NSString *key in animations) {
    [self.planeAnimations addObject:[self animationFromArray:[animations objectForKey:key] withDuration:0.4]];
  }
  
  // Setup puff trail particle effect
  NSString *particleFile = [[NSBundle mainBundle] pathForResource:@"PlanePuffTrail" ofType:@"sks"];
  _puffTrailEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:particleFile];
  _puffTrailEmitter.position = CGPointMake(-self.size.width * 0.5, -5);
  [self addChild:self.puffTrailEmitter];
  
  self.puffTrailBirthRate = _puffTrailEmitter.particleBirthRate;
  self.puffTrailEmitter.particleBirthRate = 0;
  
  [self setRandomColor];
  
  return self;
}

- (SKAction *)animationFromArray:(NSArray *)textureNames withDuration:(CGFloat)duration
{
  NSMutableArray *frames = [[NSMutableArray alloc] init];
  SKTextureAtlas *planesAtlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  for (NSString *textureName in textureNames) {
    [frames addObject:[planesAtlas textureNamed:textureName]];
  }
  
  CGFloat frameTime = duration / (CGFloat)frames.count;
  return [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:frameTime resize:NO restore:NO]];
}

- (void)setEngineRunning:(BOOL)engineRunning
{
  _engineRunning = engineRunning;
  if (engineRunning) {
    self.puffTrailEmitter.targetNode = self.parent;
    [self actionForKey:kKeyPlaneAnimation].speed = 1;
    self.puffTrailEmitter.particleBirthRate = self.puffTrailBirthRate;
  }
  else {
    [self actionForKey:kKeyPlaneAnimation].speed = 0;
    self.puffTrailEmitter.particleBirthRate = 0;
  }
}

- (void)setRandomColor
{
  [self removeActionForKey:kKeyPlaneAnimation];
  SKAction *animation = self.planeAnimations[arc4random_uniform(self.planeAnimations.count)];
  [self runAction:animation withKey:kKeyPlaneAnimation];
  if (!self.engineRunning) {
    [self actionForKey:kKeyPlaneAnimation].speed = 0;
  }
}

- (void)update
{
  if (self.accelerating) {
    [self.physicsBody applyForce:CGVectorMake(0.0, 100)];
  }
}

@end
