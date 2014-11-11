//
//  BitmapFontLabel.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "BitmapFontLabel.h"

@implementation BitmapFontLabel

- (instancetype)initWithText:(NSString *)text andFontName:(NSString *)fontName
{
  if (!(self = [super init]))
    return nil;
  
  _text = text;
  _fontName = fontName;
  _letterSpacing = 2.0;
  [self updateText];
  
  return self;
}

- (void)setText:(NSString *)text
{
  //if (_text != text) {
  if(![_text isEqualToString:text]) {
    _text = text;
    [self updateText];
  }
}

- (void)setFontName:(NSString *)fontName
{
  //if (_fontName != fontName) {
  if(![_fontName isEqualToString:fontName]) {
    _fontName = fontName;
    [self updateText];
  }
}

- (void)setLetterSpacing:(CGFloat)letterSpacing
{
  if (_letterSpacing != letterSpacing) {
    _letterSpacing = letterSpacing;
    [self updateText];
  }
}

- (void)updateText
{
  // Remove unused nodes
  if (self.text.length < self.children.count) {
    for (NSUInteger i = self.children.count; i > self.text.length; i--) {
      [self.children[i] removeFromParent];
    }
  }
  
  CGPoint pos = CGPointZero;
  CGSize totalSize = CGSizeZero;
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  // Loop through all characters in text
  for (NSUInteger i = 0; i < self.text.length; i++) {
    unichar c = [self.text characterAtIndex:i];
    NSString *textureName = [NSString stringWithFormat:@"%@%C", self.fontName, c];
    
    SKSpriteNode *letter;
    if (i < self.children.count) {
      // Reuse existing node
      letter = self.children[i];
      letter.texture = [atlas textureNamed:textureName];
      letter.size = letter.texture.size;
    } else {
      // Create a new node
      letter = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:textureName]];
      letter.anchorPoint = CGPointZero;
      [self addChild:letter];
    }
    
    letter.position = pos;
    pos.x += letter.size.width + self.letterSpacing;
    totalSize.width += letter.size.width + self.letterSpacing;
    if (totalSize.height < letter.size.height) {
      totalSize.height = letter.size.height;
    }
  }
  
  if (self.text.length > 0) {
    totalSize.width -= self.letterSpacing;
  }
}

@end
