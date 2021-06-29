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
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)didTapFavorite:(id)sender {
    
    // TODO: Send a POST request to the POST favorites/create endpoint
    [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         if(error){
              NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
         }
         else{
             // TODO: Update the local tweet model
             self.tweet.favorited = YES;
             self.tweet.favoriteCount += 1;
             // TODO: Update cell UI
             [self refreshData];
             NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
         }
     }];
}

-(void) refreshData {
    if (self.tweet.favorited) {
        self.favButton.selected = true;
    }
    if (self.tweet.retweeted) {
        self.replyButton.selected = true;
    }
    [self.retweetButton setTitle:[@(self.tweet.retweetCount) stringValue] forState:UIControlStateNormal];
    [self.favButton setTitle:[@(self.tweet.favoriteCount) stringValue] forState:UIControlStateNormal];
}

@end
