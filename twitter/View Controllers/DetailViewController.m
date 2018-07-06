//
//  DetailViewController.m
//  twitter
//
//  Created by Daniel Shiferaw on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UILabel *tweetText;

@property (weak, nonatomic) IBOutlet UILabel *repliesCount;

@property (weak, nonatomic) IBOutlet UILabel *favoritesCount;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//set tweet 
- (void)didTweet:(Tweet *)tweet {
    self.tweet = tweet;
}


@end
