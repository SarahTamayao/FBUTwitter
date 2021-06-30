//
//  User.m
//  twitter
//
//  Created by Ava Crnkovic-Rubsamen on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.tagline = dictionary[@"description"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        
    // Initialize any other properties
    }
    return self;
}

@end
