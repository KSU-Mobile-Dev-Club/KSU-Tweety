//
//  DetailViewController.swift
//  Tweety
//
//  Created by Reagan Wood on 4/5/18.
//  Copyright © 2018 RW Software. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var text: UITextView!
    
    @IBOutlet weak var publisher: UILabel!
    var text1: String = ""
    var publisher1: String = ""
    var image1: UIImage?
    override func viewWillAppear(_ animated: Bool) {
        if (image1 != nil) {
            profileImage.image = image1
        }
        text.text = text1
        publisher.text = publisher1
    }
}
