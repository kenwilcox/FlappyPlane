//
//  ChallengeProvider.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/22/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ChallengeProvider.h"

@implementation ChallengeItem

+ (instancetype)challengeItemWithKey:(NSString *)key andPosition:(CGPoint)position
{
  ChallengeItem *item = [[ChallengeItem alloc] init];
  item.obstacleKey = key;
  item.position = position;
  return item;
}

@end

@interface ChallengeProvider()
@property (nonatomic) NSMutableArray *challenges;
@end

@implementation ChallengeProvider

+ (instancetype)getProvider
{
  static ChallengeProvider *sharedInstance = nil;
  @synchronized(self) {
    if (!sharedInstance) {
      sharedInstance = [[ChallengeProvider alloc] init];
      [sharedInstance loadChallenges];
    }
    return sharedInstance;
  }
}

- (NSArray *)getRandomChallenge
{
  return self.challenges[arc4random_uniform((uint)self.challenges.count)];
}

- (void)loadChallenges
{
  
}

@end
