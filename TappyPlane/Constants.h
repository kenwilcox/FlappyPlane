//
//  Constants.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Constants : NSObject

extern const uint32_t kCategoryPlane;
extern const uint32_t kCategoryGround;
extern const uint32_t kCategoryCollectable;

extern NSString *const kKeyMountainUp;
extern NSString *const kKeyMountainDown;
extern NSString *const kKeyMountainUpAlternate;
extern NSString *const kKeyMountainDownAlternate;
extern NSString *const kKeyCollectableStar;

extern NSString *const kTilesetGrass;
extern NSString *const kTilesetDirt;
extern NSString *const kTilesetIce;
extern NSString *const kTilesetSnow;

@end
