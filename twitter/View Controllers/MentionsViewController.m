//
//  MentionsViewController.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/30/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "MentionsViewController.h"
#import "APIManager.h"
#import "MentionCell.h"

@interface MentionsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *arrayOfMentions;

@end

@implementation MentionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Do any additional setup after loading the view.
    [[APIManager shared] getMentionsTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            self.arrayOfMentions = tweets;
            [self.tableView reloadData];
            
        } else {
            NSLog(@"error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.arrayOfMentions.count >= 20) return 20;
    else return self.arrayOfMentions.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MentionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MentionCell"];
    
    
    // get tweet object
    Tweet *mention = self.arrayOfMentions[indexPath.row];
    cell.mention = mention;
    
    // setting cell views from tweet object
    cell.nameLabel.text = mention.user.name;
    cell.tweetContentLabel.text = mention.text;
    
    // buttons selected or not, add correct counts to button labels
    if (cell.mention.favorited) cell.favButton.selected = true;
    else cell.favButton.selected = false;
    if (cell.mention.retweeted) cell.retweetButton.selected = true;
    else cell.retweetButton.selected = false;
    [cell.retweetButton setTitle:[@(mention.retweetCount) stringValue] forState:UIControlStateNormal];
    [cell.favButton setTitle:[@(mention.favoriteCount) stringValue] forState:UIControlStateNormal];
    
    // grey out & disable the retweet button if the user has a protected account
    if (cell.mention.user.protectedAccount) {
        [cell.retweetButton setEnabled:NO];
        cell.retweetButton.imageView.alpha = 0.5;
    }
    else {
        [cell.retweetButton setEnabled:YES];
        cell.retweetButton.imageView.alpha = 1;
    }
    
    // screen name and time label
    if (mention.user.screenName) {
        cell.usernameLabel.text = [@"@" stringByAppendingString:mention.user.screenName];
    }
    if (mention) cell.timeLabel.text = [@"・" stringByAppendingString:mention.createdAtString];
    
    // adding profile image
    NSString *URLString = mention.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    NSData *urlData = [NSData dataWithContentsOfURL:url];
    cell.profileImageView.image = [[UIImage alloc] initWithData:urlData];
    cell.profileImageView.layer.cornerRadius = cell.profileImageView.bounds.size.width / 2;

    
    // assign the delegate property of the cell to the view controller
    // cell.delegate = self;
    
    // TO DO: figure out replies button #
    
    return cell;
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
