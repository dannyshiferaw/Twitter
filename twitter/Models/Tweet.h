//
//  Twitter.h
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"

@interface Tweet : NSObject

@property(nonatomic, strong) NSString *createdAt;
@property(nonatomic, strong) NSString *tweetId;
@property(nonatomic, strong) NSString *text;
@property(nonatomic) int favoriteCount;
@property(nonatomic) BOOL isFavorite;
@property(nonatomic) int retweetCount;
@property(nonatomic) BOOL isRetweeted;
@property(nonatomic, strong) User *user;

@property(strong, nonatomic) User *retweetedByUser;

-(instancetype)initWithDictionary:(NSDictionary *) dictionary;

+(NSMutableArray *)tweetsWithArray: (NSArray *) dictionaries;


@end
