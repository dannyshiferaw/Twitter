//
//  TweetCell.h
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

@interface TweetCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *tweetLabel
;

@property (weak, nonatomic) IBOutlet UILabel *numOfRepliesLabel;

@property (weak, nonatomic) IBOutlet UILabel *numOfRetweetsLabel;

@property (weak, nonatomic) IBOutlet UILabel *numOfFavoritesLabel;

@property (weak, nonatomic) IBOutlet UIButton *favBtn;

@property (weak, nonatomic) IBOutlet UIButton *retweetBtn;

@property (nonatomic, strong) Tweet *tweet;

-(void)configureCell:(Tweet *)tweet;






@end
