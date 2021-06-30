//
//  ProfileViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"

@interface ProfileViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (strong, nonatomic) NSDictionary *userDict;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [[APIManager shared] getUserInfo:^(NSDictionary *userData, NSError *error) {
        if (userData) {
            NSLog(@"successfully loaded user data");
            NSLog(@"%@", userData);
            self.numFollowers.text = [@([userData[@"followers_count"] intValue]) stringValue];
            self.numFollowing.text = [@([userData[@"following"] intValue]) stringValue];
            self.numTweets.text = [@([userData[@"statuses_count"] intValue]) stringValue];
            self.nameLabel.text = userData[@"name"];
            self.usernameLabel.text = userData[@"screen_name"];
            
            // adding profile image
            /*
            NSString *URLString = userData[@"profile_image_url"];
            NSURL *url = [NSURL URLWithString:URLString];
            NSData *urlData = [NSData dataWithContentsOfURL:url];
            self.profileImageView.image = [[UIImage alloc] initWithData:urlData];
             */
            
        } else {
            NSLog(@"error getting user data: %@", error.localizedDescription);
        }
    }];
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
