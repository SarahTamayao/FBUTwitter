//
//  TweetCell.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "Tweet.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    
    [self.profileImageView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileImageView setUserInteractionEnabled:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    //TODO: Call method delegate
    [self.delegate tweetCell:self didTap:self.tweet.user];
}

@end
