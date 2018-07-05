//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;

//compose and sends new tweets
- (void)postTweet:(NSString *)tweetText completion:(void (^)(Tweet *, NSError *))completion;

//called when a tweet is liked/unliied
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

//called when a tweet is retweeted/unretweeted
-(void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;

@end
