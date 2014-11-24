//
//  Button.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/23/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Button.h"

@interface Button()

@property (nonatomic) CGRect fullSizeFrame;

@end

@implementation Button

+ (instancetype)spriteNodeWithTexture:(SKTexture *)texture
{
  Button *instance = [super spriteNodeWithTexture:texture];
  instance.pressedScale = 0.9;
  instance.userInteractionEnabled = YES;
  return instance;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  self.fullSizeFrame = self.frame;
  [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  for (UITouch *touch in touches) {
    if (CGRectContainsPoint(self.fullSizeFrame, [touch locationInNode:self.parent])) {
      [self setScale:self.pressedScale];
    } else {
      [self setScale:1.0];
    }
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self setScale:1.0];
  for (UITouch *touch in touches) {
    if (CGRectContainsPoint(self.fullSizeFrame, [touch locationInNode:self.parent])) {
      // Pressed button
      //objc_msgSend(self.pressedTarget, self.pressedAction);
    }
  }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
  [self setScale:1.0];
}

@end
