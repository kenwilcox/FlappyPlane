//
//  ObstacleLayer.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ScrollingNode.h"
#import "Collectable.h"

@interface ObstacleLayer : ScrollingNode

@property (nonatomic, weak) id<CollectableDelegate> collectableDelegate;

@property (nonatomic) CGFloat floor;
@property (nonatomic) CGFloat ceiling;

- (instancetype)initWithChallenges:(BOOL)challenges;
- (void)reset;

@end
