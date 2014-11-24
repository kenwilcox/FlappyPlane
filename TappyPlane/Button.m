//
//  Button.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/23/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Button.h"

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
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
