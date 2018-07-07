//
//  TweetCell.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "AppDelegate.h"
#import "TweetCell.h"
#import "APIManager.h"
#import "LoginViewController.h"
#import <UIKit+AFNetworking.h>
#import <NSDate+DateTools.h>

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //setup gesture
     UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImageView setUserInteractionEnabled:YES];
}

//populates cell with data
-(void)configureCell:(Tweet *)tweet {
    //set tweet
    self.tweet = tweet;
    //set the UI attributes
    self.tweetLabel.text = [NSString stringWithFormat:@"%@", self.tweet.text];           //tweet text
    self.numOfFavoritesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];   //favorite count
    self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];     //retweets count
    self.numOfRepliesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.user.tweets_count];     //retweets count
    
    
    //get tweeter's info
    User *user = [self.tweet user];
    [self.profileImageView setImageWithURL:user.profileImageUrl];       //user profile image
    self.screenNameLabel.text = user.name;                              //full name
    
    //get duration between the time the tweet was posted and now
    NSString *duration = [self.tweet.createdAt shortTimeAgoSinceNow];
    self.usernameLabel.text = [NSString stringWithFormat:@"%@%@%@%@", @"@",user.screenName,@" . ", duration];
    
    //toggle
    if (self.tweet.isFavorite) {
        self.favBtn.selected = YES;
    }
    if (self.tweet.isRetweeted) {
        self.retweetBtn.selected = YES;
    }
}

//if favorited, increments otherwise decrements num of favorites
//updates local UI
//and calls API manager to post the updates
- (IBAction)didFavBtnTaped:(id)sender {
    //liked or unliked?
    if(self.tweet.isFavorite) {
        self.tweet.isFavorite = NO;
        self.favBtn.selected = NO;       //untoggle like button
        self.tweet.favoriteCount--;
    } else {
        self.tweet.isFavorite = YES;
        self.favBtn.selected = YES;     //toggle like button
        self.tweet.favoriteCount++;
    }
    //send the update
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
        }
    }];
    //refresh UI
    [self refreshData];
}
//if retweeted, increments otherwise decrements num of retweets
//updates local UI
//and calls API manager to post the updates
- (IBAction)didRetweetBtnTaped:(id)sender {
    if (self.tweet.isRetweeted) {   //unTweet
        self.tweet.isRetweeted = NO;
        self.retweetBtn.selected = NO;
        self.tweet.retweetCount--;
    } else {
        self.tweet.isRetweeted = YES;
        self.retweetBtn.selected = YES;
        self.tweet.retweetCount++;
    }
    //send the update
    [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
        }
    }];
    //refresh UI
    [self refreshData];
    
}
//updates favorite and retweeet count UI labels
-(void) refreshData {
    self.numOfFavoritesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numOfRetweetsLabel.text =  [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
}


- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
   [self.delegate tweetCell:self didTap:self.tweet.user];
}




//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    //[super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
