//
//  User.m
//  Twitter
//
//  Created by Tyler Craft on 2/18/15.
//  Copyright (c) 2015 Tyler. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"

NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";

@interface User()

@property (nonatomic, strong) NSDictionary *dictionary;

@end

@implementation User

- (id)initWithDictionary:(NSDictionary *)dictionary {
  self = [super init];
  
  if (self) {
    self.dictionary = dictionary;
    self.name = dictionary[@"name"];
    self.screenname = dictionary[@"screen_name"];
    self.handle = [NSString stringWithFormat: @"@%@", self.screenname];
    
    // Grab the larger profile image (48px x 73px)
    // https://dev.twitter.com/overview/general/user-profile-images-and-banners
    self.profileImageURL = [dictionary[@"profile_image_url"] stringByReplacingOccurrencesOfString:@"_normal"
                                   withString:@"_bigger"];
    self.tagline = dictionary[@"description"];
  }
  
  return self;
}

static User *_currentUser = nil;
NSString * const KCurrentUserKey = @"KCurrentUserKey";

+ (User *)currentUser {
  
  if (_currentUser == nil) {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:KCurrentUserKey];
    
    if (data != nil) {
      NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
      _currentUser = [[User alloc] initWithDictionary:dictionary];
    }
  }
  
  return _currentUser;
}

+ (void)setCurrentUser:(User *)currentUser {
  _currentUser = currentUser;
  
  if (_currentUser != nil) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:KCurrentUserKey];
  } else {
    [[NSUserDefaults standardUserDefaults] setObject:nil forKey:KCurrentUserKey];
  }
  
  [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)logout {
  [User setCurrentUser:nil];
  [[TwitterClient sharedInstance].requestSerializer removeAccessToken];
  
  [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}

@end