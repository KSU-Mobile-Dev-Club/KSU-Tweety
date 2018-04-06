//
//  ViewController.swift
//  Tweety
//
//  Created by Reagan Wood on 2/2/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UITableViewController {

    var tweets: [Tweet] = []
    override func viewDidLoad() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        KSUTweetyAPISharedInstance().getTwitterTweets { (success, tweetsForDisplay) in
            self.tweets = tweetsForDisplay
            self.tableView.reloadData()
        }
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetTableViewCell
        cell.tweetText.text = tweets[indexPath.row].text
        cell.tweeter.text = tweets[indexPath.row].publisher
        cell.favoritesCount.text = String(tweets[indexPath.row].favoriteCount)
        cell.retweetCount.text = String(tweets[indexPath.row].retweetCount)
        return cell
    }
}

