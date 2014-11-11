//
//  Collectable.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Collectable.h"

@implementation Collectable

- (void)collect
{
  [self runAction:[SKAction removeFromParent]];
  if (self.delegate) {
    [self.delegate wasCollected:self];
  }
}

@end
