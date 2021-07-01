//
//  ProfileViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

// tap user's profile photo to get to their profile page (UserViewController)
// right tab bar item get's to logged in user's profile page (ProfileViewController)

#import "ProfileViewController.h"
#import "User.h"
#import "APIManager.h"
#import "ProfileHeaderCell.h"
#import "ProfileTweetCell.h"


@interface ProfileViewController () <UITableViewDelegate, UITableViewDataSource>

// @property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
// @property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// @property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
// @property (weak, nonatomic) IBOutlet UILabel *numTweets;
// @property (weak, nonatomic) IBOutlet UILabel *numFollowing;
// @property (weak, nonatomic) IBOutlet UILabel *numFollowers;
@property (strong, nonatomic) NSDictionary *userDict;
@property (strong, nonatomic) User *user;
// @property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
// @property (weak, nonatomic) IBOutlet UILabel *taglineLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *arrayOfTweets;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self getUserData];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    /*
    [[APIManager shared] getUserInfo:^(NSDictionary *userData, NSError *error) {
        if (userData) {
            NSLog(@"successfully loaded user data");
            NSLog(@"%@", userData);
            self.numFollowers.text = [@([userData[@"followers_count"] intValue]) stringValue];
            self.numFollowing.text = [@([userData[@"friends_count"] intValue]) stringValue];
            self.numTweets.text = [@([userData[@"statuses_count"] intValue]) stringValue];
            self.nameLabel.text = userData[@"name"];
            self.usernameLabel.text = [@"@" stringByAppendingString:userData[@"screen_name"]];
            self.taglineLabel.text = userData[@"description"];
            
            //NSMutableArray *tweets = [Tweet tweetsWithArray:userData[@"statuses"]];
            // NSLog(@"HERE");
            //NSLog(@"%@", tweets);
            // NSMutableArray *tweets  = [Tweet tweetsWithArray:tweetDictionaries];
            
            // adding profile image
            NSString *profURLString = userData[@"profile_image_url_https"];
            NSURL *profURL = [NSURL URLWithString:profURLString];
            NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
            self.profileImageView.image = [[UIImage alloc] initWithData:profURLData];
            self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.size.width / 2;

            
            // adding background image
            NSString *backURLString = userData[@"profile_banner_url"];
            if ((NSNull *)backURLString != [NSNull null]) {
                // NSLog(@"%@", @"here");
                NSURL *backURL = [NSURL URLWithString:backURLString];
                NSData *backURLData = [NSData dataWithContentsOfURL:backURL];
                self.backgroundImageView.image = [[UIImage alloc] initWithData:backURLData];
            }
            
        } else {
            NSLog(@"error getting user data: %@", error.localizedDescription);
        }
    }];
     */
}

-(void) getUserData {
    [[APIManager shared] getUserInfo:^(NSDictionary *userData, NSError *error) {
        if (userData) {
            NSLog(@"successfully loaded user data");
            NSLog(@"%@", userData);
            self.userDict = userData;
            self.user = [[User alloc] initWithDictionary: userData];
            [self.tableView reloadData];
            
        } else {
            NSLog(@"error getting user data: %@", error.localizedDescription);
        }
    }];
    [[APIManager shared] getUserTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"successfully loaded user timeline");
            
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"error getting user timeline: %@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([self.arrayOfTweets count] + 1 < 20) return [self.arrayOfTweets count] + 1;
    else return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // for cell #1 - header cell
    
    if (indexPath.row == 0) {
        // self.tableView.rowHeight = 245;
        ProfileHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileHeaderCell"];
        cell.nameLabel.text = self.user.name;
        cell.usernameLabel.text = self.user.screenName;
        cell.taglineLabel.text = self.user.tagline;
        cell.numFollowers.text = self.user.numFollowers;
        cell.numFollowing.text = self.user.numFollowing;
        cell.numTweets.text = self.user.numTweets;
        
        
        // adding profile image
        NSString *profURLString = self.user.profilePicture;
        NSURL *profURL = [NSURL URLWithString:profURLString];
        NSData *profURLData = [NSData dataWithContentsOfURL:profURL];
        cell.profileImageView.image = [[UIImage alloc] initWithData:profURLData];
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.size.width / 2;
        
        // adding background image
        NSString *backURLString = self.user.backgroundPicture;
        if ((NSNull *)backURLString != [NSNull null]) {
            NSURL *backURL = [NSURL URLWithString:backURLString];
            NSData *backURLData = [NSData dataWithContentsOfURL:backURL];
            cell.headerImageView.image = [[UIImage alloc] initWithData:backURLData];
        }
        
        
        return cell;
    }
    
    else {
        ProfileTweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileTweetCell"];
        
        Tweet *tweet = self.arrayOfTweets[indexPath.row - 1];
        cell.tweet = tweet;
        
        // setting cell views from tweet object
        cell.authorLabel.text = tweet.user.name;
        // cell.tweetTextLabel.text = tweet.text;
        cell.tweetTextView.text = tweet.text;
        
        
        // buttons selected or not, add correct counts to button labels
        if (cell.tweet.favorited) cell.favButton.selected = true;
        else cell.favButton.selected = false;
        if (cell.tweet.retweeted) cell.retweetButton.selected = true;
        else cell.retweetButton.selected = false;
        [cell.retweetButton setTitle:[@(tweet.retweetCount) stringValue] forState:UIControlStateNormal];
        [cell.favButton setTitle:[@(tweet.favoriteCount) stringValue] forState:UIControlStateNormal];
        
        // grey out & disable the retweet button if the user has a protected account
        if (cell.tweet.user.protectedAccount) {
            [cell.retweetButton setEnabled:NO];
            cell.retweetButton.imageView.alpha = 0.5;
        }
        else {
            [cell.retweetButton setEnabled:YES];
            cell.retweetButton.imageView.alpha = 1;
        }
        

        // screen name and time label
        if (tweet.user.screenName) {
            cell.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
        }
        if (tweet) cell.timeLabel.text = [@"・" stringByAppendingString:tweet.createdAtString];
        
        // adding profile image
        NSString *URLString = tweet.user.profilePicture;
        NSURL *url = [NSURL URLWithString:URLString];
        NSData *urlData = [NSData dataWithContentsOfURL:url];
        cell.profileImageView.image = [[UIImage alloc] initWithData:urlData];
        cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.size.width / 2;
        
        return cell;
    }
    
    
    
    
    
    
    // get tweet object
    /*
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    cell.tweet = tweet;
    
    // setting cell views from tweet object
    cell.authorLabel.text = tweet.user.name;
    // cell.tweetTextLabel.text = tweet.text;
    cell.tweetTextView.text = tweet.text;
    
    
    // buttons selected or not, add correct counts to button labels
    if (cell.tweet.favorited) cell.favButton.selected = true;
    else cell.favButton.selected = false;
    if (cell.tweet.retweeted) cell.retweetButton.selected = true;
    else cell.retweetButton.selected = false;
    [cell.retweetButton setTitle:[@(tweet.retweetCount) stringValue] forState:UIControlStateNormal];
    [cell.favButton setTitle:[@(tweet.favoriteCount) stringValue] forState:UIControlStateNormal];
    
    // grey out & disable the retweet button if the user has a protected account
    if (cell.tweet.user.protectedAccount) {
        [cell.retweetButton setEnabled:NO];
        cell.retweetButton.imageView.alpha = 0.5;
    }
    else {
        [cell.retweetButton setEnabled:YES];
        cell.retweetButton.imageView.alpha = 1;
    }
    

    // screen name and time label
    if (tweet.user.screenName) {
        cell.usernameLabel.text = [@"@" stringByAppendingString:tweet.user.screenName];
    }
    if (tweet) cell.timeLabel.text = [@"・" stringByAppendingString:tweet.createdAtString];
    
    // adding profile image
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.profileImageView.image = [[UIImage alloc] initWithData:urlData];
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.size.width / 2;

    
    // assign the delegate property of the cell to the view controller
    cell.delegate = self;
    
    // TO DO: figure out replies button #
    */
    //return cell;
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
