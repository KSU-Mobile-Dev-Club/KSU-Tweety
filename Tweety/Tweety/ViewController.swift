//
//  ViewController.swift
//  Tweety
//
//  Created by Reagan Wood on 2/2/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import UIKit
import TwitterKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        KSUTweetyAPISharedInstance().getTwitterTweets { (success, error) in

        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var TweetTable: UITableView!
    
}

