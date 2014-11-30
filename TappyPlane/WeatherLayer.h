//
//  WeatherLayer.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/30/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
  WeatherClear,
  WeatherRaining,
  WeatherSnowing,
} WeatherType;

@interface WeatherLayer : SKNode

@property (nonatomic) CGSize size;
@property (nonatomic) WeatherType conditions;

- (instancetype)initWithSize:(CGSize)size;

@end
