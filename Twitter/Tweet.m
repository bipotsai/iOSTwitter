//
//  Tweet.m
//  Twitter
//
//  Created by Tyler Craft on 2/18/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import "Tweet.h"
#import "DateTools.h"

@implementation Tweet

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  
  if (self) {
    self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
    self.text = dictionary[@"text"];
    self.tweet_id = [dictionary[@"id"] integerValue];
    
    NSString *createdAtString = dictionary[@"created_at"];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
    
    self.createdAt = [formatter dateFromString:createdAtString];
    self.createdAgo = self.createdAt.shortTimeAgoSinceNow;

    self.favoriteCount = [dictionary[@"favorite_count"] integerValue];
    self.retweetCount = [dictionary[@"retweet_count"] integerValue];
  }
  
  return self;
}

+ (NSArray *)tweetsWithArray:(NSArray *)array {
  NSMutableArray *tweets = [NSMutableArray array];
  
  for (NSDictionary *dictionary in array) {
    [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];
  }
  
  return tweets;
}

@end
