//
//  DetailViewController.h
//  twitter
//
//  Created by Daniel Shiferaw on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"
#import "ComposeViewController.h"

@interface DetailViewController : UIViewController <ComposeViewControllerDelegate>

@property (strong, nonatomic) Tweet *tweet;
@end
