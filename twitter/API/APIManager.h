//
//  APIManager.h
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "BDBOAuth1SessionManager.h"
#import "BDBOAuth1SessionManager+SFAuthenticationSession.h"
#import "Tweet.h"

@interface APIManager : BDBOAuth1SessionManager

+ (instancetype)shared;

- (void)getHomeTimelineWithCompletion: (NSString *)count completion:(void(^)(NSArray *tweets, NSError *error))completion;
// - (void)postStatusWithText:(NSString *)text: (NSString *)inReplyToID: completion:(void (^)(Tweet *, NSError *))completion;
- (void)postStatusWithText: (NSString *)text inReply:(NSString *)inReplyToID completion:(void (^)(Tweet *, NSError *)) completion;
- (void)favorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unfavorite:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)retweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)unretweet:(Tweet *)tweet completion:(void (^)(Tweet *, NSError *))completion;
- (void)getUserInfo:(void(^)(NSDictionary *userData, NSError *error))completion;
- (void)getMentionsTimelineWithCompletion:(void(^)(NSArray *tweets, NSError *error))completion;
- (void)getUserTimelineWithCompletion: (void(^)(NSArray *tweets, NSError *error))completion;
    
@end
