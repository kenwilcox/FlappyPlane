//
//  Plane.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Plane : SKSpriteNode

@property (nonatomic) BOOL engineRunning;
@property (nonatomic) BOOL accelerating;
@property (nonatomic) BOOL crashed;

- (void)setRandomColor;
- (void)update;
- (void)collide:(SKPhysicsBody *)body;
- (void)reset;

@end
