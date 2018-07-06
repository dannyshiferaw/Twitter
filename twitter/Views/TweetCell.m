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

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)configureCell:(Tweet *)tweet {
   
    
    self.tweet = tweet;
    self.tweetLabel.text = [NSString stringWithFormat:@"%@%@", @"@", self.tweet.text];
    self.numOfFavoritesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numOfRetweetsLabel.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    
    User *user = [self.tweet user];
    [self.profileImageView setImageWithURL:user.profileImageUrl];
    self.screenNameLabel.text = user.name;
    self.usernameLabel.text = user.screenName;
   
}
- (IBAction)didFavBtnTaped:(id)sender {
    //liked or unliked?
    if(self.tweet.isFavorite) {
        self.tweet.isFavorite = NO;
        self.favBtn.selected = NO;
        self.tweet.favoriteCount--;
    } else {
        self.tweet.isFavorite = YES;
        self.favBtn.selected = YES;
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

-(void) refreshData {
    self.numOfFavoritesLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    self.numOfRetweetsLabel.text =  [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
}
- (IBAction)logout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
}





//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    //[super setSelected:selected animated:animated];
//
//    // Configure the view for the selected state
//}

@end
