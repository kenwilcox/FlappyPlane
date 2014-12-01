//
//  Collectable.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SoundManager.h"

@class Collectable;

@protocol CollectableDelegate <NSObject>

- (void)wasCollected:(Collectable *)collectable;

@end

@interface Collectable : SKSpriteNode
@property (nonatomic) Sound *collectionSound;
@property (nonatomic, weak) id<CollectableDelegate> delegate;
@property (nonatomic) NSInteger pointValue;

- (void)collect;

@end
