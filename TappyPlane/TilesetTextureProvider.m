//
//  TilesetTextureProvider.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/10/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "TilesetTextureProvider.h"

@interface TilesetTextureProvider()
@property (nonatomic) NSMutableDictionary *tilesets;
@property (nonatomic) NSDictionary *currentTileset;
@end

@implementation TilesetTextureProvider

+ (instancetype)getProvider
{
  static TilesetTextureProvider *provider = nil;
  @synchronized(self) {
    if (!provider) {
      provider = [[TilesetTextureProvider alloc] init];
    }
    return provider;
  }
}

- (instancetype)init
{
  if (!(self = [super init]))
    return nil;
  
  [self loadTilesets];
  [self randomizeTileset];
  
  return self;
}

- (void) randomizeTileset
{
  NSArray *tilesetKeys = [self.tilesets allKeys];
  NSString *key = tilesetKeys[arc4random_uniform((uint)tilesetKeys.count)];
  self.currentTileset = self.tilesets[key];
}

- (SKTexture *)getTextureForKey:(NSString *)key
{
  return self.currentTileset[key];
}

- (void)loadTilesets
{
  self.tilesets = [[NSMutableDictionary alloc] init];
  SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
  
  NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"TilesetGraphics" ofType:@"plist"];
  NSDictionary *tilesetList = [NSDictionary dictionaryWithContentsOfFile:plistPath];
  for (NSString *tilesetKey in tilesetList) {
    NSDictionary *textureList = tilesetList[tilesetKey];
    NSMutableDictionary *textures = [[NSMutableDictionary alloc] init];
    
    for (NSString *textureKey in textureList) {
      SKTexture *texture = [atlas textureNamed:textureList[textureKey]];
      textures[textureKey] = texture;
    }
    
    self.tilesets[tilesetKey] = textures;
  }
}

@end
