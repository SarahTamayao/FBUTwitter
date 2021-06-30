//
//  UserViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

// tap user's profile photo to get to their profile page (UserViewController)
// right tab bar item get's to logged in user's profile page (ProfileViewController)

#import "UserViewController.h"

@interface UserViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@", self.user.name);
    self.nameLabel.text = self.user.name;
    self.usernameLabel.text = [@"@" stringByAppendingString:self.user.screenName];
    self.taglineLabel.text = self.user.tagline;
    
    // adding profile image
    NSString *URLString = self.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profileImageView.image = [[UIImage alloc] initWithData:urlData];
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
