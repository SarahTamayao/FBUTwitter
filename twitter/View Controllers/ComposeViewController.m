//
//  ComposeViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *tweetTextView;
@property (weak, nonatomic) IBOutlet UILabel *characterCountLabel;


@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.repliedToTweet) {
        NSString *username = [@"@" stringByAppendingString:self.repliedToTweet.user.screenName];
        self.tweetTextView.text = [username stringByAppendingString:@" "];
        
    }
    self.tweetTextView.delegate = self;
    self.tweetTextView.layer.borderWidth = 1;
    
    UIColor *twitterBlue = [UIColor colorWithRed:29/255.0 green:161/255.0 blue:242/255.0 alpha:1.0];
    self.tweetTextView.layer.borderColor = [twitterBlue CGColor];
    self.tweetTextView.layer.cornerRadius = self.tweetTextView.bounds.size.height / 6;
    self.tweetTextView.textContainer.lineFragmentPadding = 20;
    self.characterCountLabel.textColor = twitterBlue;
}
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetButtonTapped:(id)sender {
    
    NSString *repliedToTweetString = [NSString alloc];
    if (self.repliedToTweet) repliedToTweetString = self.repliedToTweet.idStr;
    else repliedToTweetString = @"";
    
    [[APIManager shared]postStatusWithText:self.tweetTextView.text inReply:repliedToTweetString completion:^(Tweet *tweet, NSError *error) {
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
            [self dismissViewControllerAnimated:true completion:nil];
        }
    }];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    // TODO: Check the proposed new text character count
    // Set the max character limit
    NSInteger characterLimit = 140;

    // Construct what the new text would be if we allowed the user's latest edit
    NSString *newText = [self.tweetTextView.text stringByReplacingCharactersInRange:range withString:text];
    
    // TODO: Update character count label
    if (newText.length <= characterLimit) {
        NSInteger charactersLeft = characterLimit - newText.length;
        self.characterCountLabel.text = [NSString stringWithFormat:@"%lu", charactersLeft];
    }

    // TODO: Allow or disallow the new text
    // Should the new text should be allowed? True/False
    return newText.length <= characterLimit;
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
