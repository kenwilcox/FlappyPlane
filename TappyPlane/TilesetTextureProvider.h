//
//  TilesetTextureProvider.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface TilesetTextureProvider : NSObject

+ (instancetype)getProvider;

- (void)randomizeTileset;
- (SKTexture *)getTextureForKey:(NSString *)key;

@end
