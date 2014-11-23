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

NSString *const kKeyMountainUp = @"MountainUp";
NSString *const kKeyMountainDown = @"MountainDown";
NSString *const kKeyCollectableStar = @"CollectableStar";

@end
