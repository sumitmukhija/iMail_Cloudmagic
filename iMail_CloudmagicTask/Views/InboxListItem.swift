//
//  InboxListItem.swift
//  iMail
//
//  Created by Sumit Mukhija on 02/07/16.
//  Copyright © 2016 Sumit Mukhija. All rights reserved.
//

import UIKit

class InboxListItem: UITableViewCell{
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var senderLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var previewLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    var starButtonTapAction:((UIButton)->())!

    @IBAction func starButtonTapped(sender: UIButton) {
        starButtonTapAction(sender)
    }
    override func awakeFromNib() {
        containerView.layer.cornerRadius = 4
    }
}