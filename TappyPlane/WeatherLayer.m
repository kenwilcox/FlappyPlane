//
//  WeatherLayer.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/30/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "WeatherLayer.h"
#import "SoundManager.h"

@interface WeatherLayer()
@property (nonatomic) SKEmitterNode *rainEmitter;
@property (nonatomic) SKEmitterNode *snowEmitter;
@property (nonatomic) Sound *rainSound;
@end

@implementation WeatherLayer

- (instancetype)initWithSize:(CGSize)size
{
  if (!(self = [super init]))
    return nil;
  
  _size = size;
  
  // Load rain effect
  NSString *rainEffectPath = [[NSBundle mainBundle] pathForResource:@"RainEffect" ofType:@"sks"];
  _rainEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:rainEffectPath];
  _rainEmitter.position = CGPointMake(size.width * 0.5 + 32, size.height + 5);
  
  // Setup rain sound
  _rainSound = [Sound soundNamed:@"Rain.caf"];
  _rainSound.volume = 0.6;
  _rainSound.looping = YES;
  
  // Load snow effect
  NSString *snowEffectPath = [[NSBundle mainBundle] pathForResource:@"SnowEffect" ofType:@"sks"];
  _snowEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:snowEffectPath];
  _snowEmitter.position = CGPointMake(size.width * 0.5, size.height + 5);
  
  return self;
}

- (void)setConditions:(WeatherType)conditions
{
  if (_conditions != conditions) {
    _conditions = conditions;
    
    [self removeAllChildren];
    if (self.rainSound.playing) {
      [self.rainSound fadeOut:1.0];
    }
    
    switch (conditions) {
      case WeatherRaining:
        [self.rainSound play];
        [self.rainSound fadeIn:1.0];
        [self addChild:self.rainEmitter];
        [self.rainEmitter advanceSimulationTime:5];
        break;
      
      case WeatherSnowing:
        [self addChild:self.snowEmitter];
        [self.rainEmitter advanceSimulationTime:5];
        break;
      
      case WeatherClear:
        break;
    }
  }
}

@end
