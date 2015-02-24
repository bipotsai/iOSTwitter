//
//  TweetTableViewCell.m
//  Twitter
//
//  Created by Tyler Craft on 2/23/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"

@interface TweetTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *replyImage;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
  // Initialization code
  
  // Get the separater inset over flush left
  self.separatorInset = UIEdgeInsetsZero;
  self.layoutMargins = UIEdgeInsetsZero;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void) setTweet:(Tweet *)tweet {
  _tweet = tweet;
  
  [self.tweetImage setImageWithURL:[NSURL URLWithString:tweet.user.profileImageURL]];
  self.userNameLabel.text = tweet.user.name;
  self.userHandleLabel.text = tweet.user.handle;
  self.tweetTimeLabel.text = tweet.createdAgo;
  self.tweetLabel.text = tweet.text;
}

- (void) onReply {
  NSLog(@"Replying to tweet");
}

@end
