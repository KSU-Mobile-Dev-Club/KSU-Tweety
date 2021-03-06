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
    var downloadedImages: [Int:UIImage] = [:]
    var tweets: [Tweet] = []
    var tweetIndexSelected: Int = 0
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
        let tweet = tweets[indexPath.row]
        cell.tweetText.text = tweet.text
        cell.tweeter.text = tweet.publisher
        cell.favoritesCount.text = String(tweet.favoriteCount)
        cell.retweetCount.text = String(tweet.retweetCount)
        if !tweet.profileImageURL.isEmpty {
            if downloadedImages[indexPath.row] != nil {
                cell.profileImage.image = downloadedImages[indexPath.row]
            } else {
                getImageFromWeb(tweet.profileImageURL, closure: { (image) in
                    cell.profileImage.image = image
                    if image != nil {
                        self.downloadedImages[indexPath.row] = image
                    }
                })
            }
        }
        return cell
    }
    
    func getImageFromWeb(_ urlString: String, closure: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {
            return closure(nil)
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("error: \(String(describing: error))")
                return closure(nil)
            }
            guard response != nil else {
                print("no response")
                return closure(nil)
            }
            guard data != nil else {
                print("no data")
                return closure(nil)
            }
            DispatchQueue.main.async {
                closure(UIImage(data: data!))
            }
        }; task.resume()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tweetIndexSelected = indexPath.row
//        self.navigationController?.performSegue(withIdentifier: "DetailSegue", sender: self)
        self.performSegue(withIdentifier: "DetailSegue", sender: self)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! DetailViewController
        var tweet = tweets[tweetIndexSelected]
        if (downloadedImages[tweetIndexSelected] != nil) {
            vc.image1 =  downloadedImages[tweetIndexSelected]
        }
        vc.publisher1 = tweet.publisher
        vc.text1 = tweet.text
    }
}

