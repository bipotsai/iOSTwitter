//
//  TweetTableViewCell.h
//  Twitter
//
//  Created by Tyler Craft on 2/23/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@class TweetTableViewCell;

@protocol TweetTableViewCellDelegate <NSObject>

- (void) TweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell onReply:(BOOL)pressed;

@end

@interface TweetTableViewCell : UITableViewCell

@property (strong, nonatomic) Tweet* tweet;
@property (weak, nonatomic) id<TweetTableViewCellDelegate> delegate;

@end
