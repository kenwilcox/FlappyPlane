//
//  BitmapFontLabel.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
  BitmapFontAlignmentLeft,
  BitmapFontAlignmentCenter,
  BitmapFontAlignmentRight,
} BitmapFontAlignment;

@interface BitmapFontLabel : SKNode

@property (nonatomic) NSString *fontName;
@property (nonatomic) NSString *text;
@property (nonatomic) CGFloat letterSpacing;
@property (nonatomic) BitmapFontAlignment alignment;

- (instancetype)initWithText:(NSString *)text andFontName:(NSString *)fontName;

@end
