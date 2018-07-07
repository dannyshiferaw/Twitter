//
//  APIManager.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "APIManager.h"
#import "Tweet.h"

static NSString * const baseURLString = @"https://api.twitter.com";
static NSString * const consumerKey = @"d50NUcakLX1G93zPxnqvQDhAj";
static NSString * const consumerSecret = @"O87fLl5eZcLWelPwtAHSXNbgPTlqlyt10Q6SgcAACB35MjP7hb";

@interface APIManager()

@end

@implementation APIManager

+ (instancetype)shared {
    static APIManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    
    NSURL *baseURL = [NSURL URLWithString:baseURLString];
    NSString *key = consumerKey;
    NSString *secret = consumerSecret;
    // Check for launch arguments override
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"]) {
        key = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-key"];
    }
    if ([[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"]) {
        secret = [[NSUserDefaults standardUserDefaults] stringForKey:@"consumer-secret"];
    }
    
    self = [super initWithBaseURL:baseURL consumerKey:key consumerSecret:secret];
    if (self) {
        
    }
    return self;
}

- (void)getHomeTimelineWithCompletion:(NSNumber *)numberOfTweets completion:(void(^)(NSArray *tweets, NSError *error))completion {
    
    NSURL *urlString = @"1.1/statuses/home_timeline.json";
    NSDictionary *parameters =  @{@"count": numberOfTweets};
    [self GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSArray *  _Nullable tweetDictionaries) {
        
        // Manually cache the tweets. If the request fails, restore from cache if possible.
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tweetDictionaries];
        [[NSUserDefaults standardUserDefaults] setValue:data forKey:@"hometimeline_tweets"];
        
        NSMutableArray *tweets = [Tweet tweetsWithArray: tweetDictionaries];
        completion(tweets, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSMutableArray *tweets = nil;
        // Fetch tweets from cache if possible
        NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:@"hometimeline_tweets"];
        if (data != nil) {
            tweets = [Tweet tweetsWithArray:[NSKeyedUnarchiver unarchiveObjectWithData:data]];
        }
        completion(tweets, error);
    }];
}

//posts a new tweet
- (void)postTweet:(NSString *)tweetText completion:(void (^)(Tweet *, NSError *))completion {
    
    //api end point and necessary paramerters
    NSString *urlString = @"1.1/statuses/update.json";
    NSDictionary *parameters = @{@"status": tweetText};
    
    //POST requst
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//checks if it's favorite or unfavorite action and makes a post
//request using the correspoinding API end point
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {
    //end point
    NSString *urlString;
    
    //set the endpoint
    if (tweet.isFavorite) urlString = @"1.1/favorites/create.json";
    else urlString =  @"1.1/favorites/destroy.json";
    
    //make a POST request
    NSDictionary *parameters = @{@"id":tweet.tweetId};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

//checks if it's a retweet or unretweet and makes POST request
//using the corresponding API end point
-(void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion {
    //end point
    NSString *urlString;
    //set the end point
    if (tweet.isRetweeted) urlString = @"1.1/statuses/retweet.json";
    else urlString = @"1.1/statuses/unretweet.json";
    
    //mae post request
    NSDictionary *parameters = @{@"id":tweet.tweetId};
    [self POST:urlString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable tweetDictionary) {
        Tweet *tweet = [[Tweet alloc]initWithDictionary:tweetDictionary];
        completion(tweet, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];
}

-(void)getProfile: (void(^)(User *user, NSError *error))completion {
    //end point
    NSString *urlString = @"1.1/account/verify_credentials.json";
    //make GET request
    [self GET:urlString parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable userProfile) {
        User *user = [[User alloc] initWithDictionary:userProfile];
        completion(user, nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        completion(nil, error);
    }];

}


@end
