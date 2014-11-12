//
//  Plane.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Plane.h"
#import "Constants.h"
#import "Collectable.h"

@interface Plane()

@property (nonatomic) NSMutableArray *planeAnimations;
@property (nonatomic) SKEmitterNode *puffTrailEmitter;
@property (nonatomic) CGFloat puffTrailBirthRate;

@end

static const CGFloat kMaxAltitude = 300.0;
static NSString* const kKeyPlaneAnimation = @"PlaneAnimation";

@implementation Plane

- (id) init
{
  if (!(self = [super initWithImageNamed:@"planeBlue1"]))
    return nil;
  
  // Setup physics body with path
  CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
  CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
  CGMutablePathRef path = CGPathCreateMutable();
  CGPathMoveToPoint(path, NULL, 43 - offsetX, 18 - offsetY);
  CGPathAddLineToPoint(path, NULL, 34 - offsetX, 36 - offsetY);
  CGPathAddLineToPoint(path, NULL, 11 - offsetX, 35 - offsetY);
  CGPathAddLineToPoint(path, NULL, 0 - offsetX, 28 - offsetY);
  CGPathAddLineToPoint(path, NULL, 10 - offsetX, 4 - offsetY);
  CGPathAddLineToPoint(path, NULL, 29 - offsetX, 0 - offsetY);
  CGPathAddLineToPoint(path, NULL, 37 - offsetX, 5 - offsetY);
  CGPathCloseSubpath(path);
  
  self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
  self.physicsBody.mass = 0.08;
  self.physicsBody.categoryBitMask = kCategoryPlane;
  self.physicsBody.contactTestBitMask = kCategoryGround | kCategoryCollectable;
  self.physicsBody.collisionBitMask = kCategoryGround;

//#if DEBUG
//  SKShapeNode *bodyShape = [SKShapeNode node];
//  bodyShape.path = path;
//  bodyShape.strokeColor = [SKColor redColor];
//  bodyShape.lineWidth = 2.0;
//  bodyShape.zPosition = 99.0;
//  [self addChild:bodyShape];
//#endif
  
  // Load animation plist
  _planeAnimations = [[NSMutableArray alloc] init];
  NSString *animationPlistPath = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
  NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:animationPlistPath];
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

- (void)reset
{
  self.crashed = NO;
  self.engineRunning = YES;
  self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
  self.zRotation = 0.0;
  self.physicsBody.angularVelocity = 0.0;
  
  [self setRandomColor];
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

# pragma mark Setters
- (void)setEngineRunning:(BOOL)engineRunning
{
  _engineRunning = engineRunning && ! self.crashed;
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

#if !FLAP
- (void)setAccelerating:(BOOL)accelerating
{
  _accelerating = accelerating && !self.crashed;
}
#endif

- (void)setCrashed:(BOOL)crashed
{
  _crashed = crashed;
  if (crashed) {
    self.engineRunning = NO;
#if !FLAP
    self.accelerating = NO;
#endif
  }
}

- (void)setRandomColor
{
  [self removeActionForKey:kKeyPlaneAnimation];
  SKAction *animation = self.planeAnimations[arc4random_uniform((uint)self.planeAnimations.count)];
  [self runAction:animation withKey:kKeyPlaneAnimation];
  if (!self.engineRunning) {
    [self actionForKey:kKeyPlaneAnimation].speed = 0;
  }
}

# pragma mark Methods

#if FLAP
- (void)flap
{
  if (!self.crashed && self.position.y < kMaxAltitude) {
    
    // Make sure plane can't drop faster than -200
    if (self.physicsBody.velocity.dy < -200) {
      self.physicsBody.velocity = CGVectorMake(0, -200);
    }
    
    [self.physicsBody applyImpulse:CGVectorMake(0.0, 20)];
    
    // Make sure that the plane can't go up faster than 300
    if (self.physicsBody.velocity.dy > 300) {
      self.physicsBody.velocity = CGVectorMake(0, 300);
    }
  }
}
#endif

- (void)update
{
#if !FLAP
  if (self.accelerating && self.position.y < kMaxAltitude) {
    [self.physicsBody applyForce:CGVectorMake(0.0, 100)];
  }
#endif
  
  if(!self.crashed){
    self.zRotation = fmaxf(fminf(self.physicsBody.velocity.dy * 0.5, 400), -400) / 400;
  }
}

- (void)collide:(SKPhysicsBody *)body
{
  if (!self.crashed) {
    if (body.categoryBitMask == kCategoryGround) {
      self.crashed = YES;
    }
    
    if (body.categoryBitMask == kCategoryCollectable) {
      if ([body.node respondsToSelector:@selector(collect)]) {
        [body.node performSelector:@selector(collect)];
      }
      
    }
  }
}

@end
