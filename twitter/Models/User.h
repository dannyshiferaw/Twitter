//
//  User.h
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic, strong) NSString *userId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *screenName;
@property(nonatomic, strong) NSURL* profileImageUrl;
@property NSInteger *followers_count;
@property NSInteger *following_count;
@property NSInteger *tweets_count;


-(instancetype)initWithDictionary: (NSDictionary *) dictionary;

@end
