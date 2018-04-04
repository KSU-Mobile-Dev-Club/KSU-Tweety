//
//  KSUTweetConvenience.swift
//  Tweety
//
//  Created by Reagan Wood on 4/3/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import Foundation

extension KSUTweetClient {
    func getTwitterTweets (tweetsHandler: @escaping (_ success: Bool, _ error: String) -> Void) {
        
        let ksuTweetPath = UserMethods.GET.tweets
        let methodParamaters = ["screen_name":"KState" as AnyObject, "count": 20 as AnyObject]
        
        _ = KSUTweetyAPISharedInstance().taskForGETMethod(path: ksuTweetPath, methodParameters: methodParamaters) { (result, error) in
            if let result = result {
                print(result)
            } else {
                print("poo")
            }
        }
    }
}
