//
//  TweetTableViewCell.swift
//  Tweety
//
//  Created by Reagan Wood on 4/4/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import Foundation
import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweeter: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var favoritesCount: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    
}
