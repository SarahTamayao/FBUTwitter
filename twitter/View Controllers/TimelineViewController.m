//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ComposeViewController.h"
#import "DetailsViewController.h"
#import "UserViewController.h"
#import "TweetCell.h"
#import "Tweet.h"

@interface TimelineViewController () <TweetCellDelegate, ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *logoutButton;
@property (strong, nonatomic) NSMutableArray *arrayOfTweets;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    [self loadTweets:@"20"];
}
- (void)viewWillAppear:(BOOL)animated {
    // so that if you favorite/unfavorite/retweet/unretweet a tweet from the details view it will appear correctly immediately when you return to the home timeline
    [self.tableView reloadData];
}

- (void) loadTweets: (NSString *) count {
    // Get timeline
    [[APIManager shared] getHomeTimelineWithCompletion:count completion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            
            self.arrayOfTweets = tweets;
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
}

// Makes a network request to get updated data
// Updates the tableView with the new data
// Hides the RefreshControl
- (void)beginRefresh:(UIRefreshControl *)refreshControl {

    // gets data and reloads table view
    [self loadTweets:@"20"];
         
    // Tell the refreshControl to stop spinning
    [refreshControl endRefreshing];
}


- (IBAction)logoutButtonPressed:(id)sender {
    NSLog(@"%s", "logout");
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.arrayOfTweets count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    // get tweet object
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
    
    return cell;
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets addObject:tweet];
    [self loadTweets:@"20"];
    // [self.tableView reloadData];
}

// using tap gesture recognizer to perform segue to UserViewController (user's profile)
- (void)tweetCell:(TweetCell *)tweetCell didTap:(User *)user{
    // TODO: Perform segue to profile view controller
    [self performSegueWithIdentifier:@"showUserProfile" sender:user];
}

// infinite scrolling method
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row + 1 == [self.arrayOfTweets count]){
        [self loadTweets:[NSString stringWithFormat:@"%lu", ([self.arrayOfTweets count] + 21)]];
        NSLog(@"%@", [NSString stringWithFormat:@"%lu", [self.arrayOfTweets count]]);
        
    }
}


 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     
     if ([segue.identifier isEqual:@"composeTweet"]) {
         UINavigationController *navigationController = [segue destinationViewController];
         ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
         composeController.delegate = self;
     }
     else if ([segue.identifier isEqual:@"viewTweet"]) {
         NSLog(@"viewing details");
         UITableViewCell *tappedCell = sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
         Tweet *tweet = self.arrayOfTweets[indexPath.row];
         
         DetailsViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.tweet = tweet;
     }
     else if ([segue.identifier isEqual:@"showUserProfile"]){
         UserViewController *userViewController = [segue destinationViewController];
         userViewController.user = sender;
     }
 }


@end
