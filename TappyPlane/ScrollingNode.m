//
//  ScrollingNode.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/7/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ScrollingNode.h"

@implementation ScrollingNode

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed
{
  if (self.scrolling) {
    self.position = CGPointMake(self.position.x + (self.horizontalScrollSpeed * timeElapsed), self.position.y);
  }
}

@end
