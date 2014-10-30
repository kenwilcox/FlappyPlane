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
@end

@implementation Plane

- (id) init
{
  if (!(self = [super initWithImageNamed:@"planeBlue1"]))
    return nil;
  
  _planeAnimations = [[NSMutableArray alloc] init];
  NSString *path = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
  NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:path];
  for (NSString *key in animations) {
    [self.planeAnimations addObject:[self animationFromArray:[animations objectForKey:key] withDuration:0.4]];
  }
  
  [self setRandomColor];
  
  return self;
}

- (SKAction *)animationFromArray:(NSArray *)textureNames withDuration:(CGFloat)duration
{
  NSMutableArray *frames = [[NSMutableArray alloc] init];
  SKTextureAtlas *planesAtlas = [SKTextureAtlas atlasNamed:@"Planes"];
  
  for (NSString *textureName in textureNames) {
    [frames addObject:[planesAtlas textureNamed:textureName]];
  }
  
  CGFloat frameTime = duration / (CGFloat)frames.count;
  return [SKAction repeatActionForever:[SKAction animateWithTextures:frames timePerFrame:frameTime resize:NO restore:NO]];
}

- (void)setRandomColor
{
  [self runAction:self.planeAnimations[arc4random_uniform(self.planeAnimations.count)]];
}

@end
