//
//  ChallengeProvider.m
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/22/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import "ChallengeProvider.h"
#import "Constants.h"

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
  self.challenges = [NSMutableArray array];
  
  // Challenge 1
  NSMutableArray *challenge = [NSMutableArray array];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainUp andPosition:CGPointMake(0, 105)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainDown andPosition:CGPointMake(143, 250)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(23, 290)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(128, 50)]];
  [self.challenges addObject:challenge];
  
  // Challenge 2
  challenge = [NSMutableArray array];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainUp andPosition:CGPointMake(90, 25)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainDownAlternate andPosition:CGPointMake(0, 232)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(100, 243)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(152, 205)]];
  [self.challenges addObject:challenge];
  
  // Challenge 3
  challenge = [NSMutableArray array];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainUp andPosition:CGPointMake(0, 82)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainUpAlternate andPosition:CGPointMake(122, 0)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyMountainDown andPosition:CGPointMake(85, 320)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(10, 213)]];
  [challenge addObject:[ChallengeItem challengeItemWithKey:kKeyCollectableStar andPosition:CGPointMake(81, 116)]];
  [self.challenges addObject:challenge];
}

@end
