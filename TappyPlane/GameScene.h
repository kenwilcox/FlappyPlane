//
//  GameScene.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 10/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Collectable.h"

@interface GameScene : SKScene <SKPhysicsContactDelegate, CollectableDelegate>

@end
