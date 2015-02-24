//
//  Tweet.h
//  Twitter
//
//  Created by Tyler Craft on 2/18/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property (assign, nonatomic) NSInteger tweet_id;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSDate *createdAt;
@property (nonatomic, strong) NSString *createdAgo;
@property (nonatomic, strong) User *user;
@property (assign, nonatomic) BOOL favorited;
@property (assign, nonatomic) BOOL retweeted;
@property (assign, nonatomic) NSInteger favoriteCount;
@property (assign, nonatomic) NSInteger retweetCount;

- (id)initWithDictionary:(NSDictionary *)dictionary;

+ (NSArray *)tweetsWithArray:(NSArray *)array;

@end
