//
//  TweetViewController.m
//  Twitter
//
//  Created by Tyler Craft on 2/23/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

/*
 @property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
 @property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
 @property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
 @property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
 @property (weak, nonatomic) IBOutlet UIImageView *replyImage;
 */
#import "TweetViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface TweetViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *tweetImage;
@property (weak, nonatomic) IBOutlet UILabel *tweetLabel;
@property (weak, nonatomic) IBOutlet UILabel *tweetTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *favoritesCountLabel;

@end

@implementation TweetViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view from its nib.
  self.title = @"Tweet";

  [self.tweetImage setImageWithURL:[NSURL URLWithString:self.tweet.user.profileImageURL]];
  
  self.userNameLabel.text = self.tweet.user.name;
  self.userHandleLabel.text = self.tweet.user.handle;
  self.tweetLabel.text = self.tweet.text;
  
  NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"MM/dd/yy h:mm a"];
  
  self.tweetTimeLabel.text = [dateFormatter stringFromDate:self.tweet.createdAt];
  
  self.retweetsCountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.tweet.retweetCount];
  self.favoritesCountLabel.text = [NSString stringWithFormat:@"%ld", (long)self.tweet.favoriteCount];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void) setTweet:(Tweet *)tweet {
  _tweet = tweet;
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
