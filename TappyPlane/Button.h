//
//  Button.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/23/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Button : SKSpriteNode

@property (nonatomic) CGFloat pressedScale;
@property (nonatomic, readonly, weak) id pressedTarget;
@property (nonatomic, readonly) SEL pressedAction;

+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture;
- (void)setPressedTarget:(id)pressedTarget withAction:(SEL)pressedAction;

@end
