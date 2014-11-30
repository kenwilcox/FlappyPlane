//
//  Constants.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "Constants.h"

@implementation Constants

const uint32_t kCategoryPlane = 0x1 << 0;
const uint32_t kCategoryGround = 0x1 << 1;
const uint32_t kCategoryCollectable = 0x1 << 2;

NSString *const kKeyMountainUp = @"mountainUp";
NSString *const kKeyMountainDown = @"mountainDown";
NSString *const kKeyMountainUpAlternate = @"mountainUpAlternate";
NSString *const kKeyMountainDownAlternate = @"mountainDownAlternate";
NSString *const kKeyCollectableStar = @"CollectableStar";

NSString *const kTilesetGrass = @"Grass";
NSString *const kTilesetDirt = @"Dirt";
NSString *const kTilesetIce = @"Ice";
NSString *const kTilesetSnow = @"Snow";

@end
