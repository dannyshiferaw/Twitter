//
//  TweetCell.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import <UIKit+AFNetworking.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureCell:(Tweet *)tweet {
   
    self.tweet = tweet;
    self.textLabel.text = self.tweet.text;
    self.numOfFavoritesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    User *user = [self.tweet user];
    [self.profileImageView setImageWithURL:user.profileImageUrl];
    self.screenNameLabel.text = user.name;
    self.usernameLabel.text = user.screenName;
   
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
