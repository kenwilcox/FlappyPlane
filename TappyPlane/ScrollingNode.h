//
//  ScrollingNode.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/7/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface ScrollingNode : SKNode

@property (nonatomic) CGFloat horizontalScrollSpeed; // Distance to scroll per second
@property (nonatomic) BOOL scrolling;

- (void)updateWithTimeElapsed:(NSTimeInterval)timeElapsed;

@end
