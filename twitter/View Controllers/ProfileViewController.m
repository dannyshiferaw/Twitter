//
//  ProfileViewController.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"
#import "TweetCell.h"
#import <UIKit+AFNetworking.h>

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;

@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;

@property (weak, nonatomic) IBOutlet UILabel *userHandleLabel;

@property (weak, nonatomic) IBOutlet UILabel *userTweetsCount;

@property (weak, nonatomic) IBOutlet UILabel *userFollowingCount;

@property (weak, nonatomic) IBOutlet UILabel *userFollowerCount;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //if user is not loaded 
    if (self.user == nil) {
        [self loadUser];
    }
    [self configureUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//makes a GET request to retrieve owner's profile
- (void)loadUser {
    [[APIManager shared]getProfile:^(User *user, NSError *error) {
        if (user) {
            self.user = user;
            [self configureUI];
        } else {
            NSLog(@"😫😫😫 Error getting owner profile: %@", error.localizedDescription);
        }
    }];
    
}

-(void)configureUI {
    //set
    [self.profileImageView setImageWithURL: self.user.profileImageUrl];
    self.usernameLabel.text = self.user.name;
    self.userHandleLabel.text = self.user.screenName;
    self.userFollowerCount.text = [NSString stringWithFormat:@"%d",
                                   self.user.followers_count];
    self.userFollowingCount.text = [NSString stringWithFormat:@"%d",
                                    self.user.following_count];
    self.userTweetsCount.text = [NSString stringWithFormat:@"%d",0];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



@end
