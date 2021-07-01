//
//  DetailsViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "Tweet.h"
#import "APIManager.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tweetContentLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.authorLabel.text = self.tweet.user.name;
    self.tweetTextView.text = self.tweet.text;
    
    self.usernameLabel.text = [@"@" stringByAppendingString:self.tweet.user.screenName];
    // self.timeLabel.text = [@"・" stringByAppendingString:self.tweet.createdAtString];
    
    // adding profile image
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    self.profileImageView.image = [[UIImage alloc] initWithData:urlData];
    
    [self refreshData];
}

- (IBAction)didTapFavorite:(id)sender {
    if (self.tweet.favorited) { // unfavorite it
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 // TODO: Update the local tweet model
                 self.tweet.favorited = NO;
                 self.tweet.favoriteCount -= 1;

                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        
    }
    else { // favorite it
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 self.tweet.favorited = YES;
                 self.tweet.favoriteCount += 1;
                 
                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
        
    }
}
- (IBAction)didTapRetweet:(id)sender {

    if (self.tweet.retweeted) { // unretweet it
        // TODO: Send a POST request to the POST retweets/create endpoint
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 // TODO: Update the local tweet model
                 self.tweet.retweeted = NO;
                 self.tweet.retweetCount -= 1;
                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
    }
    else { // retweet it
        // TODO: Send a POST request to the POST retweets/create endpoint
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 // TODO: Update the local tweet model
                 self.tweet.retweeted = YES;
                 self.tweet.retweetCount += 1;
                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
        
    }
        

}

-(void) refreshData {
    if (self.tweet.favorited) self.favButton.selected = YES;
    else self.favButton.selected = NO;
    if (self.tweet.retweeted) self.retweetButton.selected = YES;
    else self.retweetButton.selected = NO;
    [self.retweetButton setTitle:[@(self.tweet.retweetCount) stringValue] forState:UIControlStateNormal];
    [self.favButton setTitle:[@(self.tweet.favoriteCount) stringValue] forState:UIControlStateNormal];
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
