# Project 3 - *AvasTwitter*

**AvasTwitter** is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **24** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X] See an app icon in the home screen and a styled launch screen
- [X] Be able to log in using their Twitter account
- [X] See at latest the latest 20 tweets for a Twitter account in a Table View
- [X] Be able to refresh data by pulling down on the Table View
- [X] Be able to like and retweet from their Timeline view
- [X] Only be able to access content if logged in
- [X] Each tweet should display user profile picture, username, screen name, tweet text, timestamp, as well as buttons and labels for favorite, reply, and retweet counts.
- [X] Compose and post a tweet from a Compose Tweet view, launched from a Compose button on the Nav bar.
- [X] See Tweet details in a Details view
- [X] App should render consistently all views and subviews in recent iPhone models and all orientations

The following **optional** features are implemented:

- [X] Be able to unlike or un-retweet by tapping a liked or retweeted Tweet button, respectively. (Doing so will decrement the count for each)
- [X] Click on links that appear in Tweets
- [ ] See embedded media in Tweets that contain images or videos
- [X] Reply to any Tweet. Replies should be prefixed with the username. The reply_id should be set when posting the tweet
- [X] See a character count when composing a Tweet (as well as a warning) (280 characters)
- [X] Load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client
- [X] Click on a Profile image to reveal another user’s profile page, including: Header view: picture and tagline and Basic stats: #tweets, #following, #followers
- [X] Switch between timeline, mentions, or profile view through a tab bar
- [ ] Profile Page: pulling down the profile page should blur and resize the header image.

The following **additional** features are implemented:

- [X] Tweets from users with protected accounts (tweets that you can't retweet) have greyed out and disabled retweet buttons.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1. Multiple custom cells in table views.
2. Dynamically changing table view cells/their content. For ex. with adding images to table view cells when you don't know whether or not there will be images or how many there will be.

## Video Walkthrough

Here's a walkthrough of implemented user stories:

1. App icon, log in/log out (on iPhone 8)

<img src='https://github.com/ava-cr/FBUTwitter/blob/main/gifs/twitter1.gif' title='Video Walkthrough 1' width='' alt='Video Walkthrough' />

2. Home timeline with tweets (profile pic, tweet details, timestamps, etc), pull-to-refresh, infinite scrolling (iPhone 11)

<img src='https://github.com/ava-cr/FBUTwitter/blob/main/gifs/twitter2.gif' title='Video Walkthrough 2' width='' alt='Video Walkthrough' />

3. Like/unlike, retweet/unretweet, reply to a tweet/compose a tweet with character limit (on iPhone 11)

<img src='https://github.com/ava-cr/FBUTwitter/blob/main/gifs/twitter3.gif' title='Video Walkthrough 3' width='' alt='Video Walkthrough' />

4.  Tab bar to see timeline/mentions/profile view, profile view has user's timeline, auto-layout in different device sizes/rotation (on iPhone 11)

<img src='https://github.com/ava-cr/FBUTwitter/blob/main/gifs/twitter4.gif' title='Video Walkthrough 4' width='' alt='Video Walkthrough' />

5.  Click on tweet to view a tweet details page, click on a user's profile picture to view their profile page, clickable links (on iPhone 11).

<img src='https://github.com/ava-cr/FBUTwitter/blob/main/gifs/twitter5.gif' title='Video Walkthrough 5' width='' alt='Video Walkthrough' />

GIFs created with [Kap](https://getkap.co/).

## Notes

Describe any challenges encountered while building the app.

I wanted to add the number of replies a tweet had to my tweet cell (along with # of favorites and # of retweets) but reply_count "is only available with the Premium and Enterprise tier products" and so I struggled with why it was returning 0 for a minute. Also, I didn't know that you could have multiple different custom table view cells within a table view so I struggled with how to implement the profile tab before finding this out from my manager (shout-out Kyle).

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- 
    [DateTools](https://github.com/MatthewYork/DateTools#time-ago) - library to streamline date and time handling in iOS.

## License

    Copyright [2021] [Ava Crnkovic-Rubsamen]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
