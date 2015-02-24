//
//  TweetsViewController.m
//  Twitter
//
//  Created by Tyler Craft on 2/22/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import "TweetsViewController.h"
#import "TweetTableViewCell.h"
#import "TweetViewController.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "User.h"
#import "SVProgressHUD.h"

@interface TweetsViewController () <UITableViewDataSource, UITableViewDelegate, TweetTableViewCellDelegate>

@property (strong, nonatomic) NSMutableArray *tweetsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end

@implementation TweetsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  // Do any additional setup after loading the view from its nib.
  self.title = @"Home";
  
  // Setup Navigation Bar
  UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStylePlain target:self action:@selector(onLogout)];
  self.navigationItem.leftBarButtonItem = logoutButton;
  UIBarButtonItem* newTweetButton = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweet)];
  self.navigationItem.rightBarButtonItem = newTweetButton;
  
  // Setup Table
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.rowHeight = UITableViewAutomaticDimension;
  [self.tableView registerNib:[UINib nibWithNibName:@"TweetTableViewCell" bundle:nil] forCellReuseIdentifier:@"TweetTableViewCell"];
  
  // Get the separater inset over flush left
  self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
  self.tableView.layoutMargins = UIEdgeInsetsZero;
  
  // Refresh Table
  self.refreshControl = [[UIRefreshControl alloc] init];
  [self.refreshControl addTarget:self action:@selector(getInitialTweets) forControlEvents:UIControlEventValueChanged];
  [self.tableView insertSubview:self.refreshControl atIndex:0];
  
  // Kickoff
  [self getInitialTweets];
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)onLogout {
  [User logout];
}

- (void)onNewTweet {
  NSLog(@"New Tweet Please");
}

- (void)getInitialTweets {
  self.tweetsArray = [[NSMutableArray alloc] init];
  [self getTweets:nil];
}

- (void)getTweets:(NSDictionary *)params {
  [SVProgressHUD setBackgroundColor:[[UIColor grayColor] colorWithAlphaComponent:0.7]];
  [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
  [SVProgressHUD showWithStatus:@"Loading Tweets"];
  
  [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
    [self addTweetsToTable:tweets];
  }];
}

- (void)getMoreTweets:(NSDictionary *) params {
  // Grab id of last tweet and set to max_id
  Tweet* lastTweet = self.tweetsArray.lastObject;
  NSNumber *maxID = [[NSNumber alloc] initWithInteger:lastTweet.tweet_id];
  
  if (params == nil) {
    params = [[NSDictionary alloc] init];
  }
  
  NSMutableDictionary *paramsToSend = [NSMutableDictionary dictionaryWithDictionary:params];
  [paramsToSend setObject:maxID forKey:@"max_id"];

  [[TwitterClient sharedInstance] homeTimelineWithParams:paramsToSend completion:^(NSArray *tweets, NSError *error) {
    [self addTweetsToTable:tweets];
  }];
}

- (void)addTweetsToTable: (NSArray *)tweets {
  [self.tweetsArray addObjectsFromArray:tweets];
  [self.tableView reloadData];
  
  // Kill any and all UI loading helpers
  [self.refreshControl endRefreshing];
  [SVProgressHUD dismiss];
}

#pragma mark - TableView methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.tweetsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  TweetTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
  
  cell.tweet = self.tweetsArray[indexPath.row];
  cell.delegate = self;
  
  // End of the table?
  if (indexPath.row == [self tableView:self.tableView numberOfRowsInSection:0] - 1) {
    [self getMoreTweets:nil];
  }

  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  TweetViewController *vc = [[TweetViewController alloc] init];
  vc.tweet = self.tweetsArray[indexPath.row];
  [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - TweetTableViewCell delegate

- (void)TweetTableViewCell:(TweetTableViewCell *)tweetTableViewCell onReply:(BOOL)pressed {
  NSLog(@"Table View Controller on reply");
}

// Keeps things nice when rotated to landscape
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
  TweetTableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:@"TweetTableViewCell" forIndexPath:indexPath];
  [cell setNeedsDisplay];
  [cell layoutIfNeeded];
  
  return [[cell contentView] systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
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
