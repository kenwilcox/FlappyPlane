//
//  ObstacleLayer.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ObstacleLayer.h"
#import "Constants.h"
#import "TilesetTextureProvider.h"
#import "ChallengeProvider.h"
#import "SoundManager.h"

@interface ObstacleLayer()
@property (nonatomic) CGFloat marker;
@property (nonatomic) BOOL challenges;
@end

static const CGFloat kMarkerBuffer = 200.0;
static const CGFloat kVerticalGap = 90.0;
static const CGFloat kSpaceBetweenObstacleSets = 180.0;
static const CGFloat kCollectableClearance = 50.0;
static const int kCollectableVerticalRange = 200.0;

@implementation ObstacleLayer

- (instancetype)init
{
  return [self initWithChallenges:YES];
}

- (instancetype)initWithChallenges:(BOOL)challenges
{
  if (!(self = [super init]))
    return nil;
  
  _challenges = challenges;
  
  for (int i = 0; i < 5; i++) {
    [self createObjectForKey:kKeyMountainUp].position = CGPointMake(-1000, 0);
    [self createObjectForKey:kKeyMountainDown].position = CGPointMake(-1000, 0);
  }
  
  return self;
}

- (void)reset
{
  // Loop through child nodes and reposition for reuse and update texture
  for (SKNode *node in self.children) {
    if (node.name == kKeyMountainUp || node.name == kKeyMountainDown || node.name == kKeyMountainUpAlternate || node.name == kKeyMountainDownAlternate) {
      ((SKSpriteNode *) node).texture = [[TilesetTextureProvider getProvider] getTextureForKey:node.name];
    }
    node.position = CGPointMake(-1000, 0);
  }
  
  // Reposition marker
  if (self.scene) {
    self.marker = self.scene.size.width + kMarkerBuffer;
  }
}

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed
{
  [self updateWithTimeElapsed:timeElapsed andChallenges:self.challenges];
}

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed andChallenges:(BOOL)challenges
{
  [super updateWithTimeElapsed:timeElapsed];
  
  if (self.scrolling && self.scene) {
    // Find marker's location in scene coords
    CGPoint markerLocationInScene = [self convertPoint:CGPointMake(self.marker, 0) toNode:self.scene];
    // When marker comes onto screen, add new obstacles
    if (markerLocationInScene.x - (self.scene.size.width * self.scene.anchorPoint.x)
        < self.scene.size.width + kMarkerBuffer) {
      [self addObstacleSet:challenges];
    }
  }
}

- (void)addObstacleSet:(BOOL)useChallenges
{
  if (!useChallenges) {
    // Get mountain nodes
    SKSpriteNode *mountainUp = [self getUnusedObjectForKey:kKeyMountainUp];
    SKSpriteNode *mountainDown = [self getUnusedObjectForKey:kKeyMountainDown];
    
    // Calculate maximum variation
    CGFloat maxVariation = (mountainUp.size.height + mountainDown.size.height + kVerticalGap) - (self.ceiling - self.floor);
    CGFloat yAdjustment = (CGFloat)arc4random_uniform(maxVariation);
    
    // Postion mountain nodes
    mountainUp.position = CGPointMake(self.marker, self.floor + (mountainUp.size.height * 0.5) - yAdjustment);
    mountainDown.position = CGPointMake(self.marker, mountainUp.position.y + mountainDown.size.height + kVerticalGap);
    
    // Get collectable star node
    SKSpriteNode *collectable = [self getUnusedObjectForKey:kKeyCollectableStar];
    
    // Position collectable
    CGFloat midPoint = mountainUp.position.y + (mountainUp.size.height * 0.5) + (kVerticalGap * 0.5);
    CGFloat yPosition = midPoint + arc4random_uniform(kCollectableVerticalRange) - (kCollectableVerticalRange * 0.5);
    yPosition = fmaxf(yPosition, self.floor + kCollectableClearance);
    yPosition = fminf(yPosition, self.ceiling - kCollectableClearance);
    collectable.position = CGPointMake(self.marker + (kSpaceBetweenObstacleSets * 0.5), yPosition);
  }
  
  CGFloat furthestItem = 0;
  
  if (useChallenges) {
    NSArray *challenge = [[ChallengeProvider getProvider] getRandomChallenge];
    for (ChallengeItem *item in challenge) {
      SKSpriteNode *object = [self getUnusedObjectForKey:item.obstacleKey];
      object.position = CGPointMake(item.position.x + self.marker, item.position.y);
      if (item.position.x > furthestItem) {
        furthestItem = item.position.x;
      }
    }
  }
  // Reposition marker
  self.marker += furthestItem + kSpaceBetweenObstacleSets;
}

- (SKSpriteNode*)getUnusedObjectForKey:(NSString*)key
{
  if (self.scene) {
    // Get left edge of screen in local coordinates
    CGFloat leftEdgeInLocalCoords = [self.scene convertPoint:CGPointMake(-self.scene.size.width * self.scene.anchorPoint.x, 0) toNode:self].x;
    // Try find object for key to the left of the screen
    for (SKSpriteNode* node in self.children) {
      if (node.name == key && node.frame.origin.x + node.frame.size.width < leftEdgeInLocalCoords) {
        // Return unused object
        return node;
      }
    }
  }
  // Couldn't find an unused node with key so create a new one
  return [self createObjectForKey:key];
}

- (SKSpriteNode*)createObjectForKey:(NSString*)key
{
  SKSpriteNode *object = nil;
  
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  if (key == kKeyMountainUp || key == kKeyMountainUpAlternate) {
    object = [SKSpriteNode spriteNodeWithTexture:[[TilesetTextureProvider getProvider] getTextureForKey:key]];
    
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
  else if (key == kKeyMountainDown || key == kKeyMountainDownAlternate) {
    object = [SKSpriteNode spriteNodeWithTexture:[[TilesetTextureProvider getProvider] getTextureForKey:key]];
    
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
  else if (key == kKeyCollectableStar) {
    object = [Collectable spriteNodeWithTexture:[atlas textureNamed:@"starGold"]];
    ((Collectable *)object).pointValue = 1;
    ((Collectable *)object).delegate = self.collectableDelegate;
    ((Collectable*)object).collectionSound = [Sound soundNamed:@"Collect.caf"];
    ((Collectable*)object).collectionSound.volume = 0.4;
    object.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:object.size.width * 0.3];
    object.physicsBody.categoryBitMask = kCategoryCollectable;
    object.physicsBody.dynamic = NO;
    [self addChild:object];
  }
  
  if (object) {
    object.name = key;
  }
  
  return object;
}

@end
