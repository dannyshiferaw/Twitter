//
//  Twitter.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

-(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //is this is a retweet?
        NSDictionary *originalTweet = [dictionary objectForKey:@"retweet_status"];
        if (originalTweet != nil) {
            NSDictionary *userDictionary = dictionary[@"user"];
            self.retweetedByUser = [[User alloc] initWithDictionary:userDictionary];
            //change tweet to original
            dictionary = originalTweet;
        }
        self.createdAt = dictionary[@"created_at"];
        self.tweetId = dictionary[@"id_str"];
        self.text = dictionary[@"text"];
        self.user = dictionary[@"user"];
        self.isFavorite = [dictionary[@"favorite"] boolValue];
        self.favoriteCount = [dictionary[@"favorite_count"] intValue];
        self.isRetweeted = [dictionary[@"retweeted"] boolValue];
        self.retweetCount = [dictionary[@"retweet_count"] intValue];
        
        //initialize User
        NSDictionary *user = dictionary[@"user"];
        self.user = [[User alloc] initWithDictionary:user];
        
        //format created date
        self.createdAt = [self format:dictionary[@"created_at"]];
        
    }
    return self;
}

//return array of tweets diven array of dicitionaries
+ (NSMutableArray *)tweetsWithArray: (NSArray *)dictionaries {
    NSMutableArray *tweets = [NSMutableArray array];
    for (NSDictionary *dict in dictionaries) {
        Tweet *tweet = [[Tweet alloc] initWithDictionary:dict];
        [tweets addObject:tweet];
    }
    return tweets;
}

//formats Date
-(NSString *)format: (NSString *)created_date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat =  @"E MMM d HH:mm:ss Z y";
    NSDate *date = [formatter dateFromString: created_date];
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    return [formatter stringFromDate:date];
}

@end

