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

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
- (IBAction)tweetButtonTapped:(id)sender {
        
    [[APIManager shared] postStatusWithText:self.tweetTextView.text completion:^(Tweet *tweet, NSError *error) {
        if(tweet) {
            NSLog(@"successfully posted tweet");
            [self dismissViewControllerAnimated:true completion:nil];
            
        } else {
            NSLog(@"error posting tweet: %@", error.localizedDescription);
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
