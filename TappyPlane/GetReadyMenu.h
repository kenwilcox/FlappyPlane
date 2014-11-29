//
//  GetReadyMenu.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/29/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GetReadyMenu : SKNode

@property (nonatomic) CGSize size;

- (instancetype)initWithSize:(CGSize)size andPlayerPosition:(CGPoint)playerPosition;

- (void)show;
- (void)hide;

@end
