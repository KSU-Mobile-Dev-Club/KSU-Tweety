//
//  KSUTweetConvenience.swift
//  Tweety
//
//  Created by Reagan Wood on 4/3/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import Foundation

extension KSUTweetClient {
    func getTwitterTweets (tweetsHandler: @escaping (_ success: Bool, _ tweets: [Tweet]) -> Void) {
        
        let ksuTweetPath = UserMethods.GET.tweets
        let methodParamaters = ["screen_name":"KState" as AnyObject, "count": 20 as AnyObject]
        
        _ = KSUTweetyAPISharedInstance().taskForGETMethod(path: ksuTweetPath, methodParameters: methodParamaters) { (result, error) in
            if let result = result as? [AnyObject] {
                tweetsHandler(true, self.parseTwitterResponseObject(tweetAnyObjectArray: result))
            } else {
                print("poo")
            }
        }
    }
    
    func parseTwitterResponseObject (tweetAnyObjectArray: [AnyObject]) -> [Tweet] {
        var tweets: [Tweet] = []
        for tweetAnyObject in tweetAnyObjectArray {
            guard let tweetID = tweetAnyObject["id"] as? Int else {
                return []
            }
            
            guard let tweetText = tweetAnyObject["text"] as? String else {
                return []
            }
            guard let tweetFavoriteCount = tweetAnyObject["favorite_count"] as? Int else {
                return []
            }
            guard let tweetRetweetCount = tweetAnyObject["retweet_count"] as? Int else {
                return []
            }
            var tweetAuthor = "Uknown"
            var profileImageURL = ""
            if let tweetEntitity = tweetAnyObject["user"] as? [String:AnyObject] {
                if let author = tweetEntitity["name"] as? String {
                        tweetAuthor = author
                }
                if let profileImageUrl = tweetEntitity["profile_image_url"] as? String {
                    profileImageURL = profileImageUrl
                }
            }
            let tweet = Tweet(ID: tweetID, text: tweetText, publisher: tweetAuthor, retweetCount: tweetRetweetCount, favoriteCount: tweetFavoriteCount, profileImageURL: profileImageURL)
            tweets.append(tweet)
        }
        return tweets
    }
}
