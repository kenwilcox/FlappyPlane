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
#import "Constants.h"
#import "ObstacleLayer.h"
#import "BitmapFontLabel.h"
#import "TilesetTextureProvider.h"

typedef enum : NSUInteger {
  GameReady,
  GameRunning,
  GameOver,
} GameState;

@interface GameScene()
@property (nonatomic) Plane *player;
@property (nonatomic) SKNode *world;
@property (nonatomic) ScrollingLayer *background;
@property (nonatomic) ScrollingLayer *foreground;
@property (nonatomic) ObstacleLayer *obstacles;
@property (nonatomic) BitmapFontLabel *scoreLabel;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger bestScore;
@property (nonatomic) GameOverMenu *gameOverMenu;
@property (nonatomic) GameState gameState;
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
  self.physicsWorld.gravity = CGVectorMake(0.0, -4.0);
  self.physicsWorld.contactDelegate = self;
  
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
  _background.horizontalScrollSpeed = -60;
  _background.scrolling = YES;
  [_world addChild:_background];
  
  // Setup obstacle layer
  _obstacles = [[ObstacleLayer alloc] init];
  _obstacles.collectableDelegate = self;
  _obstacles.horizontalScrollSpeed = -70;
  _obstacles.scrolling = YES;
  _obstacles.floor = 0.0;
  _obstacles.ceiling = self.size.height;
  [_world addChild:_obstacles];
  
  // Setup foreground
  _foreground = [[ScrollingLayer alloc] initWithTiles:@[[self generateGroundTile],[self generateGroundTile],[self generateGroundTile]]];
  _foreground.horizontalScrollSpeed = -80;
  _foreground.scrolling = YES;
  [_world addChild:_foreground];
  
  // Setup player
  _player = [[Plane alloc] init];
  _player.physicsBody.affectedByGravity = NO;
  [_world addChild:_player];
  
  // Setup score label
  _scoreLabel = [[BitmapFontLabel alloc] initWithText:@"0" andFontName:@"number"];
  _scoreLabel.position = CGPointMake(self.size.width * 0.5, self.size.height - 30);
  [self addChild:_scoreLabel];
  
  // Setup game over menu
  _gameOverMenu = [[GameOverMenu alloc] initWithSize:size];
  _gameOverMenu.delegate = self;
  
  [self newGame];
  
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
  sprite.physicsBody.categoryBitMask = kCategoryGround;

//#if DEBUG
//    SKShapeNode *bodyShape = [SKShapeNode node];
//    bodyShape.path = path;
//    bodyShape.strokeColor = [SKColor redColor];
//    bodyShape.lineWidth = 2.0;
//    bodyShape.zPosition = 99.0;
//    [sprite addChild:bodyShape];
//#endif
  
  return sprite;
}

- (void)newGame
{
  // Randomize tileset
  [[TilesetTextureProvider getProvider] randomizeTileset];
  
  // Reset layers
  self.foreground.position = CGPointZero;
  for (SKSpriteNode *node in self.foreground.children) {
    node.texture = [[TilesetTextureProvider getProvider] getTextureForKey:@"ground"];
  }
  
  [self.foreground layoutTiles];
  
  self.obstacles.position = CGPointZero;
  [self.obstacles reset];
  self.obstacles.scrolling = NO;
  
  self.background.position = CGPointZero;
  [self.background layoutTiles];

  // Reset score
  self.score = 0;
  self.scoreLabel.alpha = 1.0;
  
  // Reset plane
  self.player.position = CGPointMake(self.size.width * 0.3, self.size.height * 0.5);
  self.player.physicsBody.affectedByGravity = NO;
  [self.player reset];
  
  // Set game state to ready
  self.gameState = GameReady;
}

- (void)setScore:(NSInteger)score
{
  _score = score;
  self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)score];
}

- (MedalType)getMedalForCurrentScore
{
  NSInteger adjustedScore = self.score - (self.bestScore / 5);
  if (adjustedScore >= 45) {
    return MedalGold;
  } else if (adjustedScore >= 25) {
    return MedalSilver;
  } else if (adjustedScore >= 10) {
    return MedalBronze;
  }
  return MedalNone;
}

#pragma mark GameOverMenu delegate

- (void)pressedStartNewGameButton
{
  [self newGame];
  [self.gameOverMenu removeFromParent];
}

# pragma mark CollectableDelegate methods

- (void)wasCollected:(Collectable *)collectable
{
  self.score += collectable.pointValue;
  
}

#pragma mark UIResponder delegates

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  if (self.gameState == GameReady) {
    self.player.physicsBody.affectedByGravity = YES;
    self.obstacles.scrolling = YES;
    self.gameState = GameRunning;
  }
  
  if (self.gameState == GameRunning) {
#if FLAP
    [_player flap];
#else
    //self.player.engineRunning = !self.player.engineRunning;
    self.player.accelerating = YES;
#endif
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  if (self.gameState == GameRunning) {
#if !FLAP
    self.player.accelerating = NO;
    //self.player.engineRunning = NO;
#endif
  }
}

#pragma mark SKScene override

- (void)update:(NSTimeInterval)currentTime
{
  static NSTimeInterval lastCallTime;
  NSTimeInterval timeElapsed = currentTime - lastCallTime;
  if (timeElapsed > kMinFPS) {
    timeElapsed = kMinFPS;
  }
  lastCallTime = currentTime;
  
  [self.player update];
  
  if (self.gameState == GameRunning && self.player.crashed) {
    // Player just crashed in the last frame
    self.gameState = GameOver;
    [self.scoreLabel runAction:[SKAction fadeOutWithDuration:0.4]];
    
    self.gameOverMenu.score = self.score;
    // Based on previous best score, not current
    self.gameOverMenu.medal = [self getMedalForCurrentScore];
    if (self.score > self.bestScore) {
      self.bestScore = self.score;
    }
    self.gameOverMenu.bestScore = self.bestScore;
    
    [self addChild:self.gameOverMenu];
    [self.gameOverMenu show];
  }
  
  if (self.gameState != GameOver) {
    [self.background updateWithTimeElapsed:timeElapsed];
    [self.foreground updateWithTimeElapsed:timeElapsed];
    [self.obstacles updateWithTimeElapsed:timeElapsed];
  }
}

#pragma mark SKPhysicsContactDelegate methods

- (void)didBeginContact:(SKPhysicsContact *)contact
{
  if (contact.bodyA.categoryBitMask == kCategoryPlane) {
    [self.player collide:contact.bodyB];
  } else if (contact.bodyB.categoryBitMask == kCategoryPlane) {
    [self.player collide:contact.bodyA];
  }
}

@end
