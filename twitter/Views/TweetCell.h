//
//  TweetCell.h
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@protocol TweetCellDelegate;

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property Tweet *tweet;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (nonatomic, weak) id<TweetCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;

// - (void) didTapUserProfile:(UITapGestureRecognizer *)sender;

@end

@protocol TweetCellDelegate
// TODO: Add required methods the delegate needs to implement
- (void)tweetCell:(TweetCell *) tweetCell didTap: (User *)user;
@end

NS_ASSUME_NONNULL_END
