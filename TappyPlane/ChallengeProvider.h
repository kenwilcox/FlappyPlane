//
//  ChallengeProvider.h
//  TappyPlane
//
//  Created by Kenneth Wilcox on 11/22/14.
//  Copyright (c) 2014 Kenneth Wilcox. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ChallengeItem : NSObject

@property (nonatomic) NSString *obstacleKey;
@property (nonatomic) CGPoint position;
+ (instancetype)challengeItemWithKey:(NSString *)key andPosition:(CGPoint)position;

@end

@interface ChallengeProvider : NSObject

+ (instancetype)getProvider;
- (NSArray *)getRandomChallenge;

@end
