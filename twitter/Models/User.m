//
//  User.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

-(instancetype) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        //string id
        self.userId  = dictionary[@"id_str"];
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = [NSURL URLWithString: dictionary[@"profile_image_url_https"]];
        self.followers_count = [dictionary[@"followers_count"] intValue];
        self.following_count = [dictionary[@"followers_count"] intValue];
    }
    return self;
}

@end
