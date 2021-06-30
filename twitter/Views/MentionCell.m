//
//  MentionCell.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "MentionCell.h"
#import "APIManager.h"
#import "Tweet.h"
// #import "MentionsViewController.h"

@implementation MentionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    if (self.mention.favorited) { // unfavorite it
        
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] unfavorite:self.mention completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 // TODO: Update the local tweet model
                 self.mention.favorited = NO;
                 self.mention.favoriteCount -= 1;

                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        
    }
    else { // favorite it
        // TODO: Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.mention completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 self.mention.favorited = YES;
                 self.mention.favoriteCount += 1;
                 
                 // TODO: Update cell UI
                 [self refreshData];
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
        
    }
}
- (IBAction)didTapRetweet:(id)sender {
    NSLog(@"%d", self.mention.user.protectedAccount);
    
    if (self.mention.user.protectedAccount) {
        NSLog(@"protected account, you can't retweet");
    }
    else {
        if (self.mention.retweeted) { // unretweet it
            // TODO: Send a POST request to the POST retweets/create endpoint
            [[APIManager shared] unretweet:self.mention completion:^(Tweet *tweet, NSError *error) {
                 if(error){
                      NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
                 }
                 else{
                     // TODO: Update the local tweet model
                     self.mention.retweeted = NO;
                     self.mention.retweetCount -= 1;
                     // TODO: Update cell UI
                     [self refreshData];
                     NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                 }
             }];
        }
        else { // retweet it
            // TODO: Send a POST request to the POST retweets/create endpoint
            [[APIManager shared] retweet:self.mention completion:^(Tweet *tweet, NSError *error) {
                 if(error){
                      NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
                 }
                 else{
                     // TODO: Update the local tweet model
                     self.mention.retweeted = YES;
                     self.mention.retweetCount += 1;
                     // TODO: Update cell UI
                     [self refreshData];
                     NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                 }
             }];
        }
    }
}

-(void) refreshData {
    if (self.mention.favorited) self.favButton.selected = YES;
    else self.favButton.selected = NO;
    if (self.mention.retweeted) self.retweetButton.selected = YES;
    else self.retweetButton.selected = NO;
    [self.retweetButton setTitle:[@(self.mention.retweetCount) stringValue] forState:UIControlStateNormal];
    [self.favButton setTitle:[@(self.mention.favoriteCount) stringValue] forState:UIControlStateNormal];
}

@end
